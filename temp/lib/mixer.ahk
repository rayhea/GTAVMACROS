;https://github.com/C-Peck/Mic-Manager

ButtonIcon(Handle, File, Index := 1, Size := 30, Margin := 6, Align := 4)
{
    Size -= Margin
    Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
    VarSetCapacity( button_il, 20 + Psz, 0 )
    NumPut( normal_il := DllCall( "ImageList_Create", DW, Size, DW, Size, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )
    NumPut( Align, button_il, 16 + Psz, DW )
    SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
    return IL_Add( normal_il, File, Index )
}

SupUnSup(Mode="")
{
	global
	if (Mode)
		OnMessage(0x0111, "Suppress_EN_CHANGE")
	else
		OnMessage(0x0111, "")
}

Suppress_EN_CHANGE(wParam)
{
	If (wParam >> 16) = 0x300
		Return 0
}

HvIntGui(byref ydisp=0)
{
	global
	
	;HotVoice
	
	ydisp += 30
	Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h48,HotVoice
	
	ydisp += 20
	zdisp := ydisp-1
	Gui, Main:Add, Button, x10 y%zdisp% h23 w23 hwndHvTripHwnd
	tempf := Func("SetToggleHv").bind("HvTrip")
	GuiControl, Main:+g, % HvTripHwnd, % tempf 

	xdisp := 40
	Gui, Main:Add, DropDownList, AltSubmit vddlSelectHv x%xdisp% y%ydisp% w80 hwndDDL, % Hvpipeline 
	tempf := Func("SetHotkeysHv").bind(1)
	GuiControl, Main:+g, % DDL, % tempf 
}

MixerGui(byref ydisp=0)
{
	global

	;Microphone
	
	ydisp += 30
	Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h240,Microphone

	ydisp += 30
	Gui, Main:Add, Text,x10 y%ydisp% ,Default

	xdisp := 55
	zdisp := ydisp-3
	Gui, Main:Add, DropDownList, AltSubmit vddlSelectMic gSetWidgetMic x%xdisp% y%zdisp% w115,

	xdisp+=120
	zdisp := ydisp-4
	Gui, Main:Add, Button,gUpdateMicrophone x%xdisp% y%zdisp% h23 w45, refresh

	ydisp += 30
	zdisp := ydisp-1
	Gui, Main:Add, Button, x10 y%zdisp% h23 w23 hwndMicTripHwnd
	tempf := Func("SetToggleMic").bind("MicTrip")
	GuiControl, Main:+g, % MicTripHwnd, % tempf 

	xdisp := 40
	Gui, Main:Add, DropDownList, AltSubmit vddlSelectMode x%xdisp%  y%ydisp% w80 hwndDDL, % Micpipeline 
	tempf := Func("SetHotkeyMic").bind(1)
	GuiControl, Main:+g, % DDL, % tempf 

	ydisp += 30
	Gui, Main:Add, Text, x10 y%ydisp% , Mic Input

	zdisp:=ydisp-3
	xdisp:=60
	Gui, Main:Add, Slider,vMaxInputSlider x%xdisp% y%zdisp% hwndSlider AltSubmit Range0-100, 0
	xdisp:=180
	Gui, Main:Add, Edit,vMaxInputEdit x%xdisp% y%zdisp% hwndEdit number Limit3 w40 , 0
	Gui, Main:Add, UpDown, Range0-100 , 0

	tempf := Func("SetMaxInput").bind("Main","MaxInput","Slider")
	GuiControl, Main:+g, % Slider, % tempf 

	tempf := Func("SetMaxInput").bind("Main","MaxInput","Edit")
	GuiControl, Main:+g, % Edit, % tempf 

	ydisp+=30
	xdisp:=68
	Gui, Main:Add, Progress,vProgressMeter h15 w103 x%xdisp% y%ydisp% cGreen BackgroundE2E2E2,


	ydisp += 30
	Gui, Main:Add, Text, x10 y%ydisp% , Threshold

	zdisp:=ydisp-3
	xdisp:=60
	Gui, Main:Add, Slider,vThresholdSlider x%xdisp% y%zdisp% hwndSlider AltSubmit Range0-100, 0
	xdisp:=180
	Gui, Main:Add, Edit,vThresholdEdit x%xdisp% y%zdisp% hwndEdit number Limit3 w40 , 0
	Gui, Main:Add, UpDown, Range0-100 , 0

	tempf := Func("SliderEdit").bind("Main","ThresholdSlider","ThresholdEdit",0) 
	GuiControl, Main:+g, % Slider, % tempf 

	tempf := Func("SliderEdit").bind("Main","ThresholdSlider","ThresholdEdit",1) 
	GuiControl, Main:+g, % Edit, % tempf 

	ydisp+=30
	xdisp:=68
	Gui, Main:Add, Progress,vProgressTimeout h15 w103 x%xdisp% y%ydisp% cBlack BackgroundE2E2E2,


	ydisp += 35
	Gui, Main:Add, Text, x10 y%ydisp% , Timeout

	zdisp:=ydisp-3
	xdisp:=69
	Gui, Main:Add, Edit,vTimeoutEdit gSetTimeout x%xdisp% y%zdisp% hwndEdit number Limit4 w50 , 0
	Gui, Main:Add, UpDown, , 0

	;speaker

	ydisp += 34
	Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h117, Sounds

	ydisp += 30
	Gui, Main:Add, Text,x10 y%ydisp% ,Default

	xdisp := 55
	zdisp := ydisp-3
	Gui, Main:Add, DropDownList, AltSubmit vddlSelectSpk gSetWidgetSpk x%xdisp% y%zdisp% w115,

	xdisp+=120
	zdisp := ydisp-4
	Gui, Main:Add, Button,gUpdateSpeaker x%xdisp% y%zdisp% h23 w45, refresh
	
	xdisp := 5
	ydisp += 10
	createspkgui(MainGui,0,ImagePath "app1.ico","Master",xdisp,ydisp)
	
	MixerLoad()
	UpdateMicrophone()
	SetHotkeyMic()
	UpdateSpeaker()
	
}

MixerLoad()
{
	global
	readinit(MixerPath,"default","HvTripState")
	readinit(MixerPath,"default","ddlSelectHv")
	GuiControl ,Main:Choose,ddlSelectHv,% ddlSelectHv
	readinit(MixerPath,"default","MicTripState")
	readinit(MixerPath,"default","ddlSelectMode")
	GuiControl ,Main:Choose,ddlSelectMode,% ddlSelectMode
}

MixerExit()
{
	global
	writeinit(MixerPath,"default","HvTripState")
	writeinit(MixerPath,"default","ddlSelectHv")
	writeinit(MixerPath,"default","MicTripState")
	writeinit(MixerPath,"default","ddlSelectMode")
	mpWrite(microphone.default)
	SG2.Destroy()
	MasterVolume(microphone.default,0,100,0)
}

;/////////////////////////////////////////////////////////////////////////////////

SetEarState(value)
{
	global
	
	ButtonIcon(HvTripHwnd,ImagePath "ear" value ".png")
	toggleHv(value)
}

SetToggleHv(template)
{
	global
	Toggle := template . "State"
	Handle := template . "Hwnd"
	%Toggle% := !%Toggle%
	
	ddlSelectHv := 1
	GuiControl ,Main:Choose,ddlSelectHv, 1
	SetHotkeysHv()
}

SetHotkeysHv(mode=0)
{
	global
	
	if mode
		GuiControlGet, ddlSelectHv, Main:, ddlSelectHv
	
	if (ddlSelectHv=3)
	{
		HvTripState := 0
		SetEarState(0)
	}
	else
	{
		SetEarState(HvTripState)
	}
	
}






;/////////////////////////////////////////////////////////////////////////////////

mpWrite(Section)
{
	global
	if Section
	{
		writeinit(MixerPath,Section,"MaxInputEdit")
		writeinit(MixerPath,Section,"ThresholdEdit")
		writeinit(MixerPath,Section,"TimeoutEdit")
	}
}

mpRead(Section)
{
	global
	if Section
	{
		readinit(MixerPath,Section,"MaxInputEdit")
		readinit(MixerPath,Section,"ThresholdEdit")
		readinit(MixerPath,Section,"TimeoutEdit")
	}
}

mpLoad()
{
	global
	MaxInputSlider := MaxInputEdit
	GuiControl, Main:, MaxInputEdit, % MaxInputEdit
	GuiControl, Main:, MaxInputSlider, % MaxInputSlider
	MasterVolume(microphone.default,0,MaxInputEdit,"")

	ThresholdSlider := ThresholdEdit
	GuiControl, Main:, ThresholdEdit, % ThresholdEdit
	GuiControl, Main:, ThresholdSlider, % ThresholdSlider
	GuiControl, Main:, TimeoutEdit, % TimeoutEdit
	
}

mpReset()
{
	global
	MaxInputEdit := 100
	ThresholdEdit := 100
	TimeoutEdit := 50
}

SetMuteState(value)
{
	global
	ButtonIcon(MicTripHwnd,ImagePath "mic" value ".png")
	MasterVolume(microphone.default,0,"",!value)
}




SetWidgetMic()
{
	global
	mpWrite(microphone.default)
	GuiControlGet, ddlSelectMic, Main:, ddlSelectMic
	microphone.default := microphone.unique[ddlSelectMic]
	mpReset()
	mpRead(microphone.default)
	mpLoad()
	SetDefault(microphone.default)
	InitAudioMeter(microphone.default)
}

UpdateMicrophone()
{
	global
	PopulateDevice("microphone")
	ddlSelectMic := cbindex(microphone.unique,microphone.default)
	pipe := cbjoin(microphone.names)
	GuiControl, Main:, ddlSelectMic,|%pipe% 
	GuiControl, Main:Choose, ddlSelectMic, % ddlSelectMic
	mpReset()
	mpRead(microphone.default)
	mpLoad()
	InitAudioMeter(microphone.default)
	SetTimer, MicMeterLabel, 100
	loadgrammar()
	SetHotkeysHv()
}

SetToggleMic(template)
{
	global
	Toggle := template . "State"
	Handle := template . "Hwnd"
	%Toggle% := !%Toggle%
	
	ddlSelectMode := 1
	GuiControl ,Main:Choose,ddlSelectMode, 1
	SetHotkeyMic()
}

SetHotkeyMic(mode=0)
{
	global
	
	if mode
		GuiControlGet, ddlSelectMode, Main:, ddlSelectMode
	
	Switch ddlSelectMode
	{
		case 1:
		{
			MicTimerState := 0
			SetTimer, MicTimerLabel, Off
			SetMuteState(MicTripState)
			
		}
		case 2:
		{
			MicTimerState := 0
			SetTimer, MicTimerLabel, Off
			SetMuteState(MicTripState)
			
		}
		case 3:
		{
			MicTimerState := 0
			SetTimer, MicTimerLabel, Off
			MicTripState := 0
			SetMuteState(0)
			
		}
		case 4:
		{
			MicTripState := 0
			SetMuteState(0)
			
		}
	}
	
	GuiControl,Main:,ProgressTimeout,0
	
}

SetMaxInput(Id,initial,widget)
{
	global
	para1 := initial "Slider"
	para2 := initial "Edit"
	SliderEdit(Id,para1, para2,InStr(widget,"Edit"))
	MasterVolume(microphone.default,0,%para1%,"")
}

SetTimeout()
{
	global
	GuiControlGet, TimeoutEdit, Main:, TimeoutEdit
}


;/////////////////////////////////////////////////////////////////////////////////
;Timers

GetMeterLevel(Label)
{
	global
	if microphone.default
	{
		VA_IAudioMeterInformation_GetPeakValue(AudioMeter, value)
		return value
	}
	else
	{
		SetTimer, % Label, Off
		throw 0
	}
}

MicTimerLabel:
try
{
	value := GetMeterLevel(A_ThisLabel)*100
	if (value > ThresholdEdit)
	{
		MicTimerStart := A_TickCount
		GuiControl,Main:,ProgressTimeout,0
		return
	}
	if (A_TickCount-MicTimerStart > TimeoutEdit*1000)
	{
		MicTimerState := 0
		SetTimer, MicTimerLabel, Off
		MicTripState := 0
		SetMuteState(0)
		GuiControl,Main:,ProgressTimeout,0
	}
	else
	{
		diff := A_TickCount-MicTimerStart
		percent:=Floor((diff)/(TimeoutEdit*10))
		GuiControl,Main:,ProgressTimeout,% percent
	}
}
return

MicMeterLabel:
try
{
	value := GetMeterLevel(A_ThisLabel) * 100
	GuiControl,Main:,ProgressMeter, % value
}
return



;/////////////////////////////////////////////////////////////////////////////////
;Sounds

createspkgui(Uid,index,icon,text,xdisp=0,ydisp=0)
{
	global
	
	desc := "MixerWidget" index
	%desc% := index
	hwnd := desc . "hwnd"
	vars := desc . "state"
	%vars% := 1
	
	ydisp += 19
	xdisp += 8
	Gui, Font, Underline, Consolas 
	Gui, %Uid%:Add, Text,v%desc%Text x%xdisp% y%ydisp% w207 h20 Left,% text
	Gui, Font
	
	ydisp += 26
	zdisp := ydisp-2
	Gui, %Uid%:Add, Picture, x%xdisp% y%zdisp% h19 w19, % icon
	
	zdisp:=ydisp-3
	xdisp += 25
	Gui, %Uid%:Add,Button,v%desc%btn x%xdisp% y%zdisp% h23 w23 hwnd%hwnd%
	tempf := Func("SetToggleSpk").bind(desc) 
	GuiControl, %Uid%:+g, % %hwnd%, % tempf 

	xdisp += 22
	Gui, %Uid%:Add, Slider,v%desc%Slider x%xdisp% y%zdisp% hwndSlider AltSubmit Range0-100
	xdisp += 120
	Gui, %Uid%:Add, Edit,v%desc%Edit x%xdisp% y%zdisp% hwndEdit number Limit3 w40
	Gui, %Uid%:Add, UpDown, Range0-100 , 0
	
	tempf := Func("SetVolumes").bind(Uid,desc,"Slider")
	GuiControl, %Uid%:+g, % Slider, % tempf 
	tempf := Func("SetVolumes").bind(Uid,desc,"Edit")
	GuiControl, %Uid%:+g, % Edit, % tempf 
}

LoadSpkWidget(uid,index,level,muted)
{
	global
	;state := error ? "Enable":"Disable"
	desc := "MixerWidget" index
	Toggle := desc . "State"
	%Toggle% := !muted
	Handle := desc . "Hwnd"
	ButtonIcon(%Handle%,ImagePath "spk" . %Toggle% . ".png")
	;GuiControl, %uid%:%state%,% desc "btn"
	level := floor(level)
	para1 := desc "Slider"
	%para1% := level
	GuiControl, %uid%:,% para1, % %para1%
	;GuiControl, %uid%:%state%,% para1
	para2 := desc "Edit"
	%para2% := level
	GuiControl, %uid%:,% para2, % %para2%
	;GuiControl, %uid%:%state%,% para2
}


SetWidgetSpk()
{
	global
	
	GuiControlGet, ddlSelectSpk, Main:, ddlSelectSpk
	speakers.default := speakers.unique[ddlSelectSpk]
	SetDefault(speakers.default)
}

UpdateSpeaker()
{
	global
	
	PopulateDevice("speakers")
	ddlSelectSpk := cbindex(speakers.unique,speakers.default)
	pipe := cbjoin(speakers.names)
	GuiControl, Main:, ddlSelectSpk,|%pipe% 
	GuiControl, Main:Choose, ddlSelectSpk, % ddlSelectSpk
	
	MasterVolume(speakers.default,1,level,muted)
	LoadSpkWidget(MainGui,0,level,muted)
	
	GetAppInfo()
	
	Gui, New, +hwndHGUI2 +Parent%MainGui%  -Caption -reSize
	;Gui, Color, Black
	Gui, %HGUI2% : Show
	
	xdisp := 5
	ydisp := 0
	Loop % Applications.count()
	{
		WinGet, icon, ProcessPath, % "ahk_exe " Applications[A_index]
		WinGet, name, ProcessName , % "ahk_exe " Applications[A_index]
		
		Gui, %HGUI2%:Add, Text,x%xdisp% y%ydisp% h82
		Gui, %HGUI2%:Add, GroupBox, x%xdisp% y%ydisp% w220 h77
		
		createspkgui(HGUI2,A_index,icon,name,xdisp,ydisp)
		ydisp += 82
		SetAppVolume(A_index,1,level:=0,muted:=1)
		LoadSpkWidget(HGUI2,A_index,level*100,muted)
	}
	
	SG2.Destroy()
	SG2 := New ScrollGUI(HGUI2, 225, 164, "-Caption -reSize ", 2, 2)
	SG2p := "x0 y465 NA"
	SG2.Show("", SG2p)
	SG2.AdjustToChild()
}

SetToggleSpk(template)
{
	global
	Toggle := template . "State"
	Handle := template . "Hwnd"
	%Toggle% := !%Toggle%
	ButtonIcon(%Handle%,ImagePath "spk" . %Toggle% . ".png")
	
	value := %template%
	if !value
	{
		MasterVolume(speakers.default,0,"",!%Toggle%)
	}
	else
	{
		SetAppVolume(value,0,"",!%Toggle%)
	}
}

SetVolumes(Id,initial,widget)
{
	global
	para1 := initial "Slider"
	para2 := initial "Edit"
	SliderEdit(Id,para1, para2,InStr(widget,"Edit"))
	
	value := %initial%
	if !value
	{
		MasterVolume(speakers.default,0,%para1%,"")
	}
	else
	{
		SetAppVolume(value,0,%para1% / 100.0,"")
	}
}




;/////////////////////////////////////////////////////////////////////////////////


PopulateDevice(template)
{
	static CLSID := "{BCDE0395-E52F-467C-8E3D-C4579291692E}"
		  ,IID_IMM := "{A95664D2-9614-4F35-A746-DE8DB63617E6}"
	
	global microphone, speakers
	
	flow := InStr(template,"microphone")
	enum := ComObjCreate(CLSID,IID_IMM)
	
	%template% := {"unique":[],"names":[],"number":[],"default":""}
	
	if VA_IMMDeviceEnumerator_EnumAudioEndpoints(enum, flow, 1, devices) >= 0
	{
		VA_IMMDeviceEnumerator_GetDefaultAudioEndpoint(enum, flow, 0, device)
		VA_IMMDevice_GetId(device, default_id)
		%template%.default := default_id
		ObjRelease(device)
		
		VA_IMMDeviceCollection_GetCount(devices, count)
		Loop % count
		{
			if VA_IMMDeviceCollection_Item(devices, A_Index-1, device) < 0
				continue
			VA_IMMDevice_GetId(device, id)
			name := VA_GetDeviceName(device)
			
			%template%.unique.push(id)
			%template%.names.push(name)
			%template%.number.push(A_index)
			
			ObjRelease(device)
		}
	}
	
	ObjRelease(enum)
	ObjRelease(devices)
}



;/////////////////////////////////////////////////////////////////////////////////
; 1 -> Get & 0 -> Set

SetDefault(id)
{
	if id
	{
		device_desc := VA_GetDevice(id)
		VA_SetDefaultEndpoint(device_desc, 0)
		ObjRelease(device_desc)
		return 1
	}
}

InitAudioMeter(id)
{
	global
	
	if id
	{
		static IID := "{1CB9AD4C-DBFA-4c32-B178-C2F568A703B2}"
		device := VA_GetDevice(id)
		VA_IMMDevice_Activate(device, IID, 7, 0, AudioClient)
		VA_IAudioClient_GetMixFormat(AudioClient, format)
		VA_IAudioClient_Initialize(AudioClient, 0, 0, 0, 0, format, 0)
		VA_IAudioClient_Start(AudioClient)
		AudioMeter := VA_GetAudioMeter(device)
		VA_GetDevicePeriod(device, AudioPeriod)
		ObjRelease(device)
		return 1
	}
}




GetAppInfo()
{
	SetAppsInfo()
	IMMDeviceEnumerator := ComObjCreate( "{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}" )
	DllCall( NumGet( NumGet( IMMDeviceEnumerator+0 ) + 4*A_PtrSize ), "UPtr", IMMDeviceEnumerator, "UInt", 0, "UInt", 1, "UPtrP", IMMDevice, "UInt" )
	ObjRelease(IMMDeviceEnumerator)

	VarSetCapacity( GUID, 16 )
	DllCall( "Ole32.dll\CLSIDFromString", "Str", "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr", &GUID)
	DllCall( NumGet( NumGet( IMMDevice+0 ) + 3*A_PtrSize ), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 23, "UPtr", 0, "UPtrP", IAudioSessionManager2, "UInt" )
	ObjRelease( IMMDevice )

	DllCall( NumGet( NumGet( IAudioSessionManager2+0 ) + 5*A_PtrSize ), "UPtr", IAudioSessionManager2, "UPtrP", IAudioSessionEnumerator, "UInt" )
	ObjRelease( IAudioSessionManager2 )

	DllCall( NumGet( NumGet( IAudioSessionEnumerator+0 ) + 3*A_PtrSize ), "UPtr", IAudioSessionEnumerator, "UIntP", SessionCount, "UInt" )
	Loop % SessionCount
	{
		DllCall( NumGet( NumGet( IAudioSessionEnumerator+0 ) + 4*A_PtrSize ), "UPtr", IAudioSessionEnumerator, "Int", A_Index-1, "UPtrP", IAudioSessionControl, "UInt" )
		IAudioSessionControl2 := ComObjQuery( IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}" )
		ObjRelease( IAudioSessionControl )

		DllCall( NumGet( NumGet( IAudioSessionControl2+0 ) + 14*A_PtrSize ), "UPtr", IAudioSessionControl2, "UIntP", PID, "UInt" )
		
		PHandle := DllCall( "OpenProcess", "uint", 0x0010|0x0400, "Int", false, "UInt", PID )
		if !( ErrorLevel or PHandle = 0 )
		{
			name_size = 1023
			VarSetCapacity( PName, name_size )
			DllCall( "psapi.dll\GetModuleFileNameEx" . ( A_IsUnicode ? "W" : "A" ), "UInt", PHandle, "UInt", 0, "Str", PName, "UInt", name_size )
			DllCall( "CloseHandle", PHandle )
			SplitPath PName, PName
			SetAppsInfo(IAudioSessionControl2,PName)
		}
	}
	ObjRelease(IAudioSessionEnumerator)
}

MasterVolume(id, mode, byref level="", byref muted="")
{
	if id
	{
		device_desc := VA_GetDevice(id)
		if mode
		{
			level := VA_GetMasterVolume("",device_desc)
			muted := VA_GetMasterMute(device_desc)	
		}
		else
		{
			if (level!="")
				VA_SetMasterVolume(level,"",device_desc)
			if (muted!="")
				VA_SetMasterMute(muted,device_desc)
		}
		ObjRelease(device_desc)
		return 1
	}
}

SetAppVolume( index, mode, byref level="", byref muted="")
{
	global AudioSession,Applications
	
	if WinExist("ahk_exe " Applications[index])
	{
		IAudioSessionControl2 := AudioSession[index]
		ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
		if mode
		{
			DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 4*A_PtrSize ), "UPtr", ISimpleAudioVolume, "FloatP", level, "UInt" )
			DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 6*A_PtrSize ), "UPtr", ISimpleAudioVolume, "IntP", muted )  ; Get mute status
		}
		else
		{
			if (level!="")
				DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 3*A_PtrSize ), "UPtr", ISimpleAudioVolume, "Float", level , "UPtr", 0, "UInt" )
			if (muted!="")
				DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 5*A_PtrSize ), "UPtr", ISimpleAudioVolume, "Int", muted, "UPtr", 0, "UInt" )
		}
		ObjRelease(ISimpleAudioVolume)
		return 1
	}
}

SetAppsInfo(para1="",para2="")
{
	global 
	
	if (para1="" && para2="")
	{
		AudioSession := []
		Applications := []
		return
	}
	
	if WinExist("ahk_exe " para2)
	{
		AudioSession.push(para1)
		Applications.push(para2)
	}
}

SpecificTimer(Select)
{
	static Timers := {1:[Func("GuiTimer")],5:["MicMeterLabel"]}
	global ShowCh
	
	for index,tab in Timers
	{
		state := (Select=index && ShowCh=1) ? 100 : "Off"
		
		Loop % tab.Count()
		{
			label := tab[A_index]
			
			if IsObject(label)
			{
				label.Call(state)
			}
			else
			{
				SetTimer , % label, % state
			}
		}
	}
}

ToggleSG(Select)
{
	global
	
	Scroll := {5:["SG2"]}
	for index,tab in Scroll
	{
		state := (Select=index)
		
		Loop % tab.Count()
		{
			SCO := tab[A_index]
			SCZ := %SCO% "p"
			if state
			{
				%SCO%.Show("",%SCZ%)
			}
			else
			{
				%SCO%.Hide()
			}
		}
	}
}





