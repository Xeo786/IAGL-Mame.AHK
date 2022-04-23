/*
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	IAGL:	Internet Archive Game Launcher
	MAME:	Multiple Arcade Machine Emulator
	
	IAGL Mame.AHK let you download and launch Retro Game 
	
	About Mame:
	https://en.wikipedia.org/wiki/MAME
	
	Instalation:
	1) You need to Mame.exe
	2) IAGL Mame.AHK
	
	Configuration:
	1) Download Mame 7zip self extractor exe Latest from https://www.mamedev.org/release.html 
	.  Download Mame 7zip self extractor exe older versions from https://www.mamedev.org/oldrel.html
	
	2) We just Need Latest Mame.exe, You can use extracting tool to extract Mame.exe and 
	.  rename mame.exe according to the version read ROM Support Mame Version issues,
	
	3) Place Mame.exe and IAGL Mame.AHK to into some folder and run IAGL Mame.AHK
	
	4) One fresh start RUN it will create ROM list and parse 
	.  that list to remove 'Clones ROMs' for why Read 'Clones'
	
	5) We need Latest Mame.exe to generate Latest List after 
	.  ROM list generation you can place older version Mame.exe
	.  read 'ROM Support Mame Version issues:'
	
	Useage:
	1) write any Game name inside Game Title click Look button, you can use wild card "*" or regex excluding (.*)
	.  it will create filter game SNO|Title|ROM|Download Status
	2) Double click on required Row to download ROM 
	.  it will try to Download and rom and show to the status Downloading...
	.  Statius will changed to Downloaded when ROM download complete
	3) Double click again on any ROM showing status Downloaded 
	.  will launch the downloaded Game using Mame selected version
	4) While ROM downloading please wait for download complete, 
	.  Please do not Close IAGL Mame.ahk if close/ crashed while ROM Download
	.  you will endup having currupt ROM.zip in ROM Folder which you have to identify and delete 
	5) Mame Ver dropdown will let you let you Launch Game using 
	.  different Mame versions read 'ROM Support Mame Version issues'
	
	Rom Bios:
	You can google "what are Mame Bios files?"
	Simply we need those bios files in order to run games, 
	We can download all bios files using IAGL Mame.ahk
	1) write *Bios* inside Game Title and hit Look button
	2) for NeoGeo Bios files you need to write *neogeo* Look button we just need neogeo.zip
	3) Few Bios files do not mention word Bios in Title like NeoGeo so you should know 
	.  which BIOS files your Game Needs
	
	CLones:
	Every Game ROM has clone but I prefer Original Game as Clone ROM sometime do not 
	have all the files required to launch the game, and in some case Internet Archive provide 
	ROM.zip having all the clone rename by Main ROM.zip which we can run using Mame.exe 
	it will need more coding itried my best to make this code simple as I can
	
	
	ROM Support Mame Version issues:
	I am not sure ROMs available on Internet Archive website are latest or old but 
	they do support arcade emulator from batocera / retroarch, LibreELEC on kodi. 
	but Mame releasing newer version every now and then and roms needs to be updated 
	to support Mame emulator so here is a solution which I implimented
	1) You can place multiple Mame.exe and rename by release versions 
	.  i.e (Mame*.exe) where '*' can be replace version i.e Mame 207.exe
	2) Now you can select Mame Versions from available dropdown 
	3) i wish if someone can point out what version of Mame.exe would run all rom without issue to sort out this hassle 
	
	Disclamer:
	I am do not Own/Wrote MAME or Inernet Archive
	I have just wrote a peice of AHK Code namely 'IAGL Mame.AHK' that download ROM 
	which any one can download manually its there 'IAGL Mame.AHK' generate list of 
	or ROMs using Mame.exe command line and parses, Please Download Authentic Mame.exe
	I wrote this for Educational and Gaming purpose.
	
	By XEO786
	Link: 	https://www.autohotkey.com/boards/viewtopic.php?f=19&t=101375&p=450487#p450487
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

if check()
	CreateROMtxt()
Menu, Tray, Icon , IAGL AHK.ico,,,4
FileRead, Mamexml, % A_ScriptDir "\ui\MameROM.txt"
global x, ROM
loop, files, % A_ScriptDir "\Mame*.exe"
{
	if a_index = 1
		emufiles .= A_LoopFileName "|"
	else 	
		emufiles .= "|" A_LoopFileName
}

Gui Add, DropDownList, x10 y15 w67 vGhead, Game:||ROM:
Gui Add, Edit, x86 y17 w120 h21 vGtitle
Gui Add, text, x300 y15 h23 +0x200, Mame Ver:
Gui Add, DropDownList, x355 y17 w200 vEmu,  % emufiles
Gui Add, ListView, x7 y44 w593 h355 vMameLV gMameLV, SNo.|Title|ROM|Downloaded
Gui Add, Button,  x213 y14 w82 h26 gLook, Look
i := 0
loop, files, % A_ScriptDir "\roms\*.zip"
{
	FileGetSize, size, % romLocaton
	if(size = 0)
	{
		FileDelete, % romLocaton
		continue
	}
	SplitPath, A_LoopFileFullPath,,,,ROM
	param = i)\n%ROM%[\s]+"([:\w\d\s\/()-]+)"
	if RegExMatch(Mamexml,param,f)
	{
		if instr(f1,"BIOS")
			continue
		LV_Add("", format("{:02}",++i),f1,ROM,"Downloaded")
	}
}
LV_ModifyCol()
Gui Show, w600 h400, IAGL AHK
Return

GuiEscape:
GuiClose:
ExitApp


Look:
Gui Submit, Nohide
Gui ListView, % "MameLV"
if( Ghead = "Game:")
{
	if Gtitle
	{
		Gtitle := StrReplace(Gtitle,"*",".*")
		Gtitle := StrReplace(Gtitle,"neogeo","neo-?geo")
		paramx = i)([\w]+)[\s]+"(%Gtitle%[:\w\d\s\/()-]+)"
	}
	else
		return
}
else
{
	if Gtitle
	{
		paramx = i)(%Gtitle%[\w]+)[\s]+"([:\w\d\s\/()-]+)"
	}
	else
		return
}

LV_Delete()
Pos := 1, f := 0, i := 0
While (Pos := RegExMatch(Mamexml,paramx,f, Pos + StrLen(f)))
{
	++i
	if FileExist(A_ScriptDir "\roms\" f1 ".zip")
		stats := "downloaded"
	else
		stats := ""
	LV_Add("", format("{:02}",i),f2,f1,stats)
}
LV_ModifyCol()
return

MameLV:
gui, Submit, NoHide

if (A_GuiEvent = "DoubleClick")
{
	LV_GetText(ROM, A_EventInfo,3) 
	romLocaton := A_ScriptDir "\roms\" ROM ".zip"
	Mameloc := A_ScriptDir "\" emu
	if !FileExist(Mameloc)
	{
		msgbox, Unable to Find Mame.exe`nExitting...!
		exitapp
	}
	
	Launchgame := Mameloc " " chr(34) romLocaton chr(34)
	if FileExist(romLocaton)
	{
		gui, Destroy
		runwait, % Launchgame
	}
	else
		downloadrom(ROM,A_EventInfo)
}

if (A_GuiEvent = "RightClick")
	Menu, MyMenu, Show

sleep, 200
ToolTip
if !WinExist("IAGL AHK")
	reload
return


downloadrom(ROM,x)
{
	Gui ListView, % "MameLV" 
	LV_Modify(x,,,,,"Downloading.." romLocaton )
	LV_ModifyCol()
	zipfiles := getromfiles(ROM)
	if zipfiles.length()
	{
		for zip, size in zipfiles
		{
			romLocaton := A_ScriptDir "\roms\" zip
			SetTimer, DP, 800
			URLDownloadToFile, % Getromzip(ROM,zip) , % romLocaton
			SetTimer, DP, off
			LV_Modify(x,,,,,"Downloaded")
			LV_ModifyCol()
		}
	}
	else
	{
		try
		{
			LastSize := Size := Request(GetMameMerge(ROM))
		}
		catch e 
		{
			LV_Modify(x,,,,,"Failed")
			LV_ModifyCol()
			return
		}
		SetTimer, DP, 600
		romLocaton := A_ScriptDir "\roms\" ROM ".zip"
		URLDownloadToFile, % GetMameMerge(ROM) , % romLocaton
		SetTimer, DP, off
		LV_Modify(x,,,,,"Downloaded")
		LV_ModifyCol()
	}
	return
	
	DP: ; https://www.autohotkey.com/board/topic/101007-super-simple-download-with-progress-bar/
	CurrentSize := FileOpen(romLocaton, "r").Length
	CurrentSizeTick := A_TickCount
	Speed := Round((CurrentSize/1024-LastSize/1024)/((CurrentSizeTick-LastSizeTick)/1000)) . " Kb/s"
	LastSizeTick := CurrentSizeTick
	LastSize := FileOpen(romLocaton, "r").Length
	PercentDone := Round(CurrentSize/Size*100)
	LV_Modify(x,,,,,"Speed: " Speed " Downloading: " PercentDone "%"  )
	LV_ModifyCol()
	return
}

Request(url) {
	
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	;WebRequest.Option(6) := true ; No redirects
	WebRequest.Open("HEAD", url, false)
	WebRequest.Send()
	;WebRequest.WaitForResponse()
	return WebRequest.GetResponseHeader("Content-Length")
}


GetMetalink(ROM)
{
	return "https://cors.archive.org/cors/arcade_" ROM "/arcade_" ROM "_meta.xml"
}

getromfiles(ROM)
{
	txt := DownloadToString(GetFilesLink(Rom))
	Pos := 1
	files := []
	paramy = "([\d\w\w_]+.zip)".*\n.*\n.*<size>(\S+)<\/size>
	While (Pos := RegExMatch(txt, paramy ,f, Pos + StrLen(f)))
	{
		files[f1] := f2
	}
	return files
}


GetFilesLink(Rom)
{
	return "https://cors.archive.org/cors/arcade_" ROM "/arcade_" ROM "_files.xml"
}

Getromzip(ROM,zip)
{
	return "https://cors.archive.org/cors/arcade_" ROM "/" zip ".zip"
}

GetMameMerge(ROM)
{
	return "https://archive.org/download/mame-merged/mame-merged/" ROM ".zip"
}

DownloadToString(url, encoding = "utf-8")
{
	static a := "AutoHotkey/" A_AhkVersion
	if (!DllCall("LoadLibrary", "str", "wininet") || !(h := DllCall("wininet\InternetOpen", "str", a, "uint", 1, "ptr", 0, "ptr", 0, "uint", 0, "ptr")))
		return 0
	c := s := 0, o := ""
	if (f := DllCall("wininet\InternetOpenUrl", "ptr", h, "str", url, "ptr", 0, "uint", 0, "uint", 0x80003000, "ptr", 0, "ptr"))
	{
		while (DllCall("wininet\InternetQueryDataAvailable", "ptr", f, "uint*", s, "uint", 0, "ptr", 0) && s > 0)
		{
			VarSetCapacity(b, s, 0)
			DllCall("wininet\InternetReadFile", "ptr", f, "ptr", &b, "uint", s, "uint*", r)
			o .= StrGet(&b, r >> (encoding = "utf-16" || encoding = "cp1200"), encoding)
		}
		DllCall("wininet\InternetCloseHandle", "ptr", f)
	}
	DllCall("wininet\InternetCloseHandle", "ptr", h)
	return o
}

check()
{
	if !fileexist(A_ScriptDir "\Mame*.exe")
	{
		msgbox, unable to to find Mame.exe/Mame*.exe....`nexitting...
		exitapp
	}
	
	if !fileexist(A_ScriptDir "\roms")
	{
		msgbox, unable to to find roms folder....`nexitting...
		exitapp
	}
	
	if !fileexist(A_ScriptDir "\ui")
	{
		FileCreateDir, % A_ScriptDir "\ui"
		while !fileexist(A_ScriptDir "\ui")
			sleep, 200
	}
	
	if !fileexist(A_ScriptDir "\ui\MameROM.txt")
		return 1
}

CreateROMtxt()
{
	msgbox, % "Note:"
	. "unable to find MameROM.txt ....!`n`n"
	. A_ScriptName " going to create MameROM.txt using Mame.exe"
	. "`nPlease Make sure you are using Latest Mame.exe"
	. "`nThis will only One time run. `nPlease be wait..."
	
	loop, files, % A_ScriptDir "\Mame*.exe"
	{
		mame := A_LoopFileFullPath
		break
	}
	msgbox, % mame
	while fileexist(A_ScriptDir "\ui\MameAll.txt")
		FileDelete % A_ScriptDir "\ui\MameAll.txt"
	
	while fileexist(A_ScriptDir "\ui\clones.txt")
		FileDelete % A_ScriptDir "\ui\clones.txt"
	
	runwait % comspec " /c " chr(34)  mame chr(34)   " -listfull > MameAll.txt"
	while !fileexist(A_ScriptDir "\ui\MameAll.txt") 
		FileMove % A_ScriptDir "\MameAll.txt",% A_ScriptDir "\ui\MameAll.txt"
	runwait % comspec " /c " chr(34)  mame chr(34)  " -listclones > clones.txt"
	while !fileexist(A_ScriptDir "\ui\clones.txt") 
		FileMove % A_ScriptDir "\clones.txt",% A_ScriptDir "\ui\clones.txt"
	sleep, 200
	removeclones()
}

removeclones() ; code I used to remove clones
{
	mameAllList := A_ScriptDir "\ui\MameAll.txt"
	mameClonesList := A_ScriptDir "\ui\clones.txt"
	
	if !FileExist(mameAllList) && !FileExist(mameClonesList)
	{
		msgbox, file not found exitting
		exitapp
	}
	
	FileRead, Mameall, % mameAllList
	FileRead, MameClones, % mameClonesList
	MainMainfile := A_ScriptDir "\ui\MameROM.txt"
	paramx = ([\w_\d]+)[\s]+"([:\w\d\s\/()-]+)"
	Pos := 1, f := 0, i := 0
	MameFinalList := []
	While (Pos := RegExMatch(Mameall,paramx,f, Pos + StrLen(f)))
	{
		if RegExMatch(MameClones, xx := "\n" f1 "[\s]+([\w\d]+)",m)
		{
			ToolTip, % "removing clones...!`n" "Name:" f2 "ROM:" f1
		}
		else
			MameFinalList[f1] := f2	
	}
	
	romz := ""
	for k, v in MameFinalList
	{
		romz .= k "    " chr(34) v chr(34) "`n"
		ToolTip, % "Parsing Final ROM list `nRom Name: " v "`nPlease wait..... "
	}
	FileAppend, % romz ,% MainMainfile
	ToolTip
	msgbox, ROMs Data Base have been Made and save to`nLocation: %MainMainfile%
}
