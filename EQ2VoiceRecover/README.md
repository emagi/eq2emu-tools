# EQ2Voice Recovery Project BOINC Application - **PROTOTYPE BUILD**

**LINUX/WINDOWS SUPPORT ONLY AT THIS TIME**

This is released for the sake of being open about what our code is doing for the BOINC project and please keep in mind the adhoc process it was put together, back in 2020 by LethalEncounter and the new integration to BOINC by Image/Emagi in 2023.

Visit http://boinc.eq2emu.com/cplan/ for more project details.  This BOINC Application is used inside the EQ2 Voice Recovery project in attempt to brute force RC4 64-bit encryption keys used on MP3 NPC Voices.

### Building/Compiling

Linux
- apt-get install libboinc-app-dev
- Obtain BOINC source, find more details here https://boinc.berkeley.edu/trac/wiki/SourceCodeGit
- Edit compile.sh with nano/vi/other utility, -I./boinc-src/lib/ should point to the boinc source's lib folder pulled from the first step
- bash -x compile.sh

Windows
- Visual Studio 2019+ and install without the boinc defines for now unless you really want to combine BOINC for windows.
- windows/visual studio: https://boinc.berkeley.edu/trac/wiki/CompileClient#VisualStudio2013CommunityEditionBuildEnvironment
- get source (Windows directory has the setup): https://github.com/BOINC/boinc
- install and compile openssh https://github.com/openssl/openssl/blob/master/NOTES-WINDOWS.md#native-builds-using-visual-c
- https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win64/
- https://strawberryperl.com/

## Authors

Project team site at [EQ2EMu](https://www.eq2emu.com) and [ZekLabs](https://www.zeklabs.com)

## License

This project is licensed under the GNU General Public License - see the [LICENSE.md](LICENSE.md) file for details