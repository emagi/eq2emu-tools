// best_key_with_candidates_atomic.cu
#include <cuda.h>
#include <chrono>
#include <curand_kernel.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <cstdint>
#include <algorithm>
#include <cctype>

#define PLAINTEXT_LEN 8
#define MAX_BIAS 7
#define MAX_BEST 20
#define MIN_SCORE 5
// Known plaintext: hex 4944330300000000
__device__ __constant__ unsigned char d_plaintext[PLAINTEXT_LEN] = {
	0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00
};

// Device structure for candidate targets (using packed key/keystream).
struct CandidateDevice {
	unsigned char target[PLAINTEXT_LEN];      // Candidate target keystream (8 bytes)
	unsigned int best_score[MAX_BEST];                  // Highest score found so far
	unsigned long long best_key[MAX_BEST];              // Packed 8-byte key (lower 8 bits of each byte stored in 64-bit)
	unsigned long long best_keystream[MAX_BEST];        // Packed 8-byte produced keystream
};

// Host structure for candidate targets.
struct CandidateTarget {
	std::string identifier;                 // For example, a filename or record ID
	std::vector<unsigned char> target;      // 8-byte candidate target keystream
	unsigned int best_score[MAX_BEST];                // Best match score (from device)
	std::vector<unsigned char> best_key[MAX_BEST];      // Best matching sample's key (8 bytes)
	std::vector<unsigned char> best_keystream[MAX_BEST]; // Best matching sample's produced keystream (8 bytes)
};

// Helper: Pack 8 bytes into a 64-bit unsigned integer.
__host__ __device__ unsigned long long pack8(const unsigned char bytes[PLAINTEXT_LEN]) {
	unsigned long long packed = 0;
	for (int i = 0; i < PLAINTEXT_LEN; i++) {
		packed |= ((unsigned long long)bytes[i]) << (8 * i);
	}
	return packed;
}

// Device function: binary search for the first candidate whose first 4 bytes match the given prefix.
// Assumes candidates[] is sorted in ascending order based on the first 4 bytes.
__device__ int binary_search_candidate_start(const CandidateDevice* candidates, int candidate_count, unsigned int prefix) {
	int low = 0;
	int high = candidate_count - 1;
	int result = -1;
	while (low <= high) {
		int mid = (low + high) >> 1;
		// Treat the first 4 bytes of target as a 32-bit unsigned integer.
		unsigned int candidate_prefix = *(unsigned int*)(candidates[mid].target);
		if (candidate_prefix < prefix) {
			low = mid + 1;
		}
		else if (candidate_prefix > prefix) {
			high = mid - 1;
		}
		else {
			result = mid;
			// Continue searching left to find the first occurrence.
			high = mid - 1;
		}
	}
	return result;
}

// Kernel: process a batch of RC4 samples and update candidate results.
// For each sample, for each candidate, we compute a match score (number of bytes where sample's keystream equals candidate target).
// If the score exceeds the candidate's best_score, we use atomicMax to update best_score and then update best_key and best_keystream.
__global__ void process_samples_with_candidates(uint64_t num_samples, curandStatePhilox4_32_10_t* states,
	unsigned long seed, CandidateDevice* d_candidates,
	int candidate_count) {
	uint64_t idx = blockIdx.x * blockDim.x + threadIdx.x;
	if (idx >= num_samples) return;

	// Initialize cuRAND state.
	curand_init(seed, idx, 0, &states[idx]);

	// Generate an 8-byte random key.
	unsigned char key[PLAINTEXT_LEN];
	unsigned int r = curand(&states[idx]);
	for (int i = 0; i < PLAINTEXT_LEN; i++) {
		// Combine different byte positions from r.
		key[i] = static_cast<unsigned char>(r & 0xFF);
		r = curand(&states[idx]);
	}

	// RC4 encryption: initialize state S.
	unsigned char S[256];
	for (int i = 0; i < 256; i++) {
		S[i] = i;
	}
	int j = 0;
	for (int i = 0; i < 256; i++) {
		j = (j + S[i] + key[i % PLAINTEXT_LEN]) & 0xFF;
		unsigned char temp = S[i];
		S[i] = S[j];
		S[j] = temp;
	}
	// Generate PLAINTEXT_LEN bytes (PRGA).
	int i = 0;
	j = 0;
	unsigned char ks[PLAINTEXT_LEN];
	for (int k = 0; k < PLAINTEXT_LEN; k++) {
		i = (i + 1) & 0xFF;
		j = (j + S[i]) & 0xFF;
		unsigned char temp = S[i];
		S[i] = S[j];
		S[j] = temp;
		ks[k] = S[(S[i] + S[j]) & 0xFF];
	}
	unsigned int sample_prefix = *(unsigned int*)(ks);
	int start = binary_search_candidate_start(d_candidates, candidate_count, sample_prefix);
	if (start < 0)
		return;
	// Compute score for each candidate.
	for (int c = start; c < candidate_count; c++) {
		unsigned int candidate_prefix = *(unsigned int*)(d_candidates[c].target);
		if (candidate_prefix != sample_prefix)
			break;
		unsigned int score = 4;
		for (int b = 4; b < MAX_BIAS + 1; b++) {
			if (ks[b] == d_candidates[c].target[b])
				score++;
			else
				break;
		}
		if (score < MIN_SCORE) {
			continue;
		}
		for (int i = 0; i < MAX_BEST; i++) {
			// Use atomicMax to update candidate best_score.
			unsigned int old = atomicMax(&d_candidates[c].best_score[i], score);
			if (score > old) {
				// Pack key and keystream.
				unsigned long long packed_key = pack8(key);
				unsigned long long packed_ks = pack8(ks);
				// Update best_key and best_keystream.
				d_candidates[c].best_key[i] = packed_key;
				d_candidates[c].best_keystream[i] = packed_ks;
				break;
			}
		}
	}
}

//
// Host main function.
//
int main(int argc, char* argv[]) {
	// Expect a CSV file containing candidate records.
	// CSV format: header, then each row: identifier,encrypted_hex_data
	// encrypted_hex_data is the RC4 encryption of the known plaintext.
	// Candidate target keystream is recovered as: target = encrypted XOR known_plaintext.
	char buffer[3];
	if (argc < 2) {
		std::cerr << "Usage: " << argv[0] << " <candidate_csv_file>\n";
		return 1;
	}
	std::string csv_filename = argv[1];
	std::ifstream infile(csv_filename);
	if (!infile.is_open()) {
		std::cerr << "Failed to open CSV file: " << csv_filename << "\n";
		return 1;
	}
	std::vector<CandidateTarget> candidates;
	std::string line;
	// Skip header.
	std::getline(infile, line);
	while (std::getline(infile, line)) {
		std::istringstream ss(line);
		std::string identifier, encrypted_hex_data;
		if (!std::getline(ss, identifier, ',')) continue;
		if (!std::getline(ss, encrypted_hex_data, ',')) continue;
		// Remove whitespace.
		encrypted_hex_data.erase(std::remove_if(encrypted_hex_data.begin(), encrypted_hex_data.end(), ::isspace),
			encrypted_hex_data.end());
		if (encrypted_hex_data.size() != PLAINTEXT_LEN * 2) {
			std::cerr << "Skipping " << identifier << ": encrypted data length "
				<< encrypted_hex_data.size() << " does not match expected " << PLAINTEXT_LEN * 2 << "\n";
			continue;
		}
		CandidateTarget cand;
		cand.identifier = identifier;
		for (int b = 0; b < MAX_BEST; b++) {
			cand.best_score[b] = 0;
			cand.best_key[b].resize(PLAINTEXT_LEN, 0);
			cand.best_keystream[b].resize(PLAINTEXT_LEN, 0);
		}
		// Parse the encrypted hex data into 8 bytes.
		std::vector<unsigned char> encrypted;
		for (int i = 0; i < PLAINTEXT_LEN; i++) {
			std::string byte_str = encrypted_hex_data.substr(i * 2, 2);
			unsigned int byte;
			std::stringstream ss_byte;
			ss_byte << std::hex << byte_str;
			ss_byte >> byte;
			encrypted.push_back(static_cast<unsigned char>(byte));
		}
		// Recover candidate target: target = encrypted XOR known_plaintext.
		unsigned char known[PLAINTEXT_LEN] = { 0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00 };
		for (int i = 0; i < PLAINTEXT_LEN; i++) {
			cand.target.push_back(encrypted[i] ^ known[i]);
		}
		candidates.push_back(cand);
	}
	infile.close();
	if (candidates.empty()) {
		std::cerr << "No valid candidate records loaded from CSV.\n";
		return 1;
	}
	std::cout << "Loaded " << candidates.size() << " candidate targets from CSV.\n";

	// Allocate and initialize device candidate array.
	int candidate_count = candidates.size();
	std::sort(candidates.begin(), candidates.end(), [](const CandidateTarget& a, const CandidateTarget& b) {
		// Assemble the first 4 bytes into an unsigned int in big-endian order.
		const unsigned int* prefix_a = reinterpret_cast<const unsigned int*>(a.target.data());
		const unsigned int* prefix_b = reinterpret_cast<const unsigned int*>(b.target.data());
		return *prefix_a < *prefix_b;
		});

	std::vector<CandidateDevice> h_candidates(candidate_count);

	for (int i = 0; i < candidate_count; i++) {
		for (int b = 0; b < PLAINTEXT_LEN; b++) {
			h_candidates[i].target[b] = candidates[i].target[b];
		}
		for (int m = 0; m < MAX_BEST; m++) {
			h_candidates[i].best_score[m] = 0;
			h_candidates[i].best_key[m] = 0;
			h_candidates[i].best_keystream[m] = 0;
		}
	}

	CandidateDevice* d_candidates;
	cudaMalloc(&d_candidates, candidate_count * sizeof(CandidateDevice));
	cudaMemcpy(d_candidates, h_candidates.data(), candidate_count * sizeof(CandidateDevice), cudaMemcpyHostToDevice);

	// Simulation parameters.
	uint64_t total_samples = 100000000ULL; // Adjust as needed.
	uint64_t batch_size = 10000000ULL;     // Process this many samples per batch.

	curandStatePhilox4_32_10_t* d_states;
	cudaMalloc(&d_states, batch_size * sizeof(curandStatePhilox4_32_10_t));

	for (int r = 0; r < 100000; r++) {
		auto start_time = std::chrono::high_resolution_clock::now();
		// Process simulation in batches.
		uint64_t processed = 0;
		while (processed < total_samples) {
			unsigned long long seed;
			FILE* fp = fopen("/dev/urandom", "rb");
			if (!fp) {
				perror("Unable to open /dev/urandom");
				exit(EXIT_FAILURE);
			}
			if (fread(&seed, sizeof(seed), 1, fp) != 1) {
				perror("Failed to read seed");
				fclose(fp);
				exit(EXIT_FAILURE);
			}
			fclose(fp);
			uint64_t current_batch = (total_samples - processed < batch_size) ? (total_samples - processed) : batch_size;
			int threadsPerBlock = 256;
			int blocks = (current_batch + threadsPerBlock - 1) / threadsPerBlock;
			process_samples_with_candidates << <blocks, threadsPerBlock >> > (current_batch, d_states, seed, d_candidates, candidate_count);
			cudaDeviceSynchronize();
			processed += current_batch;
			auto current_time = std::chrono::high_resolution_clock::now();
			double elapsed_seconds = std::chrono::duration<double>(current_time - start_time).count();
			double millions_per_sec = processed / (elapsed_seconds * 1e6);
			std::cout << "Processed " << processed
				<< " samples (" << millions_per_sec << " million/sec)"
				<< std::endl;
		}

		// Copy candidate results back to host.
		cudaMemcpy(h_candidates.data(), d_candidates, candidate_count * sizeof(CandidateDevice), cudaMemcpyDeviceToHost);

		// Update host candidate structures with best results.
		for (int i = 0; i < candidate_count; i++) {
			for (int m = 0; m < MAX_BEST; m++) {
				candidates[i].best_score[m] = h_candidates[i].best_score[m];
				// Unpack best_key and best_keystream.
				candidates[i].best_key[m].resize(PLAINTEXT_LEN, 0);
				candidates[i].best_keystream[m].resize(PLAINTEXT_LEN, 0);
				unsigned long long packed_key = h_candidates[i].best_key[m];
				unsigned long long packed_ks = h_candidates[i].best_keystream[m];
				for (int b = 0; b < PLAINTEXT_LEN; b++) {
					candidates[i].best_key[m][b] = (packed_key >> (8 * b)) & 0xFF;
					candidates[i].best_keystream[m][b] = (packed_ks >> (8 * b)) & 0xFF;
				}
			}
		}

		std::ofstream outFile("output.txt", std::ios::out | std::ios::trunc);
		if (!outFile) {
			std::cerr << "Error opening file!" << std::endl;
			continue;
		}

		for (int i = 0; i < candidate_count; i++) {
			bool wroteHeader = false;
			for (int m = 0; m < MAX_BEST; m++) {
				if (candidates[i].best_score[m] < MIN_SCORE) {
					continue;
				}
				if (!wroteHeader) {
					outFile << "Candidate," << candidates[i].identifier << ",";
					for (int b = 0; b < PLAINTEXT_LEN; b++) {
						// Format the byte as a two-digit hexadecimal string
						std::sprintf(buffer, "%02x", static_cast<unsigned int>(candidates[i].target[b]));
						outFile << buffer;
					}
					outFile << "\n";
				}
				wroteHeader = true;
				outFile << "Match,";
				for (int b = 0; b < PLAINTEXT_LEN; b++) {
					std::sprintf(buffer, "%02x", static_cast<unsigned int>(candidates[i].best_key[m][b]));
					outFile << buffer;
				}
				outFile << ",";
				for (int b = 0; b < PLAINTEXT_LEN; b++) {
					std::sprintf(buffer, "%02x", static_cast<unsigned int>(candidates[i].best_keystream[m][b]));
					outFile << buffer;
				}
				outFile << "," << candidates[i].best_score[m] << "\n";
			}
			if (wroteHeader) {
				outFile << "\n";
			}
		}
		outFile.close();

	}
	cudaFree(d_candidates);
	cudaFree(d_states);
	return 0;
}
