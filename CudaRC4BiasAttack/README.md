# CUDA RC4 Bias Attack - **PROTOTYPE**

Uses a CSV (unknown.csv) which defines a filename and the encrypted hex "4944330300000000".

We extract the keystream from the unknowns and attack RC4 keys at random to identify similarities in the keystream bytes to create a mapping of similar keyspaces.

**LINUX ONLY AT THIS TIME**

### Building/Compiling
Ubuntu/Debian
- sudo apt update
- sudo apt install nvidia-driver-460  
- sudo apt install nvidia-cuda-toolkit
- make

Fedora/RHEL
- sudo dnf install akmod-nvidia
- sudo dnf install cuda
- make

Debian 12
- wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/7fa2af80.pub
- sudo mv 7fa2af80.pub /etc/apt/trusted.gpg.d/nvidia.asc
- echo "deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /" | sudo tee /etc/apt/sources.list.d/cuda.list
- sudo apt update
- sudo apt install build-essential linux-headers-$(uname -r)
- sudo apt install nvidia-driver
- sudo reboot
- sudo apt install cuda
- export PATH=/usr/local/cuda/bin:$PATH
- export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
- source ~/.bashrc
- make


## Authors

Project team site at [EQ2EMu](https://www.eq2emu.com) and [ZekLabs](https://www.zeklabs.com)

## License

This project is licensed under the GNU General Public License - see the [LICENSE.md](LICENSE.md) file for details