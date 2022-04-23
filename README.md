# IAGL-Mame.AHK
IAGL Mame.AHK let you download and launch Retro Games

# Instalation:
1) You need to Mame.exe
2) IAGL Mame.AHK OR IAGL Mame.exe

# Configuration:
1) Download Mame 7zip self extractor exe Latest from https://www.mamedev.org/release.html
. Download Mame 7zip self extractor exe older versions from https://www.mamedev.org/oldrel.html

2) We just Need Latest Mame.exe, You can use extracting tool to extract Mame.exe and
. rename mame.exe according to the version read ROM Support Mame Version issues,

3) Place Mame.exe(s) and IAGL Mame.AHK to into some folder and run IAGL Mame.AHK/IAGL Mame.exe

4) One fresh start RUN it will create ROM list and parse
. that list to remove 'Clones ROMs' for why Read 'Clones'
. if you have downloaded complied zip It has Regenerated ROM list from Mame 207
. if you wana recreate latest ROMList plz delete UI folder and place only latest Mame*.exe

5) We need Latest Mame.exe to generate Latest List after
. ROM list generation you can place older version Mame.exe
. read 'ROM Support Mame Version issues:'

# Usage:
1) write any Game name inside Game Title click Look button
. it will create filter game SNO|Title|ROM|Download Status
2) Double click on required Row to download ROM
. it will try to Download and rom and show to the status Downloading...
. Status will changed to Downloaded when ROM download complete
3) Double click again on any ROM showing status Downloaded
. will launch the downloaded Game using Mame selected version
4) While ROM downloading please wait for download complete,
. Please do not Close IAGL Mame.ahk if close/ crashed while ROM Download
. you will endup having corrupt ROM.zip in ROM Folder which you have to identify and delete
5) Mame Ver: dropdown will let you let you Launch Game using
. different Mame versions read 'ROM Support Mame Version issues'
6) ROM files will remain in ROM folder, you Can manually delete them to re-download
. program will show downloaded ROM every re-run

# Rom Bios:
You can google "what are Mame Bios files?"
Simply we need those bios files in order to run games,
We can download all bios files using IAGL Mame.ahk
1) write *Bios* inside Game Title and hit Look button
2) for NeoGeo Bios files you need to write *neogeo* Look button we just need neogeo.zip
3) Few Bios files do not mention word Bios in Title like NeoGeo so you should know
. which BIOS files your Game Needs

# Clones:
Every Game ROM has clone but I prefer Original Game as Clone ROM sometime do not
have all the files required to launch the game, and in some case Internet Archive provide
ROM.zip having all the clone rename by Main ROM.zip which we can run using Mame.exe
it will need more coding i tried my best to make this code simple as I could.


# ROM Support Mame Version issues:
I am not sure ROMs available on Internet Archive website are latest or old but
they do support arcade emulators from batocera / retroarch, LibreELEC on kodi.
but Mame releasing newer version every now and then and roms needs to be updated
to support Mame emulator so here is a solution which I implemented
1) You can place multiple Mame.exe and rename by they release versions
. i.e (Mame*.exe) where '*' can be replace verion i.e Mame 207.exe
2) Now you can select Mame Versions from available dropdown
3) i wish if someone can point out what version of Mame.exe would run all rom without issue to sort out this hassle

## Disclaimer:
I do not Own/Wrote MAME or Inernet Archive
I have just wrote a piece of AHK Code namely 'IAGL Mame.AHK' that download ROM
which any one can download manually its there 'IAGL Mame.AHK' generate list of
or ROMs using Mame.exe command line and parses, Please Download Authentic Mame.exe
I wrote this for Educational and Gaming purpose.
