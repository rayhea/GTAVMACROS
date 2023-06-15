;https://www.autohotkey.com/board/topic/149458-gta-online-quick-menu-macros/
;/////////////////////////////////////////////////////////////////////////////////
;INIT

IF NOT A_IsAdmin
{ 
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}
#Persistent
#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force

target = ahk_exe GTA5.exe


;#InstallMouseHook
;#InstallKeybdHook
;#UseHook
#MenuMaskKey vkE8

#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000

#KeyHistory 0

LLdefault := "On"
ListLines()

SetStoreCapsLockMode Off

;SendMode Input

;/////////////////////////////////////////////////////////////////////////////////

If !FileExist("%A_WorkingDir%\temp")
	FileCreateDir, %A_WorkingDir%\temp

SavePath = %A_WorkingDir%\temp\data\save.ini

#include %A_WorkingDir%\temp\lib\default.ahk

path3 = %A_ScriptDir%\temp\img\part2
path4 = %A_ScriptDir%\temp\img\part3

quickpath = %A_WorkingDir%\setup\Quickpeek.txt

;/////////////////////////////////////////////////////////////////////////////////
;Alarm Variables Do not change

SoundPath = %A_WorkingDir%\temp\other\beepbeep.mp3
SoundPath2 = %A_WorkingDir%\temp\other\beep.mp3
SoundPath3 = %A_WorkingDir%\temp\other\ErrorAlert.mp3

;/////////////////////////////////////////////////////////////////////////////////
;Timers

Snooze := 600000 ; milliseconds = minutes*60*1000

AutoOpenHotkey := -120000

;/////////////////////////////////////////////////////////////////////////////////
;mics

readinit(SavePath,"Mics","WheelMode")
readinit(SavePath,"Mics","DoNotDial")

;/////////////////////////////////////////////
;CrossHair

#include %A_WorkingDir%\temp\lib\gdefault.ahk

gSavePath = %A_WorkingDir%\temp\data\list.ini

gui_position := ""

cbStr := ""
readinit(gSavePath,"default","cbStr")
cbArr := cbparse(cbStr,LoadedSection)
cbStr := cbjoin(cbArr,LoadedSection)

ShowCh := false

TabSelected := 1
tbpipeline := "Main|Chs|Misc|Other|Sys"

dblSelected := 1
dblpipeline := "Fingerprint Scanner|Keypad Cracker|Retro Fingerprint Scanner|Voltage Hack|Detect Mode"

;//////////////////////////////////////////////////////////////////
;debug

tb4ch1 := 0
tb4ch2 := 0
tb4edit1 := 0

debugcht := 0
debugchj := 0
debugch1 := 0
debugchp := 0
debugch2 := 0
debugch3 := 0

pop_position := ""
pop1_position := ""
pop2_position := ""

specialindex := 0

menu := {}
debug := {}
keyreg := {}

SplashQueue := new Queue(true,1000)

;/////////////////////////////////////////////////////////////////////////////////

AdapterRadioArr := []
AdapterRadioIndex:=""
NetworkAdapter := ""
AdapterPipes := ""

RetrieveAdapter() ;["Radmin VPN"])

SelectedSnacks := "P's & Q's"
readinit(SavePath,"Mics","SelectedSnacks")

;//////////////////////////////////////////////////////////////////
;mixer

MixerPath = %A_WorkingDir%\temp\data\mixer.ini
ImagePath = %A_WorkingDir%\temp\img\part4\

AudioSession := []
Applications := []

microphone := ""
speakers := ""

ddlSelectMic := ""
MicTripState := 1
ddlSelectMode := 1
Micpipeline := "Disabled|ToggleMute|HoldToTalk|TapToTalk"
ddlSelectHv := 1
Hvpipeline := "Disabled|Toggle|Hold"
HvTripState := 0


AudioPeriod := ""
AudioMeter := ""

MicTimerState := 0
MicTimerStart := ""

;//////////////////////////////////////////////////////////////////

ArrayChatSnippets := []
path2 = %A_WorkingDir%\temp\data\chatsnippets.txt
GetLine(ArrayChatSnippets,path2)

ArrayPhonebook := []
path1 = %A_WorkingDir%\temp\data\phonebook.txt
GetLine(ArrayPhonebook,path1)

token1 := ""
token2 := ""

readinit(SavePath,"Alarm","AlarmDateTime")
ElapsedSeconds := GetAlarmState()
Remaining_Hours := FormatSeconds(Abs(ElapsedSeconds/1000))

DeMoStyle := 0
readinit(gSavePath,"Gui","DeMoStyle")

tb2height := ""
tb4height := ""

IntGuiLock := false
obj := New gui()
IntGuiLock := true
UpdateCrosshair()



OnExit,ScriptExit



GroupAdd, App_Group, %target%
GroupAdd, App_Group, ahk_exe AutoHotkey.exe

InitLeftClick := 0

TrDoOnce := true

;/////////////////////////////////////////////////////////////////////////////////
;Variables Do not change

cycle := false
readinit(SavePath,"Weapon","Toggle2Mouse")

ceo := false
President := false
SnackRndInt = 0


Accessed := false
readinit(SavePath,"View","ToggleFPV")
LctrlNeedSleep:=false

FlipSwitch := false




;/////////////////////////////////////////////////////////////////////////////////
;Variables

md:= new MouseDelta(func("xMonitor"))
md.SetState(0)

xM:=0
yM:=0
ElapsedTime:=0

;/////////////////////////////////////////////////////////////////////////////////
;Variables Need To Change

FOV = 1
readinit(SavePath,"View","FOV")  ;Default View
RES := Abs(4-FOV)



NoWeaponKey := 1
RiffleKey := 5  
RpgKey := 8     

ShotgunKey := 7
SpecialKey := 9
PistolKey := 3
SmgKey := 4
SniperKey := 6

rMdist := 15



weaponwheel := [PistolKey,SmgKey,RiffleKey,SniperKey,NoWeaponKey,ShotgunKey,RpgKey,SpecialKey]
; 3,4,5,6,1,7,8,9

#include %A_WorkingDir%\temp\lib\pixeldata.ahk

Handheld := 2
CurrentWeapon := 1

PastWeapon1 := 1

MaskTabsWith := "Tab"

;//////////////////////////////////////////////////////////////////



;/////////////////////////////////////////////////////////////////////////////////
;Delays

TabWaitDelay = 100
KeySendDelay = 60
KeyPressDelay = 42

IntMenuDelay = 200

PrePhoneDelay = 200
PhoneDelay = 500
PhoneSendDelay = 100
PhonePressDelay = 70
WheelDelay = 100

WebsiteDelay = 400

SnackDelay = 200

EscDelay = 1000
EscDelay2 = 500
AfterEsc = 4000 ;dont change 

JumpDelay = 800
WalkDelay = 400
PunchDelay = 1000

WeaponScrollDelay = 45
PhoneSendDelay2 = 75
PhonePressDelay2 = 5
TextSendDelay = 25
TextPressDelay = 5

PriorHotkeyDelay := 5000

ChatSnippetKey := "y"

MouseDelay1 := 1
MouseDelay2 := 4
MouseDefault := 50

ClickDelay = 100

SetMouseDelay %MouseDefault%

SetKeyDelay()
SetKeyDelay(,,"Play")

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;test weapon wheel

DataArr := [[112.5, 67.5],[67.5, 22.5],[22.5, 337.5],[337.5, 292.5],[292.5, 247.5],[247.5, 202.5],[202.5, 157.5],[157.5, 112.5]]

;GuessColor := New ntc()

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;func4chat

HotkeyStateVar:=true
ScrollWheelVar:=true
fScrollVar:=false
forceWeaponCheck:=false
logger := []

;/////////////////////////////////////////////////////////////////////////////////
;menu

#include %A_WorkingDir%\temp\lib\menu data.ahk

player := New Work()
public_role()

CustomMenuLabel := []
CustomMenuSave := New Save(SavePath,"Mics","CustomMenuLabel","com")
CustomMenuSave.read()

;/////////////////////////////////////////////////////////////////////////////////
;phone

ActiveContacts := []
ActiveContacts.push(TotalContacts*)

ContactDetails := New Save(SavePath,"phone","ActiveContacts","com")
ContactDetails.read()

CustomPhoneNumber := ""
readinit(SavePath,"Mics","CustomPhoneNumber")



;/////////////////////////////////////////////////////////////////////////////////

NeedReload := false
SetTimer, Knock, 5000




WrHotkeyVar1 := ToggleHotkey
WrHotkeyVar2 := ToggleHotkey
ToggleHotkeyFunc(ToggleHotkey)

#include %A_WorkingDir%\temp\lib\mapping.ahk



InitCh()
return
;/////////////////////////////////////////////////////////////////////////////////

#If WinReport2()



#include %A_WorkingDir%\temp\lib\Ntc.ahk
#include %A_WorkingDir%\temp\lib\MouseDelta.ahk
#include %A_WorkingDir%\temp\lib\NetInfo.ahk


#include %A_WorkingDir%\temp\lib\new gui.ahk
#include %A_WorkingDir%\temp\lib\Gdip.ahk
#include %A_WorkingDir%\temp\lib\Mics.ahk
#include %A_WorkingDir%\temp\lib\basic.ahk

#include %A_WorkingDir%\temp\lib\debug.ahk
#include %A_WorkingDir%\temp\lib\working.ahk
#include %A_WorkingDir%\temp\lib\phone.ahk

#include %A_WorkingDir%\temp\lib\menu.ahk
#include %A_WorkingDir%\temp\lib\Vis\Vis2.ahk

#Include %A_WorkingDir%\temp\lib\VA.ahk
#include %A_WorkingDir%\temp\lib\hv\HotVoice.ahk
#include %A_WorkingDir%\temp\lib\HotVoice func.ahk
#include %A_WorkingDir%\temp\lib\ScrollGUI2.ahk
#include %A_WorkingDir%\temp\lib\mixer.ahk
#include %A_WorkingDir%\temp\lib\wmtooltip.ahk

;#include %A_WorkingDir%\other\test.ahk

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

CustomDisableHotkey:
LocalLabelKey := IntJoinFunc("SourceChange")
Hotkey, %LocalLabelKey%, SourceChange, Off
return

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


;/////////////////////////////////////////////////////////////////////////////////

Knock:
Suspend Permit
Process, Exist, GTA5.exe
If !ErrorLevel       ;closed
{
	NeedReload := true
}
else                 ;Open
{
	If NeedReload
	{
		WinGetActiveTitle, Title
		If Title = Grand Theft Auto V
		{
			PlaySound(SoundPath3)
			sleep, 5000
			Reload
			NeedReload := false
		}
	}
}
return

;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;I/O



readfile(Dir,byref default)
{

	If FileExist(Dir)
	{
		FileRead,Image,%Dir%
		default := Image
	}
	else
	{
		FileAppend,%default%,%Dir%
	}
}

writefile(Dir,Data)
{
	If FileExist(Dir)
	{
		FileDelete, %Dir%
	}
	FileAppend, %Data%, %Dir%
}

readinit(FilePath,SectionName,KeyName)
{
	global
	IniRead, OutputVar, %FilePath%, %SectionName%, %KeyName%
	if (OutputVar=="ERROR" || OutputVar="")
		writeinit(FilePath,SectionName,KeyName)
	else
		%KeyName% := OutputVar
}

writeinit(FilePath,SectionName,KeyName)
{
	global
	Data := %KeyName%
	IniWrite, %Data%, %FilePath%, %SectionName%, %KeyName%
}

deleteinit(FilePath,SectionName)
{
	global
	IniDelete, %FilePath%, %SectionName%
}



;FIFO https://autohotkey.com/board/topic/94062-a-queue-in-autohotkey/
class Queue 
{
	__New(state=true,interval=100,priority=-1)
	{
		this.items := Object()
		this.interval := -interval
		this.timer := ObjBindMethod(this, "UnQueue")
		this.state := state
		this.priority := priority
	}
	
	push(func,params="")
	{
		if this.state
		{
			this.items.Insert([func,params])
			this.Set()
		}
	}
	
	pop()
	{
		return this.items.Remove(1)
	}
	
	size()
	{
		return this.items.Count()
	}
	
	Set()
	{
		timer := this.timer
		SetTimer % timer, % this.interval, % this.priority
	}
	
	UnQueue()
	{
		While(this.size())
		{
			temp := this.pop()
			
			task := temp[1]
			params := temp[2]
			
			if IsLabel(task)
				Gosub %task%
			else if IsFunc(task)
				func(task).call(params*)
		}
	}
}

prompter(str,params*)
{
	tooltip % format(str,params*) ,1304,680
	sleep,1000
}

Scan(Dir,default=1)
{

	If FileExist(Dir)
	{
		FileRead,Image,%Dir%
		return %Image%
	}
	else
	{
		FileAppend,%default%,%Dir%
		return %default%
	}

}


Multi(Dir,default)
{
	If FileExist(Dir)
	{
		FileRead,Image,%Dir%
		StringReplace,Image,Image,%A_Space%,,All
		List := StrSplit(Image, "`n")
	}
	else
	{
		FileAppend,%default%,%Dir%
		StringReplace,default,default,%A_Space%,,All
		List := StrSplit(default, "`n")
	}
	Loop % List.MaxIndex()
	{
		List[A_Index] := SubStr(List[A_Index], InStr(List[A_Index], "=")+1)
	}
	return List
}

Str2Bool(localvar)
{
	IfInString, localvar, true
	{
		return 1
	}
	else
	{
		return 0
	}
}

Str2Int(localvar)
{
	localvar+=0
	return localvar
}

class Save
{
	__New(FilePath,Section,KeyHold,TypeOf)
	{
		this.FilePath := FilePath
		this.Section := Section
		this.KeyHold := KeyHold
		this.TypeOf := TypeOf
		
		this.index :=  0
		this.select := ""
	}
	
	read()
	{
		IniRead, OutputVar, % this.FilePath, % this.Section, % this.KeyHold
		if (OutputVar=="ERROR" || OutputVar="")
		{
			this.write()
		}
		else
		{
			this.set(OutputVar)
		}
	}
	
	write()
	{
		IniWrite, % this.get(), % this.FilePath, % this.Section, % this.KeyHold
	}
	
	set(raw)
	{
		global
		Switch this.TypeOf
		{
			case "int":
				value := Str2Int(raw)
			case "com":
				value := []
				value.push(StrSplit(raw,",")*)
			case "pip":
				value := cbparse(raw,select,index)
				this.index := index
				this.select := select
			default:
				value := raw
		}
		KeyHold := this.KeyHold
		%KeyHold% := value
	}
	
	get()
	{
		global
		KeyHold := this.KeyHold
		data := %KeyHold%
		Switch this.TypeOf
		{
			case "com":
				value := data.join()
			case "pip":
				value := cbjoin(data,select)
			default:
				value := data
		}
		return value
	}
}

PlaySound(FilePath,delay=0)
{
	global 
	if (ToggleSound=1 && FlipSwitch=0)
	{
		SoundPlay, %FilePath%
		sleep, %delay%
	}
}

Msgbox(Text,limit,byref TimeOut,byref Ok,byref Cancel)
{
	TimeOut := false
	Ok := false
	Cancel := false
	
	Gui, Msgbox:New ,+AlwaysOnTop -MinimizeBox +LastFound +ToolWindow +Border +HwndMsgboxGui
	Gui, Msgbox:Add, Text, y10, % Text
	Gui, Msgbox:Add, Button,x10 y40 h20 w50 gMsgboxOk, Ok
	Gui, Msgbox:Add, Button,x70 y40 h20 w50 gMsgboxCancel, Cancel
	Gui, Msgbox:Show,w130 h66

	rps := 5
	count := limit*rps
	delay := (limit/rps)*100

	Loop % count
	{
		if Ok || Cancel
		{
			return
		}
		sleep,%delay%
	}
	TimeOut := true
	goSub, MsgboxDestroy
	return
	
	MsgboxDestroy:
		Gui, Msgbox:destroy
		return

	MsgboxOk:
		Ok := true
		goSub, MsgboxDestroy
		return

	MsgboxGuiClose:
	MsgboxCancel:
		Cancel := true
		goSub, MsgboxDestroy
		return
}

SplashTextOn(Text, xPos="Center", yPos="Center", Font="Arial", Size=10, Color="White", bg="Black")
{
	Gui, 99:+LastFound -Caption +AlwaysOnTop +ToolWindow +E0x08000000
	Gui, 99:Font, s%Size% c%Color%, %Font%
	Gui, 99:Add, Text,, %Text%
	Gui, 99:Color, %bg%
	Gui, 99:Show, x%xPos% y%yPos% NoActivate
}

SplashTextOff()
{
	Gui, 99:Destroy
}

;////////////////////////////////////////////

Splash(text)
{
	splashtexton,,,%text%
	sleep, 2000
	splashtextoff
}

;/////////////////////////////////////////////////////////////////////////////////
;Spin Wheel Alarm

PreNub:
SetTimer, PreNub, Off
goSub, Alarm
SetTimer, Alarm, %Snooze%
return

;/////////////////////////////////////////////////////////////////////////////////

Alarm:
PlaySound(SoundPath)
sleep, 400
return

;/////////////////////////////////////////////////////////////////////////////////

LuckyWheelLabel:
input, cmd, V L2 I T10
If cmd = `ns
{
	ElapsedSeconds := GetAlarmState()
	If (ElapsedSeconds = 0)
	{
		AlarmDateTime := A_Now
		ElapsedSeconds := GetAlarmState()
		
		PlaySound(SoundPath2)
		sleep, 1000
		
		if (ShowCh=1 && TabSelected=1)
			GuiTimer("On")
	}
}
return

;/////////////////////////////////////////////////////////////////////////////////

GetAlarmState()
{
	global Snooze,AlarmDateTime
	
	If (AlarmDateTime != "")
	{
		PastSeconds := AlarmDateTime
		EnvSub, PastSeconds, %A_Now% , Seconds

		temp := (-PastSeconds-86400)*1000 +Snooze
		If (temp >= 0)
		{
			SetTimer, PreNub, Off
			return 0
		}
		else 
		{
			SetTimer, PreNub, %temp%
			SetTimer, Alarm, Off
			return temp
		}
	}
	return 0
}

;/////////////////////////////////////////////////////////////////////////////////

FormatSeconds(NumberOfSeconds)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    time := 19990101  ; *Midnight* of an arbitrary date.
    time += NumberOfSeconds, seconds
    FormatTime, mmss, %time%, mm:ss
    return floor(NumberOfSeconds//3600) "hr:" mmss
}

;/////////////////////////////////////////////////////////////////////////////////

GuiTimer(param1="")
{
	global pSlider
	static NowTym := 0
	
	if (param1="On" || param1=100)
	{
		NowTym := Abs(GetAlarmState()/1000)
		SetTimer, GuiTimer, 1000
	}
	if (param1="Off" || NowTym < 0)
	{
		SetTimer, GuiTimer, Off
		return 
	}
	
	GuiControl, Main:, tbText1, % FormatSeconds(NowTym)
	pSlider.set(Floor((100-(NowTym/86400)*100))‬)
	
	NowTym--
}

AlarmSlider(value)
{
	global 
	AlarmDateTime := A_Now
	value := -1*Round(86400*(value/100))
	EnvAdd, AlarmDateTime, value, seconds
	NowTym := Abs(GetAlarmState()/1000)
	GuiControl, Main:, tbText1, % FormatSeconds(NowTym)
}

;https://www.autohotkey.com/boards/viewtopic.php?t=61051
Class Progress_Slider
{
	__New(name , id , xgui , ygui , wgui , hgui , rmin , rmax , init:=0 , bg := "Black" , tp := "Red", fn := "" , arg := "")
	{
		this.name := name
		this.id := id
		this.xgui := xgui
		this.ygui := ygui
		this.wgui := wgui
		this.hgui := hgui
		this.rmin := rmin
		this.rmax := rmax
		this.init := init
		this.bg := bg
		this.tp := tp
		this.fn := fn
		this.arg := arg
		this.create()
	}
	
	create()
	{
		global
		this.vert := InStr(this.arg,"vertical")
		Gui, % this.name ":Add" , Text , % "x" this.xgui " y" this.ygui " w" this.wgui " h" this.hgui " hwndhText"
		tempf := this.adjust.BIND(this)
		GuiControl, % this.name ":+g" , %hText% , % tempf
		Gui, % this.name ":Add" , Progress , % "x" this.xgui " y" this.ygui " w" this.wgui " h" this.hgui " Range" this.rmin "-" this.rmax  " v" this.id " Background" this.bg " c" this.tp " " this.arg,% this.init 
	}
	
	adjust()
	{
		CoordMode,Mouse,Client
		
		GuiTimer("Off")
		
		prev := ""
		
		While(GetKeyState("LButton"))
		{
			MouseGetPos, xtemp, ytemp
			
			if (this.vert=0)
				this.init := Round((xtemp - this.xgui ) / ( this.wgui / (this.rmax - this.rmin) )) + this.rmin
			else
				this.init := Round(((ytemp - this.ygui ) / ( this.hgui / (this.rmax - this.rmin) )) + this.rmin )* -1 + this.rmax
			
			if (this.init > this.rmax )
				this.init := this.rmax
			else if (this.init < this.rmin)
				this.init := this.rmin
			
			if (prev != this.init)
				this.call()
			
			prev := this.init
		}
		
		this.call()
		
		GuiTimer("On")
		
	}
	
	call()
	{
		this.set(this.init)
		if (this.fn!="")
			Func(this.fn).call(this.init)
	}
	
	set(value)
	{
		this.init := value
		Color := this.init < this.rmax ? "Blue" : "Lime"
		GuiControl, % this.name ":+c" Color, % this.id
		GuiControl,% this.name ":" ,% this.id , % this.init
	}
}


;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////

IntKeyFunc(label)
{
	global kStash
	return kStash.pair(label)
}

IntJoinFunc(label)
{
	global kStash
	return kStash.join(label)
}

Suspend(value)
{
	Suspend %value%
}

;/////////////////////////////////////////////////////////////////////////////////

ListLines(state="")
{
	global LLdefault
	
	if state
		Listlines, % state
	else
		Listlines, % LLdefault
}

SetMouseDelay(para="",type="")
{
	global MouseDefault
	
	if (para)
		SetMouseDelay, % para, % type
	else
		SetMouseDelay, % MouseDefault, % type
}

SetKeyDelay(para1="",para2="",type="")
{
	global KeySendDelay, KeyPressDelay
	
	if (para1 || para2)
		SetKeyDelay, % para1, % para2, % type
	else
		SetKeyDelay, % KeySendDelay, % KeyPressDelay, % type
}

NoInterrupt(type="Physical",limit=300,delay=0)
{
	part := 100
	Loop % delay//part
	{
		if (A_TimeIdle%type% < limit)
			throw 0
		sleep %part%
	}
}

SolveInputs(request=1,exclude="CapsLock")
{
	_Keys := []
	
	Loop, 0xFF
	{
		if !GetKeyState(Key:=Format("VK{:02X}",A_Index))
			Continue
		
		if !InStr(exclude,Name:=GetKeyName(Key))
			_Keys.push(Name)
	}
	
	if request
	{
		Loop % _Keys.Count()
		{
			Key := _Keys[A_index]
			SendInput, {%Key% up}
		}
	}
	
	return, _Keys
}

DisplayInputs()
{
	ListOfKeys := SolveInputs(0)
	Tooltip % ListOfKeys.join()
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

HoldwLabel:
Suspend Permit
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.4
If ErrorLevel
{
	Send {q Down}
	KeyWait, %LocalKeyTrimed%
	Send {q Up}
	
	/*
	If (GetKeyState("w","D")=1) ;A_PriorHotkey=A_ThisHotKey
	{
		Send {w Up}
	}
	*/
}
else
{
	KeyWait, %LocalKeyTrimed%, D T0.2
	If ErrorLevel
	{
		Send {q}
	}
	else
	{
		If !GetKeyState("w","D")
		{
			Send {w Down}
		}
		else
		{
			Send {w Up}
		}
		KeyWait ,%LocalKeyTrimed%
	}
}
return


;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;INTERACTIVE MENU

class Work
{
	__New()
	{
		this.data := {"nul":1,"mbr":5,"ceo":7,"mcp":8}
		this.status := GetKeyState("CapsLock", "T") ? 5:1
		
	}
	
	get()
	{
		return this.status
	}
	
	set(value)
	{
		if value is not integer
		{
			this.status := this.data[value]
		}
		else
		{
			this.status := value
		}
		state := (this.status=5) ? "On":"Off"
		SetCapsLockState, %state%
		;tooltip % value
	}
	
	cpr(key)
	{
		return (this.status == this.data[key])
	}
	
	max()
	{
		return (this.status>5)
	}
	
	caps(state)
	{
		;Send {CapsLock}
		
		if state
		{
			if  (this.status=this.data["nul"])
			{
				SetCapsLockState, On
				this.status := this.data["mbr"]
			}
			else if (this.status=this.data["mbr"])
			{
				SetCapsLockState, Off
				this.status := this.data["nul"]
			}
			else
			{
				SetCapsLockState, Off
			}
		}
		else
		{
			if (this.status=this.data["mbr"])
			{
				SetCapsLockState, On
			}
			else
			{
				SetCapsLockState, Off
			}
		}
		;tooltip % this.status
		
	}
	
}

CapsLockLabel:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
player.caps(1)
public_role()
KeyWait, %LocalKeyTrimed%
return

KeySound(FileName,delay=0)
{
	global ToggleSound
	
	FilePath = %A_WorkingDir%/temp/other/%FileName%.mp3
	if ToggleSound
	{
		SoundPlay, %FilePath%
		sleep, %delay%
	}
}

pinterrupt(data,state)
{
	global
	
	if (data = "IntMenu" && intr = 0)
		intr := 0
	else
		intr := state
	
	;tooltip, % format("menu:{} intr:{}",data,intr),,,2
}

;/////////////////////////////////////////////////////////////////////////////////

ReturnVehicle:
Suspend On

If player.cpr("mcp")
{
	InteractionMenu(["MC President","Return Vehicle to Storage"],{"press":1})
	
}
else
{
	InteractionMenu(["Vehicle","Return Personal Vehicle to Storage"],{"press":1,"close":1})
	
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

PersonalVehicle:
Suspend On
InteractionMenu(["Vehicle","Request Personal Vehicle"],{"press":1,"close":1})

Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

SuperHeavyArmor:
Suspend On
InteractionMenu(["Body Armor","Super Heavy Armor"],{"press":1,"close":1})

Suspend Off
return				

;/////////////////////////////////////////////////////////////////////////////////

Snack:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
LocalBlock := ErrorLevel

Suspend On

InteractionMenu(["Snacks",SelectedSnacks])

If !LocalBlock
{
	Loop, 2
	{
		Send {Enter}
		Sleep, %SnackDelay%
	}
}
else
{
	While GetKeyState(LocalKeyTrimed,"P")
	{
		Send {Enter}
		Sleep, %SnackDelay%
	}

}


Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

Outfit:
Suspend On
if !IsThatLabel("Outfit")
{
	InteractionMenu(OutfitMenu)
}
else
{
	Send {Right}{Enter}
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

DropBullShark:
Suspend On
If player.cpr("ceo")
{
	InteractionMenu(["CEO Abilities","Drop Bullshark"],{"press":1})
	
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

DropArmor:
Suspend On
If player.cpr("ceo")
{
	InteractionMenu(["CEO Abilities","Drop Armor"],{"press":1})
	
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

AssociateInvite:
Suspend On
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%
KeyWait, %LocalKeyTrimed%, D T0.2
If ErrorLevel
{
	HireAssociates(3)             ;single press for crew
}
else
{
	HireAssociates(2)             ;double press for friends
}
Suspend Off
return

HireAssociates(Localstep)
{
	global player
	
	If player.max()
	{
		next := {"arrow":Localstep,"press":1,"close":1}
		
		If player.cpr("ceo")
		{
			InteractionMenu(["Hire Associates","Offer to"],next)
		}
		else
		{
			InteractionMenu(["Find Prospects","Offer to"],next)
		}
		
	}
	return
}

;/////////////////////////////////////////////////////////////////////////////////

TopPostion:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
Suspend On
If ErrorLevel                                   ;hold to toggle betw Ceo n McPresident
{
	If player.cpr("ceo")
	{
		goSub, retireCeo
		sleep 200
		goSub, becameMc
	}
	else If player.cpr("mcp")
	{
		goSub, retireMc
		sleep 200
		goSub, becameCeo
	}
	else
	{
		goSub, becameCeo
		
	}
	
	KeyWait, %LocalKeyTrimed%
}
else
{
	KeyWait, %LocalKeyTrimed%, D T0.2

	If player.cpr("ceo")
	{
		goSub, retireCeo
		
	}
	else If player.cpr("mcp")         
	{
		goSub, retireMc
		
	}
	else If ErrorLevel           ;Single Press
	{
		If !player.cpr("ceo")
		{
			goSub, becameCeo
			
		}
	}
	else                         ;Double Press
	{
		If !player.cpr("mcp")
		{
			goSub, becameMc
			
		}
	}
}

Suspend Off
return

retireCeo:
InteractionMenu(["SecuroServ CEO","Retire"],{"press":1},Error)
player.set("nul")
public_role()
return

becameCeo:
InteractionMenu(["SecuroServ","Register as a CEO"],{"press":1},Error)
SetRoleIf(Error,"ceo")
public_role()
return

retireMc:
InteractionMenu(["MC President","Disband MC"],{"press":1},Error)
player.set("nul")
public_role()
return

becameMc:
InteractionMenu(["Motorcycle Club","Start a Motorcycle Club"],{"press":1},Error)
SetRoleIf(Error,"mcp")
public_role()
return

SetRoleIf(Error,State)
{
	global 
	if !Error
	{
		player.set(State)
	}
}

;/////////////////////////////////////////////////////////////////////////////////

PseudoTopLabel:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
Suspend On
If ErrorLevel                                   ;hold to toggle betw Ceo n McPresident
{
	If player.cpr("ceo")
	{
		player.set("mcp")
		
	}
	else If player.cpr("mcp")
	{
		player.set("ceo")
		
	}
	else
	{
		player.set("ceo")
		
	}
	
	KeyWait, %LocalKeyTrimed%
}
else
{
	KeyWait, %LocalKeyTrimed%, D T0.2

	If player.max()
	{
		player.set("nul")
		
	}

	else If ErrorLevel           ;Single Press
	{
		If !player.cpr("ceo")
		{
			player.set("ceo")
			
		}
	}
	else                         ;Double Press
	{
		If !player.cpr("mcp")
		{
			player.set("mcp")
			
		}
	}
}
public_role()
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////

HelmetChange:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
;Suspend On
If ErrorLevel
{
	InteractionMenu(MaskMenu)
    
	AccessMenu := MaskMenu
	KeyWait, %LocalKeyTrimed%
}
else
{
	;KeyWait, %LocalKeyTrimed%
	KeyWait, %LocalKeyTrimed%, D T0.2
	
	If (ErrorLevel)     ;Single Press
	{
		If IsThatLabel("Masks,Helmets")
		{
			Send {Right}{Space}
		}
		else
		{
			Send {NumpadSub Down}
			Sleep 500
			Send {NumpadSub Up}
		}
	}
	else                ;Double Press
	{
		InteractionMenu(HelmetMenu)
		AccessMenu := HelmetMenu
	}
}

;Suspend Off
return



;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

CustomMenu:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
If ErrorLevel
{
	;long press
	CustomMenuSearch()
	KeyWait, %LocalKeyTrimed%
}
else
{
	;single press
	MenuAt := CustomMenuLabel[3]
	if (MenuAt = player.get() || MenuAt = 1)
		InteractionMenu(CustomMenuLabel)
}
return

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;PHONE



;e.g MouseWheel("WheelUp",10,WheelDelay)
MouseWheel(Wheel,Count,Delay)
{
	Loop, %Count%
	{
		SendInput,  {%Wheel%}
		Sleep, %Delay%
	}
	;sleep, 5000
}

;/////////////////////////////////////////////////////////////////////////////////



ScrollpInterface(ContactNo)
{
	global 
	;Suspend Permit
	
	ContactIn := cbindex(ActiveContacts,ContactNo)
	
	if ContactIn
	{
		sleep, %PrePhoneDelay%
		setkeydelay, %PhoneSendDelay%, %PhonePressDelay%
		
		temp0 := NavpMenu(3)
		if !temp0
		{
			return 0
		}
		
		ScrollContact(ContactNo,ContactIn,temp0)
		
		setkeydelay, %KeySendDelay%, %KeyPressDelay%
		
		IsDialMade()
	}
}

DialpInterface(ContactNo)
{
	global 
	;Suspend Permit

	if ContactNo
	{
		bringGameIntoFocus()

		sleep, %PrePhoneDelay%
		setkeydelay, %PhoneSendDelay%, %PhonePressDelay%

		if !NavpMenu(3)
		{
			return 0
		}
		
		setkeydelay, %PhoneSendDelay2%, %PhonePressDelay2%
		
		sleep, %PhoneDelay%
		Send {Space}
		sleep, %PhoneDelay%
		
		DialNumber(ContactNo)
		sleep, %PhoneDelay%
		Send {Space}
		
		setkeydelay, %KeySendDelay%, %KeyPressDelay%
		
		IsDialMade()
	}
}





;/////////////////////////////////////////////////////////////////////////////////

CustomPhone:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
If ErrorLevel
{
	;long press
	CustomPhoneSearch()
	KeyWait, %LocalKeyTrimed%
}
else
{
	;single press
	ScrollpInterface(CustomPhoneNumber)
}
return

;/////////////////////////////////////////////////////////////////////////////////

GetCar:
Suspend On
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%
KeyWait, %LocalKeyTrimed%, D T0.2
If (ErrorLevel || DoNotDial)
{
	;single press
	ScrollpInterface("mechanic")
}
else
{
	;double press
	DialpInterface("328-555-0153")
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

MorsMutual:
Suspend On
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%
KeyWait, %LocalKeyTrimed%, D T0.2
If (ErrorLevel || DoNotDial)
{
	;single press
	ScrollpInterface("mors")
}
else
{
	;double press
	DialpInterface("611-555-0149")
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

Pegasus:
Suspend On
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%
KeyWait, %LocalKeyTrimed%, D T0.2
If (ErrorLevel || DoNotDial)
{
	;single press
	ScrollpInterface("pegasus")
}
else
{
	;double press
	DialpInterface("328-555-0122")
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////

Merryweather:
Suspend On
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%
KeyWait, %LocalKeyTrimed%, D T0.2
If (ErrorLevel || DoNotDial)
{
	;single press
	ScrollpInterface("merry")
}
else
{
	;double press
	DialpInterface("273-555-0120")
}
Suspend Off
return	

;/////////////////////////////////////////////////////////////////////////////////

Lester:
Suspend On
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
If ErrorLevel
{
	;long press
	ScrollpInterface("lester")
	Sleep, 5500
	Send {Down}{Enter}
	KeyWait, %LocalKeyTrimed%
}
else
{
	KeyWait, %LocalKeyTrimed%, D T0.2
	If (ErrorLevel || DoNotDial)
	{
		;single press
		ScrollpInterface("lester")
	}
	else
	{
		;double press
		DialpInterface("346-555-0102")
	}
}
Suspend Off
return

;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;Gaming Mouse




xMonitor(id:=0,dx:=0,dy:=0)
{
	global xM,yM,ElapsedTime
	static SampleRate := 0
	static LastTime := A_TickCount

	static X:=0
	static Y:=0

	X+=dx
	Y+=dy

	if (id="Show")
	{
		xM:=X,yM:=Y
		X:=0,Y:=0
	}
	
	if (SampleRate>=20)
	{
		NowTime := A_TickCount
		ElapsedTime := NowTime - LastTime
		LastTime := A_TickCount
		SampleRate:=0
	}
	
	SampleRate +=1
	return
}




mousewait()
{
	global xM,yM,ElapsedTime,CurrentWeapon
	
	xMonitor("Show")

	Pi := 4 * ATan(1)
	
	y := yM, x := xM
	
	theta := DllCall("msvcrt.dll\atan2", "Double", y, "Double", x, "CDECL Double") * (-180 / Pi)
	if (theta < 0)
		theta += 360
	
	if (( 22.5>=theta && theta>=0) || (337.5<theta)) ;Rifle
		num:=5
	else if (337.5>=theta && theta>292.5) ;Sniper
		num:=6
	else if (292.5>=theta && theta>247.5) ;no weapon
		num:=1
	else if (247.5>=theta && theta>202.5) ;Shotgun
		num:=7
	else if (202.5>=theta && theta>157.5) ;Heavy
		num:=8
	else if (157.5>=theta && theta>112.5) ;Throwable
		num:=9
	else if (112.5>=theta &&  theta>67.5) ;Pistol
		num:=3
	else if (67.5>=theta  &&  theta>22.5) ;Smg
		num:=4
	
	r :=sqrt(y**2 + x**2)

	if ((r > 50) && (ElapsedTime<250))
	{
		;tooltip % format("X:{} Y:{} no.{} R:{:0.f} t:{:0.f} {}ms",xM,yM,num,r,theta,ElapsedTime)
		return num
	}
	return CurrentWeapon
}






WheelActive(Xbutton)
{
	global
	if GetKeyState("tab","P")
	{
		;Hotkey, ~*Tab up, Off
		CurrentWeapon :=mousewait()
		;md.SetState(0)
		%Xbutton% := CurrentWeapon
		public_weaponbind(Xbutton)
		return 1
	}
	return 0
}



WeaponWheelScroll(label)
{
	global fScrollVar,weaponwheel,CurrentWeapon
	
	if (A_TimeSincePriorHotkey>WeaponScrollDelay || A_TimeSincePriorHotkey=-1)
	{
		
		if (fScrollVar=0 && GetKeyState("RButton","P")=0)
		{
			
			static LastTime := A_TickCount
			
			value := InStr(label,"Down") ? 1 : -1
			
			if (A_TickCount - LastTime > 1500)
			{
				;tooltip , first time
			}

			CurrentWeapon := weaponwheel[traverse(cbindex(weaponwheel,CurrentWeapon),value,8)]
			
			LastTime := A_TickCount
			;interprompt("prompter",["Current Weapon {}",CurrentWeapon])
			;tooltip % CurrentWeapon
			public_weapon()
		}
	}
}












;xtra keys

XtraMouse4:
Suspend On
if !WheelActive("Extrabutton4")
{
	wScroll := WeaponToggle(4)
	InterMediateInterface(Extrabutton4,wScroll,Toggle2Mouse)
}
Suspend Off
return

XtraMouse3:
Suspend On
if !WheelActive("Extrabutton3")
{
	wScroll := WeaponToggle(3)
	InterMediateInterface(Extrabutton3,wScroll,Toggle2Mouse)
}
Suspend Off
return

RpgWeapon:
Suspend On
if !WheelActive("Extrabutton2")
{
	wScroll := WeaponToggle(2)
	InterMediateInterface(Extrabutton2,wScroll,Toggle2Mouse)
}
Suspend Off
return

ToggleRifle:
Suspend On
if !WheelActive("Extrabutton1")
{
	If (CurrentWeapon = Extrabutton1)
	{
		InterMediateInterface(NoWeaponKey,0,Toggle2Mouse)
	}
	else if  (CurrentWeapon = NoWeaponKey)
	{
		InterMediateInterface(Extrabutton1,0,Toggle2Mouse)
	}else
	{
		InterMediateInterface(PastWeapon1,0,Toggle2Mouse)
	}
	PastWeapon1 := CurrentWeapon
}
Suspend Off
return




;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


PrimaryGunsLabel:
Suspend Permit
StringTrimLeft, Key0, A_ThisHotkey, 2

If (Key0=1)
{
	InterMediateInterface(1,0,0)
}
else
{
	InterMediateInterface(2,1,1)
}
return

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


SecondaryGunsLabel:
StringTrimLeft, Key, A_ThisHotkey, 2
KeyWait, %Key%, T0.5
If ErrorLevel
{
	Extrabutton2  := Key
	
	public_weaponbind("Extrabutton2")
	
	InterMediateInterface(Key,0,Toggle2Mouse)

}
else
{
	If (A_ThisHotkey=A_PriorHotkey)
	{
		InterMediateInterface(Key,1,Toggle2Mouse)
	}
	else
	{
		InterMediateInterface(Key,0,Toggle2Mouse)
	}
}
KeyWait,%Key%
return

;/////////////////////////////////////////////////////////////////////////////////


SourceChange:
Suspend Permit
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%
KeyWait, %LocalKeyTrimed%, D T0.2
If !ErrorLevel
{
	Toggle2Mouse := !Toggle2Mouse
	writeinit(SavePath,"Weapon","Toggle2Mouse")
	
}
return


;/////////////////////////////////////////////////////////////////////////////////////////////

WeaponScroll(wheel,delay=-1)
{
	if (wheel)
	{
		Key := (wheel<0) ? "WheelDown":"WheelUp"
		Send {%Key%}
		KeyWait, %Key% T0.1
		sleep %delay%
	}
}


WeaponToggle(index)
{
	global 
	
	if (CurrentWeapon != Extrabutton%index%)
		return 0
	
	Loop % 4
	{
		if (index!=A_index)
		{
			if (Extrabutton%index%=Extrabutton%A_index%)
			{
				if (index>A_index)
					return 1
				else
					return -1
			}
		}
	}
	return 1
}


InterMediateInterface(KeyNum,KeyMul,Select=true) ;if toggle is true mouse is selected as default
{
	global CurrentWeapon
	
	if (Select) ;mouse
	{
		Coord := MouseCoord(KeyNum)
		MouseMotion(Coord[1],Coord[2],KeyMul)
	}
	else         ;keyboard
	{
		KeyboardToggle(KeyNum)
	}
	
	if (KeyNum=2)
	{
		CurrentWeapon := 1
	}
	else
	{
		CurrentWeapon := KeyNum
	}
	public_weapon()
}

MouseMotion(xMotion,yMotion,Scroll=0)
{
	global TabWaitDelay,KeySendDelay,KeyPressDelay,MouseDelay1,MouseDelay2,MouseDefault,MaskTabsWith
	;Suspend Permit
	
	If GetKeyState("Shift", "P")
	{
		SetMouseDelay %MouseDelay1%
		setkeydelay, 20, 14
		TabWaitDelay = 120
	}
	else
	{
		SetMouseDelay %MouseDelay2%
		setkeydelay, 100, 70
		TabWaitDelay = 50
	}
	
	BlockInput, MouseMove
	Send {%MaskTabsWith% Down}
	KeyWait, %MaskTabsWith%, D L
	sleep , %TabWaitDelay%
	
	CoordMode, MouseMove, Screen
	MouseMove, xMotion, yMotion, 2, R
	
	WeaponScroll(Scroll,20)
	
	Send {%MaskTabsWith% Up}
	KeyWait, %MaskTabsWith%, T0.3
	BlockInput, MouseMoveOff
	
	If GetKeyState("RButton","P")
	{
		SendInput {RButton Down}
	}
	
	SetMouseDelay %MouseDefault%
	setkeydelay, %KeySendDelay%, %KeyPressDelay%
}



KeyboardToggle(KeyInput)
{
	Send, {%KeyInput%}
	KeyWait, %KeyInput%
	MouseClick, left
}

MouseCoord(Key)
{
	global rMdist,PistolKey,SmgKey,RiffleKey,SniperKey,NoWeaponKey,Handheld,ShotgunKey,RpgKey,SpecialKey

	If (Key = PistolKey)
	{
		xtemp :=0
		ytemp :=-1*rMdist
	}
	else If (Key = SmgKey)
	{
		xtemp :=rMdist
		ytemp :=-1*rMdist
	}
	else If (Key = RiffleKey)
	{
		xtemp :=rMdist
		ytemp :=0
	}
	else If (Key = SniperKey)
	{
		xtemp :=rMdist
		ytemp :=rMdist
	}
	else If (Key = NoWeaponKey || Key = Handheld)
	{
		xtemp :=0
		ytemp :=rMdist
	}
	else If (Key = ShotgunKey)
	{
		xtemp :=-1*rMdist
		ytemp :=rMdist
	}
	else If (Key = RpgKey)
	{
		xtemp :=-1*rMdist
		ytemp :=0
	}
	else If (Key = SpecialKey)
	{
		xtemp :=-1*rMdist
		ytemp :=-1*rMdist
	}
	
	return [xtemp,ytemp]
}







PolarSystem(r,theta)
{
	static pi :=  4 * ATan(1)
	rad := theta * pi/180
	return [r*Cos(rad),-r*Sin(rad)]
}

GetWheelArr(radius)
{
	global DataArr
	
	Append := 45/8
	
	TempArr := []
	Loop % DataArr.Count()
	{
		KeyAnglePair := DataArr[A_index]
		TempArr.Push([PolarSystem(radius,KeyAnglePair[1]-Append),PolarSystem(radius,KeyAnglePair[2]+Append)])
	}
	return TempArr
}


Getinfo()
{
	;default
	Width := 1366, Height := 769
	
	If WinActive("ahk_exe GTA5.exe")
		WinGetPos,,, Width, Height, A
	
	if ((Width=1366) && (Height=769))
		return [686, 331, 206]
	else 
		return [686, 359, 206]
}


GetWeaponWheelStats()
{
	global weaponwheel,CurrentWeapon
	
	WheelConfig := Getinfo()
	
	xCenter := WheelConfig[1]
	yCenter := WheelConfig[2]
	radius := WheelConfig[3]
	
	pcolor := 0x2D6EB9
	
	WheelArr := GetWheelArr(radius) ;[[b1,b2]] [[[x1,y1],[x2,y2]]]
	
	Loop % WheelArr.Count()
	{
		b1 := WheelArr[A_index][1]
		b2 := WheelArr[A_index][2]
		
		x1 := b1[1], y1 := b1[2]
		x2 := b2[1], y2 := b2[2]
		
		If iprop.InRange(pixelcolor(round(xCenter+x1),round(yCenter+y1)),pcolor) || iprop.InRange(pixelcolor(round(xCenter+x2),round(yCenter+y2)),pcolor)
			return weaponwheel[A_index]
	}
	return CurrentWeapon
}









;/////////////////////////////////////////////////////////////////////////////////////////////
;pixel detect



GetSysRatio()
{
	If WinActive("ahk_exe GTA5.exe")
	{
		WinGetPos,,, Width, Height, A
		return [Width/1366,Height/769]
	}
	return [1,1]
}


pixelwait(array,exclude:="",max:=4,delay:=0,threshold:=0,qreturn:=0)
{
	temp := GetSysRatio()
	rWidth := temp[1]
	rHeight := temp[2]
	;tooltip % rWidth " " rHeight
	
	split :=  array.Count()
	
	if (exclude!="")
		array.push(exclude*)
	size := array.Count()
	

	check:=0
	loop, %max%
	{
		for i, k in array
		{
			xaxis := k.1*rWidth
			yaxis := k.2*rHeight

			color := pixelcolor(xaxis,yaxis)
			;tooltip % format("{} {} data:0x{:X} get:{} ",xaxis,yaxis,k.3,color)
			;mousemove,xaxis,yaxis
			
			if (i<=split && !qreturn)
				check := color =k.3 ? check+1:0
			else 
				check := color!=k.3 ? check+1:0
			
			if ((check=0) && (i<=size-threshold))
				break
				
			;sleep, 3000
		}
		;tooltip % check
		if (check>=size-threshold)
			return 1
		sleep,%delay%
	}
	return 0
}

;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;Website

;Works Only When Setting>>Keyboard/Mouse>>Mouse Input Method>>DirectInput
MoneyTransferOldV1:
If !GetKeyState("LWin","P")
{
	BlockInput, On
	
	sleep, %PrePhoneDelay%
	setkeydelay, PhoneSendDelay, PhonePressDelay 
	Send {Up}
	sleep, %PhoneDelay%
	Send {Down}{Enter}
	setkeydelay, %KeySendDelay%, %KeyPressDelay%
	
	sleep, %WebsiteDelay%
	MouseClick, left, 692, 300 ;Money and Services
	
	sleep, %WebsiteDelay%
	Send, {Down Down}
	sleep, %WebsiteDelay%
	Send,{Down Up}
	KeyWait Down
	
	MouseClick, left, 649, 644 ;www.maze-bank.com
	
	MouseClick, left, 684, 500 ;Main Menu
	sleep, %WebsiteDelay%
	MouseClick, left
	
	MouseClick, left, 675, 382 ;Deposit
	BlockInput, Off
}
return

;/////////////////////////////////////////////////////////////////////////////////


;pixel Coords
;       -y
;        |
;        |
;-x______|______+x
;        |
;        |
;        |
;        +y

;/////////////////////////////////////////////////////////////////////////////////


;Works Only When Setting>>Keyboard/Mouse>>Mouse Input Method>>Windows
MoneyTransferOldV2:
If !GetKeyState("LWin","P")
{
	BlockInput, On
	
	sleep, %PrePhoneDelay%
	setkeydelay, PhoneSendDelay, PhonePressDelay 
	Send {Up}
	sleep, %PhoneDelay%
	Send {Down}{Enter}
	setkeydelay, %KeySendDelay%, %KeyPressDelay%
	
	sleep, %WebsiteDelay%
	MouseMove ,0,0
	sleep, 500
	
	SendInput {Click, 700, 290, 0, Relative} ;Money and Services
	sleep, 100
	MouseClick, left
	
	sleep, %WebsiteDelay%
	Send, {Down Down}
	sleep, %WebsiteDelay%
	Send,{Down Up}
	KeyWait Down
	
	SendInput {Click, 0, 350, 0, Relative} ;www.maze-bank.com
	sleep, 100
	MouseClick, left
	
	sleep, %WebsiteDelay%
	
	SendInput {Click, 0, -150, 0, Relative} ;Main Menu
	sleep, %WebsiteDelay%
	MouseClick, left
	
	sleep, %WebsiteDelay%
	
	SendInput {Click, 0, -100, 0, Relative} ;Deposit
	sleep, 100
	MouseClick, left
	
	BlockInput, Off
}
return

;/////////////////////////////////////////////////////////////////////////////////


AdjustValClick(x,y)
{
	t1 := round(x)
	t2 := round(y)
	sleep, 300
	SendInput {Click, %t1%,%t2%, 0, Relative}
}

;Work In any Aspect Ratio
MoneyTransfer()
{
	global 
	
	LocalBlock := false
	LocalKeyTrimed := IntKeyFunc(A_ThisFunc)
	KeyWait, %LocalKeyTrimed%, T0.5
	If ErrorLevel
	{
		LocalBlock := true
	}
	
	BlockInput, On

	temp := GetSysRatio()
	rWidth := temp[1]
	rHeight := temp[2]

	sleep, %PrePhoneDelay%
	setkeydelay, PhoneSendDelay, PhonePressDelay 
	
	if !NavpMenu(8)
	{
		return 0
	}
	
	setkeydelay, %KeySendDelay%, %KeyPressDelay%

	sleep, %WebsiteDelay%
	MouseMove ,0,0
	sleep, 500

	AdjustValClick(682*rWidth,290*rHeight) ;Money and Services
	sleep, %ClickDelay%
	MouseClick, left

	sleep, %WebsiteDelay%
	Send, {Down Down}
	sleep, %WebsiteDelay%
	Send,{Down Up}
	KeyWait Down
		
	AdjustValClick(0,350*rHeight) ;www.maze-bank.com
	sleep, %ClickDelay%
	MouseClick, left

	sleep, %WebsiteDelay%

	AdjustValClick(0,-150*rHeight) ;Main Menu
	sleep, %WebsiteDelay%
	MouseClick, left

	sleep, 300
	If LocalBlock
	{
		BlockInput, Off
		return
	}

	sleep, %WebsiteDelay%
	sleep, 400

	AdjustValClick(0,-100*rHeight) ;Deposit
	sleep, %ClickDelay%
	MouseClick, left

	sleep, 1500
	tempVal := DetectAmount(rWidth,rHeight)


	If !(tempVal[1]=0 && tempVal[2]=0)
	{
		AdjustValClick((tempVal[1])*rWidth,(tempVal[2])*rHeight) ;Select Max Amount
		sleep, %ClickDelay%
		MouseClick, left
		
		sleep, 1000
		AdjustValClick((-5*25 - tempVal[1])*rWidth,(4*25 - tempVal[2])*rHeight) ;Confirm Yes
		sleep, %ClickDelay%
		MouseClick, left
		
		;Value SomeHow OverFlowing
		sleep, 2000
		AdjustValClick(550*rWidth,-220*rHeight) ;Close
		sleep, %ClickDelay%
		AdjustValClick(0,-200*rHeight)
		sleep, %ClickDelay%       ;1000
		MouseClick, left
	}
	else
	{
		;sleep, 500
		AdjustValClick((-5*25+550)*rWidth,(4*25-420)*rHeight) ;Close
		sleep, %ClickDelay%
		MouseClick, left
	}

	BlockInput, Off

}

;/////////////////////////////////////////////////////////////////////////////////

GetColour(xLoc,yLoc)
{
	
	;CoordMode, Mouse, Client
	;MouseMove ,%xLoc% ,%yLoc%
	;sleep 1000
	
	color := pixelcolor(xLoc, yLoc)
	If (color = 0xE8E8E8)
	{
		return false
	}
	else
	{
		return true
	}
}

DetectAmount(tWidth,tHeight)
{

	xCord := 479*tWidth
	yCord := 363*tHeight
	xInc := 157*tWidth
	yInc := 79*tHeight
	Mul = 25
	
	xClick := 0
	yClick := 0   ;4*Mul
	;number = 0
	
	If (GetColour(xCord,yCord)=1 && GetColour(xCord +xInc,yCord)=1)
	{
		xClick := -5*Mul
		yClick := -1*Mul
		;number = 1
	}
	If (GetColour(xCord,yCord +yInc)=1 && GetColour(xCord +xInc,yCord +yInc)=1)
	{
		xClick := -5*Mul
		yClick := 2*Mul
		;number = 2 
	}
	If (GetColour(xCord,yCord +yInc*2)=1 && GetColour(xCord +xInc,yCord +yInc*2)=1)
	{
		xClick := -5*Mul
		yClick := 6*Mul
		;number = 3
	}
	xCord := 728*tWidth
	
	If (GetColour(xCord,yCord)=1 && GetColour(xCord +xInc,yCord)=1)
	{
		xClick := 5*Mul
		yClick := -1*Mul
		;number = 4
	}
	If (GetColour(xCord,yCord +yInc)=1 && GetColour(xCord +xInc,yCord +yInc)=1)
	{
		xClick := 5*Mul
		yClick := 2*Mul
		;number = 5 
	}
	If (GetColour(xCord,yCord +yInc*2)=1 && GetColour(xCord +xInc,yCord +yInc*2)=1)
	{
		xClick := 5*Mul
		yClick := 5*Mul
		;number = 6
	}
	
	;SplashTexton,,,%number%
	;sleep , 1000
	;SplashTextOff
	
	return [xClick*tWidth,yClick*tHeight]
}


IsFullScreen()
{
	global target
    
    WinGet, WinMinMax, MinMax, % target
    WinGetPos, WinX, WinY, WinW, WinH, % target

    if (WinMinMax = 0) && (WinX = 0) && (WinY = 0) && (WinW = A_ScreenWidth) && (WinH = A_ScreenHeight)
    {
        WinGetClass, WinClass, % target
        WinGet, WinProcessName, ProcessName, % target
        SplitPath, WinProcessName, , , WinProcessExt

        if (WinClass != "Progman") && (WinProcessExt != "scr")
        {
            return true
        }
    }
	return false
}

CalculateCenter()
{
	global target
	WinGetPos, x0, y0, Width, Height, % target
	state := IsFullScreen()
	oy := state ? 0 : 25
	ox := state ? 0 : 14
	xc := x0 + Width//2 - 15 + ox
	yc := y0 + Height//2 - 13 + oy
	;Msgbox, % format("x0:{} y0:{} xc:{} yc:{} ox:{} oy:{}",x0,y0,xc,yc,ox,oy)
	return [xc,yc]
}

SetChCenter()
{
	global
	pCenter := CalculateCenter()
	ChxAxis := pCenter[1]
	ChyAxis := pCenter[2]
	LoadChAxis()
	UpdateCrosshair()
}


;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;Crosshair



InitCh()
{
	global
	AnimationCondition()
	Settimer,ChTimer,500
}

toggleAnimation(LocalLock)
{
	
	LocalVarData := LocalLock ? "On" : "Off"

	if LocalLock
	{
		Hotkey, ~*LButton, LButtonHotkey1
	}
	else
	{
		Hotkey, ~*LButton, LButtonHotkey2
	}
	
	LocalLabelKey := IntJoinFunc("LMouseUpLabel")
	Hotkey, %LocalLabelKey%, LMouseUpLabel, %LocalVarData%
	;tooltip % "toggleAnimation :" LocalLock,,,1
}

UpdateCrosshair(Str="")
{
	global
	if !IntGuiLock
		return
		
	pascal(pen,color,box,dot)
	InnerLine(token1,"L",pen,color.o,color.l,box)
	mDot(token2,"D",pen,color.o,color.d,dot)
}


pascal(byref pen,byref color,byref box,byref dot,offset=3)
{
	global
	pin1 := SliderStat5 + 2*SliderStat7 + SliderStat1+offset + SliderStat2+1
	pin2 := SliderStat5+1 + 2*SliderStat7 + SliderStat1 +offset
	pin3 := SliderStat2 +1
	pin4 := 2*SliderStat3 + 1
	
	box := [{x:ChxAxis-pin1,y:ChyAxis-SliderStat3,l:pin3,w:pin4},{x:ChxAxis+pin2,y:ChyAxis-SliderStat3,l:pin3,w:pin4},{x:ChxAxis-SliderStat3,y:ChyAxis-pin1,l:pin4,w:pin3},{x:ChxAxis-SliderStat3,y:ChyAxis+pin2,l:pin4,w:pin3}]
	dot := {x:ChxAxis,y:ChyAxis,r:SliderStat5+1}
	color := {o:"0x" . dec2hex(round(SliderStat8*2.55)) . ProgressColor3, l:"0x" . dec2hex(round(SliderStat4*2.55)) . ProgressColor1, d:"0x" . dec2hex(round(SliderStat6*2.55)) . ProgressColor2}
	pen := SliderStat7
}

GuiLineStat()
{
	global
	if Chbox1 && Chbox3
	{
		ShowGdip("L")
	}
	else
	{
		HideGdip("L")
	}
	
}

GuiDotStat()
{
	global
	if Chbox1 && Chbox4
	{
		ShowGdip("D")
	}
	else
	{
		HideGdip("D")
	}
	
}

InnerLine(byref token,id,t,c1,c2,data)
{
	global Chbox5
	
	Width := 1366, Height := 766

	token := Gdip_Startup()

	Gui, %id%:+E0x20 +E0x80000  +LastFound +ToolWindow -Caption +AlwaysOnTop +Disabled
	GuiLineStat()
	
	hwnd1 := WinExist()
	hbm := CreateDIBSection(Width, Height)
	hdc := CreateCompatibleDC()
	obm := SelectObject(hdc, hbm)
	G := Gdip_GraphicsFromHDC(hdc)

	Gdip_SetSmoothingMode(G, 0)
	t+=1
	pPen := Gdip_CreatePen(c1, t)
	pBrush := Gdip_BrushCreateSolid(c2)
	
	Loop % 4
	{
		list := data[A_index]
		x := list.x
		y := list.y
		length := list.l
		breath := list.w
		
		if Chbox5
			Gdip_DrawRectangle(G, pPen, x-round(t/2), y-round(t/2), length+t, breath+t)
		Gdip_FillRectangle(G, pBrush, x, y, length, breath)
	}
	Gdip_DeletePen(pPen)
	Gdip_DeletePen(pBrush)
	UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
}


mDot(byref token,id,t,c1,c2,data)
{
	global RadioIndex,Chbox5

	Width := 1366, Height := 766
	
	radius := data.r-1
	x := data.x
	y:= data.y

	token := Gdip_Startup()

	Gui, %id%:+E0x20 +E0x80000  +LastFound +ToolWindow -Caption +AlwaysOnTop +Disabled
	GuiDotStat()
	
	hwnd1 := WinExist()
	hbm := CreateDIBSection(Width, Height)
	hdc := CreateCompatibleDC()
	obm := SelectObject(hdc, hbm)
	G := Gdip_GraphicsFromHDC(hdc)

	t+=1
	pPen := Gdip_CreatePen(c1, t)
	pBrush := Gdip_BrushCreateSolid(c2)

	if (RadioIndex =2)
	{
		Gdip_SetSmoothingMode(G, 4)
		diameter := 2*radius
		
		if Chbox5
			Gdip_DrawEllipse(G, pPen, x-t/2-(diameter+1)/2, y-t/2-(diameter+1)/2, (diameter+1)+t, (diameter+1)+t)
		Gdip_FillEllipse(G, pBrush, x-(diameter+1)/2, y-(diameter+1)/2, (diameter+1), (diameter+1))
	}
	else
	{
		Gdip_SetSmoothingMode(G, 0)
		
		if Chbox5
			Gdip_DrawRectangle(G, pPen, x-round(t/2)-radius, y-round(t/2)-radius, (2*radius+1)+t,(2*radius+1)+t)
		Gdip_FillRectangle(G, pBrush, x-radius, y-radius, 2*radius+1, 2*radius+1)
	}

	Gdip_DeletePen(pPen)
	Gdip_DeletePen(pBrush)
	UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
}

ShowGdip(id)
{
	Gui, %id%: Show, NA
}

HideGdip(id)
{
	Gui, %id%: Hide
}

KillGdip()
{
	global
	if token1
		Gdip_Shutdown(token1)
	if token2
		Gdip_Shutdown(token2)
}




DrawBar(id,x,y,length,width,color,opacity)
{
	Gui, %id%:Destroy
	Gui, %id%:+E0x20 +LastFound +ToolWindow -Caption +AlwaysOnTop +Disabled
	Gui, %id%:Color, %color%
	Gui, %id%:Show, x%x% y%y% h%width% w%length% NoActivate,%id%
	WinSet, Transparent, % opacity
}


LbWrite()
{
	global
	writefile(path2,ArrayChatSnippets.join("`n"))
	writefile(path1,ArrayPhonebook.join("`n"))
}

beSave()
{
	global
	CoordMode, ToolTip, Screen
	Tooltip,GTAVMACROS ClOSING....,0,0
	writeinit(SavePath,"Alarm","AlarmDateTime")
}

ScriptExit:
beSave()
wpMain()
tbsave()
MixerExit()
dblsave()
SpWrite()
CbWrite()
LbWrite()
;KillGdip()
debugwrite()
wpdebug()
destroy(MainGui)
ExitApp
return

MainGuiClose:
ShowCh := false
HideMainGui()
InitCh()
SpecificTimer(TabSelected)
return



;//////////////////////////////////////////////////////////////////

HideChGui()
{
	HideGdip("L")
	HideGdip("D")
}

ShowChGui()
{
	global Chbox3,Chbox4
	if Chbox3
		ShowGdip("L")
	if Chbox4
		ShowGdip("D")
}





AnimationCondition()
{
	global
	if ShowCh
	{
		toggleAnimation(0)
	}
	else
	{
		if ChBox1
		{
			toggleAnimation(Chbox2)
		}
		else
		{
			toggleAnimation(0)
		}
	}

}




ToggleGui(LocalVar)
{
	global ChBox1,ShowCh

	if LocalVar
	{
		if ChBox1
		{
			UpdateCrosshair()
		}

		if ShowCh
		{
			ShowMainGui()
		}
		AnimationCondition()
		
		displaypop("Show")
	}
	else
	{
		if ChBox1
		{
			HideChGui()
		}

		if ShowCh
		{
			HideMainGui()
		}
		toggleAnimation(0)
		
		displaypop("Hide")
	}
}

ChTimer()
{
	global
	static ChDoOnce := false
	If WinAppear()
	{
		if ChDoOnce
			ToggleGui(1)
		ChDoOnce := false
	}
	else if !(ChDoOnce) 
	{
		ToggleGui(0)
		ChDoOnce := true
	}
}


TotalChToggle(LocalVar)
{
	global
	
	static State1 := ChBox1
	
	if !LocalVar
	{
		State1 := ChBox1
		GuiControl,Main:,ChBox1, 0
	}
	else
	{
		ChBox1 := State1
		GuiControl,Main:,ChBox1,% State1
	}
	
	AnimationCondition()
	ChBox1 ? ShowChGui() : HideChGui()
}





CbHotkey()
{
	global 
	GuiControlGet, value, Main:, ToggleHotkey
	ToggleHotkey := value
	ToggleHotkeyFunc(ToggleHotkey)
	WrHotkeyVar2 := ToggleHotkey
}




WinAppear()
{
	global target
	return WinActive("ahk_group App_Group") && WinExist(target)
}

;/////////////////////////////////////////////////////////////////////////////////
;func4chat




;	                                                                                                                                                                                                                                  
;"chatbox","discord","home","Enter","Esc","IntMenu","InCar","Phone"
TrackMenu(data)
{
	global logger
	
	static allowedkey := {"chatbox":["home","discord"],"home":["discord"]   ,"discord":[]         ,"Esc":["home","discord"]  ,"IntMenu":["chatbox","discord","home"]                             ,"Phone":["home","discord"]}
	static closingkey := {"chatbox":["Enter","Esc"]   ,"home":["home","Esc"],"discord":["discord"],"Esc":["Esc","RightClick"],"IntMenu":["IntMenu","Esc","Enter","RightClick","LeftClick","Backspace","Phone","Wheel","Down"],"Phone":["Esc","Enter","RightClick","LeftClick"]}
	static atmotion := {"IntMenu":Func("pinterrupt")}
	
	static start := ["chatbox","home","discord","Esc","IntMenu","Phone"]
	static pixel := ["home","Esc","IntMenu","Phone"]
	
	
	size := logger.Count()
	
	
	if (size=0)
	{
		localtemparr := start
	}
	else
	{
		lastElement := logger[size]
		localtemparr := allowedkey[lastElement]
	}
	
	if check(localtemparr,data)
	{
		if !check(pixel,data) || detectpixelof(data,"On")
		{
			logger.push(data)
		}
	}
	else
	{
		if (size=0)
			return 
			
		temp := size
		loop % size
		{
			lastElement :=logger[temp]
			array := closingkey[lastElement]
			
			if check(array,data)
			{
				if !check(pixel,lastElement) || detectpixelof(lastElement,"Off")
				{
					logger.RemoveAt(temp)
					atmotion[lastElement].bind(data,0).call()
					break
				}
				else
				{
					atmotion[lastElement].bind(data,1).call()
				}
			}
			temp-=1
		}
	}
	
	interconsole("menu",GetLastLog())
	ToggleInterHotkey(logger.Count())
}

detectpixelof(label,state)
{
	global SocialClubpixel,EscMenupixel,IntMenupixel,phonepixel
	
	if (state = "On")
	{
		Switch label
		{
			case "home":
				sleep ,200
				return pixelwait(SocialClubpixel,,3,100)
			case "Esc":
				sleep ,400
				return pixelwait(EscMenupixel,,3,100)
			case "IntMenu":
				sleep, 200
				return pixelwait(IntMenupixel,,3,50)
			case "Phone":
				sleep, 200
				return pixelwait(phonepixel,,3,200)
		}
	}
	else
	{
		Switch label
		{
			case "home":
				sleep, 200
				return pixelwait(SocialClubpixel,,2,,,1)
			case "Esc":
				sleep, 100
				return pixelwait(EscMenupixel,,2,400,,1)
			case "IntMenu":
				sleep, 200
				return pixelwait(IntMenupixel,,2,,,1)
			case "Phone":
				sleep, 200
				return pixelwait(phonepixel,,2,,,1)
		}
	}
}





check(arr,data)
{
	for key, value in arr 
	{
		if (value == data)
			return 1
	}
	return 0
}

GetLastLog()
{
	global logger
	return logger[logger.Count()]
}

EmptyLastLog(iMenu)
{
	global
	if (GetLastLog()==iMenu)
	{
		logger.pop()
		interconsole("menu",GetLastLog())
		ToggleInterHotkey(logger.Count())
	}
}

;/////////////////////////////////////////////////////////////////////



ToggleInterHotkey(size)
{
	static function := Func("AutoShort").bind(1)
	global HotkeyStateVar,ScrollWheelVar,AutoOpenHotkey
	if (size=0)   ;list empty then turn On Hotkey
	{
		if !(HotkeyStateVar)
		{
			ToggleHotkeyFunc(1)
			ToggleScrollWheel(ScrollWheelVar)
			Settimer,% function ,Off
			HotkeyStateVar:=true
		}
	}
	else
	{
		if (HotkeyStateVar)
		{
			ToggleHotkeyFunc(0)
			ToggleScrollWheel(0)
			HotkeyStateVar:=false
		}
		Settimer,% function ,% AutoOpenHotkey
	}
}

AutoShort(LocalLock)
{
	global HotkeyStateVar,ScrollWheelVar,logger
	ToggleHotkeyFunc(LocalLock)
	ToggleScrollWheel(ScrollWheelVar)
	HotkeyStateVar:=true
	logger := []
}






TabToggleScroll(temp)
{
	global ScrollWheelVar,logger
	if (ScrollWheelVar=1 && logger.Count()=0)
	{
		if temp
			ToggleScrollWheel(1)
		else
			ToggleScrollWheel(0)
	}
}

fToggleScroll()
{
	global ScrollWheelVar,logger,fScrollVar
	if (ScrollWheelVar=0 && logger.Count()=0)
	{
		fScrollVar:=true
	}
}

GetWeaponWheel()
{
	global CurrentWeapon,MaskTabsWith
	
	sleep,2000
	BlockInput, MouseMove
	Send {%MaskTabsWith% Down}
	sleep 200
	CurrentWeapon := GetWeaponWheelStats()
	Send {%MaskTabsWith% Up}
	BlockInput, MouseMoveOff
	;interprompt("prompter",["Current Weapon {}",CurrentWeapon])
	;interconsole("weapon",CurrentWeapon)
	public_weapon()
}


ToggleDrawCh(state)
{
	global
	
	ListLines("Off")
	if (state)
	{
		pascal(pen,color,box,dot,round((SliderStat2+3)*0.75))
		InnerLine(token1,"L",pen,color.o,color.l,box)
	}
	else
	{
		pascal(pen,color,box,dot)
		InnerLine(token1,"L",pen,color.o,color.l,box)
	}
	ListLines()
}


;/////////////////////////////////////////////////////////////////////////////////////////////
;Overide Keys


;/#If WinReport2()


BothChatLabel:
StringTrimLeft, ChatSnippetKey, A_ThisHotkey, 2
TrackMenu("chatbox")
return

DiscordLabel:
TrackMenu("discord")
return

SocialClubLabel:
TrackMenu("home")
return

#InputLevel 1
*NumpadEnter::Enter
#InputLevel 0
TrackMenu("Enter")
return

ESend1Label:
TrackMenu("Enter")
return


InGameMenuLabel:
TrackMenu("Esc")
return

IntMenuLabel:
TrackMenu("IntMenu")
return

PhoneMenuLabel:
TrackMenu("Phone")
return

rMouseLabel:
TrackMenu("RightClick")
return





BackSpaceLabel:
TrackMenu("Backspace")
return

DownSendLabel:
TrackMenu("Down")
return





;/#If WinReport1()











TabSendLabel:
If !GetKeyState("LAlt","P")
{
	;SetKeyDelay -1
	;Send {Blind}{%MaskTabsWith% DownR}
	
	TabToggleScroll(0)
	md.SetState(1)
	KeyWait Tab
}
return

TabUpSendLabel:
If !GetKeyState("LAlt","P")
{
	;SetKeyDelay -1
	;Send {Blind}{%MaskTabsWith% up}
	
	CurrentWeapon :=mousewait()
	md.SetState(0)
	TabToggleScroll(1)
	public_weapon()
}
return


fSendLabel:
temp0 := GetLastLog()
if check(["IntMenu","Phone"],temp0)
{
	ScrollWheelVar:=!ScrollWheelVar
}
if (temp0="")
{
	ScrollWheelVar:=!ScrollWheelVar
	ToggleScrollWheel(ScrollWheelVar)
}
if fScrollVar
{
	if forceWeaponCheck
		GetWeaponWheel()
	fScrollVar:=false
}
LctrlNeedSleep:=true
return


WheelUpHotkey1:
WheelDownHotkey1:
temp0 := GetLastLog()
if (temp0="")
{
	WeaponWheelScroll(A_ThisLabel)
}
else
{
	TrackMenu("Wheel")
}
;tooltip, Weapon Scroll,,,2
return


WheelUpHotkey2:
WheelDownHotkey2:
temp0 := GetLastLog()
if (temp0="")
{
	fToggleScroll()
}
else
{
	TrackMenu("Wheel")
}
;tooltip, Just Scroll,,,2
return


LButtonHotkey1:
temp0 := GetLastLog()
if (temp0="")
{
	ToggleDrawCh(1)
}
else
{
	TrackMenu("LeftClick")
}
;tooltip, LButtonHotkey1 ch +,,,2
return


LButtonHotkey2:
TrackMenu("LeftClick")
;tooltip, LButtonHotkey2,,,2
return


LMouseUpLabel:
ToggleDrawCh(0)
return

;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////

;helps to take screenShot again
LWinSendLabel:
Suspend Permit
SendInput {LWin Down}
KeyWait LWin
SendInput {LWin Up}
return


;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;Delete

;~*Numpad0::Space

;/////////////////////////////////////////////////////////////////////////////////
;Overrided Keys



LCtrlSendLabel:               ;Key Press
Suspend Permit
Send {Numpad5 Down}
if LctrlNeedSleep
{
	sleep, 400
}
Send {LCtrl}
KeyWait LCtrl
LctrlNeedSleep:=false
return

LCtrlUpSendLabel:            ;Key Release
Suspend Permit
Send {Numpad5 Up}
Send {LCtrl}
return


;/////////////////////////////////////////////////////////////////////////////////
;Keyboard


SpaceSendLabel:
Suspend Permit
KeyWait, Space
sleep, %JumpDelay%

LShiftSendLabel:
Suspend Permit
If GetKeyState("LCtrl","P")
{
	sleep, %WalkDelay%
	Send {LCtrl}
}
return



;Mouse

mMouseLabel:
KeyWait, MButton, T0.4
If ErrorLevel
{
	MouseWheel("WheelUp",30,0)
	KeyWait, MButton
}
else
{
	Send {Up}
	TrackMenu("Phone")
}
return

;/////////////////////////////////////////////////////////////////////////////////

ViewToggle:
;Suspend Permit
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)

if GetKeyState("tab","P")
{
	Send %LocalKeyTrimed%
	KeyWait, %LocalKeyTrimed%
	return
}

KeyWait, %LocalKeyTrimed%, T0.5
If ErrorLevel
{
	While GetKeyState(LocalKeyTrimed,"P") ;Change View
	{
		Send %LocalKeyTrimed%
		
		if (ToggleFPV=false)
		{
			FOV += 1
		}
		else
		{
			FOV := 1
		}
		
		If (FOV >= 4)
		{
			FOV := 1
			ToggleFPV := true
		}
		else
		{
			ToggleFPV := false
		}
		
		RES := Abs(4-FOV)

		public_fov()
		Sleep, 600
		
	}
}
else
{
	KeyWait, %LocalKeyTrimed%, D T0.2
	if ErrorLevel
	{
		;single press
		
		If ToggleFPV  ;Switch to TPV
		{
			Send {%LocalKeyTrimed% %FOV%}
			KeyWait, %LocalKeyTrimed%, L
			ToggleFPV := !ToggleFPV
		}
		else          ;Switch to FPV
		{	
			Send {%LocalKeyTrimed% %RES%}
			KeyWait, %LocalKeyTrimed%, L
			ToggleFPV := !ToggleFPV
		}

	}
	else
	{
		;double press
		
		FOV = 1
		RES := Abs(4-FOV)
		ToggleFPV := false
	}
	public_fov()
}

;SplashTextOn, , , FOV= %FOV%   RES= %RES%
;sleep 1000
;SplashTextOff
;public_fov()

return

;/////////////////////////////////////////////////////////////////////////////////

;/////////////////////////////////////////////////////////////////////////////////////////////

;func4chat
ToggleScrollWheel(LocalLock)
{
	InterMediateScroll(LocalLock)
	
	;interprompt("prompter",["Scroll :{}",LocalVarData])
	interconsole("incar",LocalLock)
}

InterMediateScroll(LocalLock)
{
	LocalVarData := LocalLock ? "On" : "Off"
	
	if LocalLock
	{
		Hotkey, ~*WheelUp   , WheelUpHotkey1
		Hotkey, ~*WheelDown , WheelDownHotkey1
	}
	else
	{
		Hotkey, ~*WheelUp   , WheelUpHotkey2
		Hotkey, ~*WheelDown , WheelDownHotkey2
	}
	;tooltip, % "InterMediateScroll " LocalLock,,,1
}

;Crosshair
ToggleHotkeyFunc(LocalVar)
{
	InterMediateHotkey(LocalVar)
	
	;interprompt("prompter",["Hotkey :{}",LocalVarData])
	interconsole("hotkey",LocalVar)
}

InterMediateHotkey(LocalVar)
{
	global 
	LocalVarData := LocalVar ? "On" : "Off"
	
	if LocalVar
		WrHotkeyVar1 := ToggleHotkey
	else
		WrHotkeyVar1 := 0
}

;/////////////////////////////////////////////////////////////////////////////////
;/#If ShowCh

ESend2Label:
if (TabSelected=2 && GetGuiFocus(MainGui,"Main") == "CbV1")
{
	CbEnter(hCbx1)
}
KeyWait Enter
return

LMouseLabel:
InitLeftClick := A_TickCount
vName := GetGuiSelected("Lb")
if (vName = "LbStr" RadioIndex2)
{
	goSub, LbMove
}
return

LAltLabel:
LbMSelect := !LbMSelect
LbToggle(LbMSelect)
return



;/////////////////////////////////////////////////////////////////////////////////

LbDelete:
if (TabSelected=3 && !LbMSelect)
{
	GuiControl, Lb:+AltSubmit, LbStr%RadioIndex2%
	GuiControlGet, LocalIndex, Lb:, LbStr%RadioIndex2%
	GuiControl, Lb:-AltSubmit, LbStr%RadioIndex2%
	
	if (LocalIndex)
	{
		if (RadioIndex2=1)
		{
			ArrayChatSnippets.removeat(LocalIndex)
			ListboxLoad(ArrayChatSnippets,"LbStr1","Lb")
			LocalSize := ArrayChatSnippets.Count()
		}
		else
		{
			ArrayPhonebook.removeat(LocalIndex)
			ListboxLoad(ArrayPhonebook,"LbStr2","Lb")
			LocalSize := ArrayPhonebook.Count()
		}
		LocalIndex := LocalIndex > LocalSize ? LocalIndex - 1: LocalIndex
		GuiControl, Lb:Choose, LbStr%RadioIndex2%, % LocalIndex
	}
}
return


LbMove:
LocalIndex2 := ""
While(GetKeyState("LButton","P") && !LbMSelect )
{
	sleep 10
	GuiControl, Lb:+AltSubmit, LbStr%RadioIndex2%
	GuiControlGet, LocalIndex1, Lb:, LbStr%RadioIndex2%
	GuiControl, Lb:-AltSubmit, LbStr%RadioIndex2%
	LocalIndex2 := LocalIndex2 ? LocalIndex2 : LocalIndex1
	if (LocalIndex1 != LocalIndex2)
	{
		GuiControl,Lb:Hide,LbStr%RadioIndex2%
		if (RadioIndex2=1)
		{
			temp0 := ArrayChatSnippets[LocalIndex1]
			ArrayChatSnippets[LocalIndex1] := ArrayChatSnippets[LocalIndex2]
			ArrayChatSnippets[LocalIndex2] := temp0
			GuiControlGet, OutputId, Lb:Hwnd, LbStr1
			
			temp1 := GetScrollPos(OutputId,1)
			ListboxLoad(ArrayChatSnippets,"LbStr1","Lb")
			vSetScrollPos(OutputId,temp1)
			GuiControl, Lb:Choose, LbStr1, % LocalIndex1
		}
		else
		{
			temp0 := ArrayPhonebook[LocalIndex1]
			ArrayPhonebook[LocalIndex1] := ArrayPhonebook[LocalIndex2]
			ArrayPhonebook[LocalIndex2] := temp0
			GuiControlGet, OutputId, Lb:Hwnd, LbStr2
			
			temp1 := GetScrollPos(OutputId,1)
			ListboxLoad(ArrayPhonebook,"LbStr2","Lb")
			vSetScrollPos(OutputId,temp1)
			GuiControl, Lb:Choose, LbStr2, % LocalIndex1
		}
		LocalIndex2 := LocalIndex1
		GuiControl,Lb:Show,LbStr%RadioIndex2%
		break
	}
	
}
KeyWait, Lbutton
return

;/////////////////////////////////////////////////////////////////////////////////
;/#If


AppsSendLabel:
Suspend Permit
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%, T0.5
If ErrorLevel       ;long press
{
	Send {%LocalKeyTrimed% Down}
	ExitApp
}
else
{
	KeyWait, %LocalKeyTrimed%, D T0.2
    If ErrorLevel
	{               ;Single Press
	
		
		If WinAppear()
		{
			if FlipSwitch
			{
				ToggleHotkeyFunc(1)
				ToggleGui(1)
				Settimer,ChTimer,500
			}
			else
			{
				ToggleHotkeyFunc(0)
				ToggleGui(0)
				Settimer,ChTimer,Off
			}
			
			Text := FlipSwitch ? "On" : "Off"
			FlipSwitch := !FlipSwitch
			
			splashtexton,63,,Hotkey %Text%
			sleep,500
			splashtextoff
			
		}
	}
    else
	{
		PlaySound(SoundPath3)
		sleep, 1000
        Reload		;Double Press
	}
}
return

SlashSoundLabel:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
KeyWait, %LocalKeyTrimed%
KeyWait, %LocalKeyTrimed%, D T0.2
if !ErrorLevel
{
	;double press
	ToggleSound := !ToggleSound
	GuiControl,Main:,ToggleSound,% ToggleSound
	writeinit(gSavePath,"Gui","ToggleSound")
	goSub, Alarm
}
return

NumpadAddLabel:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
If WinAppear() && !FlipSwitch
{
	KeyWait, %LocalKeyTrimed%
	KeyWait, %LocalKeyTrimed%, D T0.2
	if ErrorLevel
	{
		ChBox1 := !ChBox1
		GuiControl,Main:,ChBox1,% ChBox1
	}
	else
	{
		ChBox2 := !ChBox2
		GuiControl,Main:,ChBox2,% ChBox2
	}
	UpdateCrosshair()
	AnimationCondition()
}
return

TildeSendLabel:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
If WinAppear() && !FlipSwitch
{
	KeyWait, %LocalKeyTrimed%, T0.5
	If ErrorLevel
	{
		;long press
		
		ShowCh := !ShowCh
		
		ToggleOnMessage("Gui",ShowCh)
		if ShowCh
			ShowMainGui()
		else
			HideMainGui()
			
		UpdateCrosshair()
		AnimationCondition()
		
		SpecificTimer(TabSelected)
		
		if (TrDoOnce && tb4ch2)
		{
			SetOpacity(MainGui,0,1)
			WindowOpacity()
			TrDoOnce:=false
		}
		
		KeyWait, %LocalKeyTrimed%
	}
	else
	{
		;single press
		
		TargetInFocus()
	}
}
return

TargetInFocus()
{
	global
	if WinActive(target) && ShowCh
		WinActivate, ahk_exe AutoHotkey.exe
	else
		WinActivate, %target%
}

WinReport1(Key="")
{
	global 
	return WinActive(target) && (WrHotkeyVar1 || Key=GetLastLog())
}

WinReport2(Key="")
{
	global 
	return WinActive(target) && WrHotkeyVar2
}

GuiState()
{
	global
	return WinActive("ahk_id " MainGui ) && ShowCh
}

LCtrlReport()
{
	global
	return WinReport1() && HoldLCtrl
}

BlockCh()
{
	global
	GuiControlGet,value,Main:, Chbox1
	if value
	{
		GuiControl,Main:,ChBox1,0
		Chbox1 := 0
		AnimationCondition()
		HideChGui()
	}
}

BlockMain()
{
	global
	if ShowCh
	{
		ShowCh := false
		HideMainGui()
	}
}


;/////////////////////////////////////////////////////////////////////////////////
;Hacks

btHacks:
Suspend On
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
BlockMain()
BlockCh()
HackDetectMode()
KeyWait, %LocalKeyTrimed%
Suspend Off
return


;/////////////////////////////////////////////////////////////////////////////////
;HotVoice

HotVoiceLabel:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
Switch ddlSelectHv
{
	case 2:
	{
		HvTripState := !HvTripState
		SetEarState(HvTripState)
	}
	
	case 3:
	{
		HvTripState := 1
		SetEarState(1)
	}
}
KeyWait, %LocalKeyTrimed%
return


HotVoiceUp:
if (ddlSelectHv=3)
{
	HvTripState := 0
	SetEarState(0)
}
return

;/////////////////////////////////////////////////////////////////////////////////
;Hotkeys


MuteHoldLabel:
LocalKeyTrimed := IntKeyFunc(A_ThisLabel)
Switch ddlSelectMode
{
	case 2:
	{
		MicTripState := !MicTripState
		SetMuteState(MicTripState)
	}
	case 3:
	{
		MicTripState := 1
		SetMuteState(1)
	}
	case 4:
	{
		MicTimerStart := A_TickCount
		if !MicTimerState
		{
			MicTripState := 1
			SetMuteState(1)
			MicTimerState := 1
			SetTimer, MicTimerLabel, 100
		}
	}
}
KeyWait, %LocalKeyTrimed%
return


MuteUpLabel:
if (ddlSelectMode=3)
{
	MicTripState := 0
	SetMuteState(0)
}
return



;/////////////////////////////////////////////////////////////////////////////////
;End

EndTask:
if (PopMsg)
{
    Msgbox("Kill game process?",10,TimeOut,Ok,Cancel)
    If Cancel || TimeOut
	{
		return
	}
}
Process, Close, GTA5.exe
return

SuspendTask:
;double press suspend
Suspend On
KeyWait, End
KeyWait, End, D T0.2
If !ErrorLevel            
{
	btSuspend()
}
Suspend Off
return


;/#If WinReport1()
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

btSuspend()
{
	global
	if (PopMsg)
	{
		Msgbox("Suspend process?",10,TimeOut,Ok,Cancel)
		If Cancel || TimeOut
		{
			Suspend Off
			return
		}
	}
	SuspendProcess("GTA5.exe","On")
	Sleep, 10000
	SuspendProcess("GTA5.exe","Off")
}

SuspendProcess(process,state)
{
	Process, Exist, % (process="") ? DllCall("GetCurrentProcessID") : process
    PID := (InStr(process,".")) ? Errorlevel : process
    Handler := DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", PID)
    If !Handler
        return -1
	If state = On
	{
		DllCall("ntdll.dll\NtSuspendProcess", "Int", Handler)
		DllCall("CloseHandle", "Int", Handler)
		return 1
	}
	else
	{
		DllCall("ntdll.dll\NtResumeProcess", "Int", Handler)
		DllCall("CloseHandle", "Int", Handler)
		return 0
	}
}

;/////////////////////////////////////////////////////////////////////////////////


DisplayAdapter()
{
	s:=""
	Adapters := GetConnectedAdpater()
	for k, v in Adapters
		s .= format("{}`n{}`n`n",v.0,v.1)
	Msgbox % s
}

RetrieveAdapter(exception:="")
{
	global AdapterRadioArr,AdapterRadioIndex,NetworkAdapter,SavePath,AdapterPipes
	
	readinit(SavePath,"Network","AdapterPipes")
	
	If (AdapterPipes == "")
	{
		Adapters := GetConnectedAdpater()
		for k, v in Adapters
		{
			AdpaterName := v.0
			if !check(exception,AdpaterName)
				AdapterRadioArr.push(AdpaterName)
		}
		size := AdapterRadioArr.Count()
		if !(size<2)
		{
			Gui, Net:New ,+AlwaysOnTop -MinimizeBox +LastFound +ToolWindow +Border +HwndNetwGui
			Gui, Net:Add, Text,, Select Active Internet Connection
			Loop % AdapterRadioArr.Count()
			{
				text := AdapterRadioArr[A_index]
				if (A_index = 1)
					Gui, Net:Add, Radio, vAdapterRadioIndex, % text
				else
					Gui, Net:Add, Radio, ,% text
			}
			Gui, Net:Add, Button, yp+20 h20 w50 gButtonOK, OK
			Gui, Net:show,w200
			
		}
		else if (size=1)
		{
			NetworkAdapter := AdapterRadioArr[1]
			AdapterPipes := AdapterRadioArr[1] . "||"
			writeinit(SavePath,"Network","AdapterPipes")
		}
		return
	}
	
	AdapterRadioArr := cbparse(AdapterPipes,NetworkAdapter)
}

ButtonOK:
Gui, Net:Submit, nohide
NetworkAdapter := AdapterRadioArr[AdapterRadioIndex]
AdapterPipes := cbjoin(AdapterRadioArr,NetworkAdapter)
if (NetworkAdapter != "")
{
	writeinit(SavePath,"Network","AdapterPipes")
	Gui, Net:Destroy
}
menu["network"].set(AdapterRadioIndex)
return



ToggleInternet:
If (NetworkAdapter != "")
{
	If CheckConnection()
		EnableNet(NetworkAdapter)
	else
		DisableNet(NetworkAdapter)
}
return


EnableNet(Adapter)
{
	run, *runas %comspec% /c netsh interface set interface name="%Adapter%" admin=enabled,,hide
}

DisableNet(Adapter)
{
	run, *runas %comspec% /c netsh interface set interface name="%Adapter%" admin=disabled,,hide
}


;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;ESCAPE MENU

ExpandedMap:

BlockInput, On
Send {ESC}
sleep, %EscDelay%
Send {Right 4}
sleep, %EscDelay2%
Send {Enter}
sleep, %EscDelay2%
Send {Down 5}
sleep, %EscDelay2%
Send {Enter}
sleep, %EscDelay2%
Send {Down 5}
sleep, %EscDelay2%
Send {Right}
sleep, %EscDelay2%
Send {ESC 3}
BlockInput, Off
sleep, %AfterEsc%
return

;/////////////////////////////////////////////////////////////////////////////////

VoiceChat:
BlockInput, On
Send {ESC}
sleep, %EscDelay%
Send {Right 4}
sleep, %EscDelay2%
Send {Enter}
sleep, %EscDelay2%
Send {Up 4}
sleep, %EscDelay2%
Send {Enter}
sleep, %EscDelay2%
Send {Right}
sleep, %EscDelay2%
Send {ESC 3}
BlockInput, Off
sleep, %AfterEsc%
return


/*

;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////

JoinFriends:
BlockInput, On
Send {ESC}
sleep, %EscDelay%

Send {Right}{Enter}{Down}
sleep, %EscDelay2%
Send {Enter}
BlockInput, Off
return

;/////////////////////////////////////////////////////////////////////////////////

JoinCrewMembers:
BlockInput, On
Send {ESC}
sleep, %EscDelay%

Send {Right}
sleep, %EscDelay2%
Send {Enter}
sleep, %EscDelay2%
Send {Down 2}
sleep, %EscDelay2%
Send {Enter}
BlockInput, Off
return

;/////////////////////////////////////////////////////////////////////////////////

*/

