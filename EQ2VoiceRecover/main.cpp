#include <fstream>
#include <iostream>
#include <vector>
#include <map>
#include <cstring>

#ifdef BOINC_APPLICATION
#include "boinc_api.h"
#endif

using namespace std;
typedef unsigned char           int8;
typedef unsigned short          int16;
typedef unsigned int            int32;

typedef unsigned char           uint8;
typedef  signed  char           sint8;
typedef unsigned short          uint16;
typedef  signed  short          sint16;
typedef unsigned int            uint32;
typedef  signed  int            sint32;
typedef unsigned char           uchar;

int processBlock(int8* alldata, int8 key1, int8 key2, int8 key3, int8 key4, int8 key5, int8 key6, FILE* outFile);

int entries = 0;
std::map<int32, std::string> filenames;
int main(int argc, char** argv)
{
    std::string outputKey("");

#ifdef BOINC_APPLICATION
    boinc_init();
#endif

    FILE* file = fopen("testbin.dat", "r+b");
    fread(&entries, sizeof(int32), 1, file);
    if(entries < 1) {
	return 0;
    }
    
    string resolved_name("");
    FILE* outFile = NULL;

#ifdef BOINC_APPLICATION
	int retval = boinc_resolve_filename_s("out", resolved_name);
	if (!retval) {
		outFile = boinc_fopen(resolved_name.c_str(), "w+");
	}
#endif

	//printf("Entries found %u\n",entries);
    int8* mp3s = new int8[entries*10];
	int offset = 0;
	for(int i=0;i<entries;i++) {
		int filenamelength = 0;
		fread(&filenamelength, sizeof(int32), 1, file);
		char filename[256];
		fread(filename, sizeof(char), filenamelength, file);
		filename[filenamelength] = '\0';
		std::string fileNameStr = std::string(filename);
	//	printf("Entry adding (%u) %s\n",filenamelength,fileNameStr.c_str());
		filenames.insert(make_pair(i, fileNameStr));
		fread(&mp3s[offset], sizeof(unsigned char), 10, file);
		offset += 10;
	}
	
	fclose(file);

    int8 key[8];
    key[0] = 0xff;
    key[1] = 0xff;
    key[2] = 0xfF;
    key[3] = 0xff;
    key[4] = 0xFF;
    key[5] = 0xFF;
    key[6] = 0xFF;
    key[7] = 0xFF;
    bool bigtask = false;
    if (argc > 5) {
        for (int8 i = 0; i < 7; i++) {
            if (i >= argc - 1)
                break;
            key[i] = strtol(argv[i + 1], NULL, 16);
        }
        int total_found = processBlock(mp3s, key[0], key[1], key[2], key[3], key[4], key[5], outFile);
	if(outFile) {
		if(total_found > 0) {
			// do nothing
		}
		else {
                fwrite("0", sizeof(char), 1, outFile);
		}
		fclose(outFile);
	}

#ifdef BOINC_APPLICATION
	boinc_finish(0);
#endif

    return 0;
    }
    else{
	cout << "Usage: eq2_voice_recover [key1] [key2] [key3] [key4] [key5] [key6]\n";
	cout << "Example: eq2_voice_recover 91 CD E3 8F A6 93\n\n";
	cout << "NOTE: If you want to test it, rename all_data.bin to something else and rename all_data.bin.TEST to all_data.bin.\nOnce that is done the above example should find a match very quickly.\n";
    }
	if(outFile) {
		fwrite("0", sizeof(char), 1, outFile);
		fclose(outFile);
	}

#ifdef BOINC_APPLICATION
	boinc_finish(0);
#endif

    return 0;    
}

int processBlock(int8* alldata, int8 key1, int8 key2, int8 key3, int8 key4, int8 key5, int8 key6, FILE* outFile) {
    int total_found = 0;
    int8 key[8];
    key[0] = key1;
    key[1] = key2;
    key[2] = key3;
    key[3] = key4;
    key[4] = key5;
    key[5] = key6;
    key[6] = 255;
    key[7] = 255;
    int8 S[256];
    int8 keyinit[256];
    int8 expected_result[8] = { 0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00 };
    map<int8, map<int8, map<int8, vector<int32>>>> expected_result_lookup;
    int32 pos = 0;
    int8 test_byte = 0;
    int8 test_byte2 = 0;
    int8 test_byte3 = 0;
    int8* data = 0;
	int32 keys_tried = 0;
    for (int16 z = 0; z < entries; z++) {
        pos = z * 10;
        data = alldata + pos;
        test_byte = data[0] ^ expected_result[0];
        test_byte2 = data[1] ^ expected_result[1];
        test_byte3 = data[2] ^ expected_result[2];
        expected_result_lookup[test_byte][test_byte2][test_byte3].push_back(pos);
    }
    for (int i = 0; i < 256; i++)
        keyinit[i] = i;
    int16 total_work = 255 * 15;
    if (key6 != 255)
        total_work -= (255 - key6);
    int16 current_work = 0;
    int8 loop_count = 15;
    if (key[4] == 15)
        loop_count = 16; //we need to work on 0 as well, we start at 255
    for (int e = 0; e < loop_count;e++) {
        //cout << "key6: " << (int)key6 << ", key5: " << (int)key[4] << endl;
        for (sint16 f = key6; f >= 0; f--) {
            key[5] = f;
            for (sint16 g = 255; g >= 0; g--) {
                key[6] = g;
                for (sint16 h = 255; h >= 0; h--) {
					keys_tried++;
                    key[7] = h;
                    memcpy(S, keyinit, 256);
                    int16 j = 0;
                    int8 tmp = 0;
                    for (int i = 0; i < 256; i++) {
                        j = (j + S[i] + key[i % 8]) % 256;
                        tmp = S[j];
                        S[j] = S[i];
                        S[i] = tmp;
                    }
                    int16 i = 0;
                    j = 0;
                    tmp = 0;
                    int8 test_bytes[8];
                    bool success = false;
                    bool first_pass = false;
                    for (int x = 0; x < 8; x++) {
                        i = (i + 1);
                        j = (j + S[i]) % 256;
                        tmp = S[j];
                        S[j] = S[i];
                        S[i] = tmp;
                        test_bytes[x] = S[(S[i] + S[j]) % 256];
                        if (x < 3) {
                            if (x == 0 && expected_result_lookup.count(test_bytes[x]) == 0)
                                break;
                            if (x == 1 && expected_result_lookup[test_bytes[0]].count(test_bytes[x]) == 0)
                                break;
                            if (x == 2) {
                                if (expected_result_lookup[test_bytes[0]][test_bytes[1]].count(test_bytes[x]) == 0)
                                    break;
                                else
                                    first_pass = true;
                            }
                        }
                    }
					int whichKey = 0;
                    if (first_pass) {
                        vector<int32>::iterator data_itr;
                        for (data_itr = expected_result_lookup[test_bytes[0]][test_bytes[1]][test_bytes[2]].begin(); data_itr != expected_result_lookup[test_bytes[0]][test_bytes[1]][test_bytes[2]].end(); data_itr++) {
                            whichKey = *data_itr / 10;
							int8* data = alldata + *data_itr;
                            for (int8 x = 3; x < 8; x++) {
                                if ((test_bytes[x] ^ data[x]) != expected_result[x])
                                    break;
                                if (x == 7)
                                    success = true;
                            }
                        }
                    }
                    if (success) {			
                        string foundkey = "";
                        char output[4];
                        for (int o = 0; o < 8; o++) {
                            snprintf(output, 3, "%02X", (unsigned char)key[o]);
                            foundkey.append(output);
                        }
			if(outFile) {
	                        std::string data("FOUND KEY: " + foundkey + " based on key " + filenames[whichKey]);
				fwrite(data.c_str(),sizeof(char),data.size(),outFile);
			}
                        cout << "FOUND KEY: " << foundkey.c_str() << " based on key " << filenames[whichKey] << endl;
                        total_found += 1;
                    }
                }
            }
            current_work++;
        }
	double fraction = ((double)(current_work)) / ((double)total_work);
	if(fraction > 1.0) {
		fraction = 1.0;
	}

#ifdef BOINC_APPLICATION
	boinc_fraction_done(fraction);
#endif

       cout << "percent done: " << ((double)(current_work)) / ((double)total_work) << " keys tried " << keys_tried << endl;
        key6 = 255;
        if(key[4] > 0)
            key[4]--;
    }
    return total_found;
}
