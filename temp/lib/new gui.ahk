

;//////////////////////////////////////////////////////////////////

class Gui
{
	__New()
	{
		global
		
		Gui, Main:New ,+AlwaysOnTop -MinimizeBox +LastFound +ToolWindow +Border +hwndMainGui

		Gui,Main:Add, Tab2, AltSubmit x4 y0 w230 h21 +0x100 vTabSelected hwndTable, % tbpipeline
		tempf := this.SizeTab.bind(this)
		GuiControl, Main:+g, % Table, % tempf 
		
		Gui,Main:Tab, Chs

			;///////////////////////////////////////////////////////////////////////////////////////////////

			;Gui, Main:Add, GroupBox, x5 y0 w220 h54

			ydisp := 30
			Gui, Main:Add, CheckBox,x10 y%ydisp% vChbox1 hwndCheckbox ,Enable Crosshair?
			tempf := Func("UpdateCheckbox").bind(Checkbox,1)
			GuiControl, Main:+g, % Checkbox, % tempf 


			ydisp += 30
			Gui, Main:Add, CheckBox,x10 y%ydisp% vChbox2 hwndCheckbox ,Animation?
			tempf := Func("UpdateCheckbox").bind(Checkbox,2)
			GuiControl, Main:+g, % Checkbox, % tempf 
			
			ydisp -= 5
			;///////////////////////////////////////////////////////////////////////////////////////////////

			zdisp := ydisp+30
			Gui, Main:Add, GroupBox, x5 y%zdisp% vboxhead1 Section w220 h28

			ydisp += 40
			Gui, Main:Add, CheckBox,x10 y%ydisp% vChbox3 hwndCheckbox,Inner line
			tempf := Func("UpdateCheckbox").bind(Checkbox,3)
			GuiControl, Main:+g, % Checkbox, % tempf 

			zdisp := ydisp-1
			Gui, Main:Add, Button,x206 y%zdisp% vboxSection1 h15 w15 hwndSection ,X
			tempf := Func("UpdateSection").bind(Section,1)
			GuiControl, Main:+g, % Section, % tempf 

			zdisp := ydisp+15
			Gui, Main:Add, GroupBox, x5 y%zdisp% vboxbody1 Section w220 h170

			
			ydisp += 50
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel1, Offset
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat1 hwndSlider AltSubmit Range0-100
			tempf := Func("UpdateEdit").bind(Slider,1) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% vEditText1 hwndEdit number Limit3 w40 
			tempf := Func("UpdateSlider").bind(Edit,1) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd1, 0

			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel2, Length
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat2 hwndSlider AltSubmit Range0-100, 0
			tempf := Func("UpdateEdit").bind(Slider,2) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% vEditText2 hwndEdit number Limit3 w40 , 0
			tempf := Func("UpdateSlider").bind(Edit,2) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd2, 0


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel3, Width
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat3 hwndSlider AltSubmit Range0-100, 0
			tempf := Func("UpdateEdit").bind(Slider,3) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% vEditText3 hwndEdit number Limit3 w40 , 0
			tempf := Func("UpdateSlider").bind(Edit,3) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd3, 0


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel4, Opacity
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat4 hwndSlider AltSubmit Range0-100, 0
			tempf := Func("UpdateEdit").bind(Slider,4) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% vEditText4 hwndEdit number Limit3 w40 , 0
			tempf := Func("UpdateSlider").bind(Edit,4) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd4, 0


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel5, Color
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderColor1 hwndSlider AltSubmit Tooltip Range1-300, 1
			tempf := Func("UpdatepColor").bind(Slider,1)
			GuiControl, Main:+g, % Slider, % tempf
			Gui, Main:Add, Progress, x180 y%ydisp% vProgressColor1 w40 h20 cWhite BackgroundBlack ,100
			
			;///////////////////////////////////////////////////////////////////////////////////////////////
			zdisp := ydisp+50
			Gui, Main:Add, GroupBox, x5 y%zdisp% vboxhead2 Section w220 h28

			ydisp += 60
			Gui, Main:Add, CheckBox,x10 y%ydisp% vChbox4 hwndCheckbox ,Center Dot
			tempf := Func("UpdateCheckbox").bind(Checkbox,4)
			GuiControl, Main:+g, % Checkbox, % tempf 

			zdisp := ydisp-1
			Gui, Main:Add, Button,x206 y%zdisp% vboxSection2 h15 w15 hwndSection ,X
			tempf := Func("UpdateSection").bind(Section,2)
			GuiControl, Main:+g, % Section, % tempf 

			zdisp := ydisp+15
			Gui, Main:Add, GroupBox, x5 y%zdisp% vboxbody2 Section w220 h142



			ydisp += 30
			Gui, Main:Add, Radio, vRadio1 gUpdateRadio x10 y%ydisp%,Square
			Gui, Main:Add, Radio, vRadio2 gUpdateRadio x80 y%ydisp%,Circle


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel6, Radius
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat5 hwndSlider AltSubmit Range0-100, 0
			tempf := Func("UpdateEdit").bind(Slider,5) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% vEditText5 hwndEdit number Limit3 w40 , 0
			tempf := Func("UpdateSlider").bind(Edit,5) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd5, 0


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel7, Opacity
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat6 hwndSlider AltSubmit Range0-100, 0
			tempf := Func("UpdateEdit").bind(Slider,6) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% vEditText6 hwndEdit number Limit3 w40 , 0
			tempf := Func("UpdateSlider").bind(Edit,6) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd6, 0


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel8, Color
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderColor2 hwndSlider AltSubmit Tooltip Range1-300, 1
			tempf := Func("UpdatepColor").bind(Slider,2)
			GuiControl, Main:+g, % Slider, % tempf
			Gui, Main:Add, Progress, x180 y%ydisp% vProgressColor2 w40 h20 cWhite BackgroundBlack ,100

			;///////////////////////////////////////////////////////////////////////////////////////////////
			zdisp := ydisp+50
			Gui, Main:Add, GroupBox, x5 y%zdisp% vboxhead3 Section w220 h28


			ydisp += 60
			Gui, Main:Add, CheckBox,x10 y%ydisp% vChbox5 hwndCheckbox,Outline
			tempf := Func("UpdateCheckbox").bind(Checkbox,5)
			GuiControl, Main:+g, % Checkbox, % tempf 

			zdisp := ydisp-1
			Gui, Main:Add, Button,x206 y%zdisp% vboxSection3 h15 w15 hwndSection ,X
			tempf := Func("UpdateSection").bind(Section,3)
			GuiControl, Main:+g, % Section, % tempf 

			zdisp := ydisp+15
			Gui, Main:Add, GroupBox, x5 y%zdisp% vboxbody3 Section w220 h112


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel9, Thick
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat7 hwndSlider AltSubmit Range0-100, 0
			tempf := Func("UpdateEdit").bind(Slider,7) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% vEditText7 hwndEdit number Limit3 w40 , 0
			tempf := Func("UpdateSlider").bind(Edit,7) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd7, 0


			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel10, Opacity
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderStat8 hwndSlider AltSubmit Range0-100, 0
			tempf := Func("UpdateEdit").bind(Slider,8) 
			GuiControl, Main:+g, % Slider, % tempf 

			Gui, Main:Add, Edit,    x180 y%ydisp% w40 vEditText8 hwndEdit number Limit3 , 0
			tempf := Func("UpdateSlider").bind(Edit,8) 
			GuiControl, Main:+g, % Edit, % tempf 
			Gui, Main:Add, UpDown, Range0-100 vEditUd8, 0



			ydisp += 30
			Gui, Main:Add, Text,    x10 y%ydisp% vTextlabel11, Color
			Gui, Main:Add, Slider,  x50 y%ydisp% vSliderColor3 hwndSlider AltSubmit Tooltip Range1-300, 1
			tempf := Func("UpdatepColor").bind(Slider,3)
			GuiControl, Main:+g, % Slider, % tempf
			Gui, Main:Add, Progress, x180 y%ydisp% vProgressColor3 w40 h20 cWhite BackgroundBlack ,100

			;///////////////////////////////////////////////////////////////////////////////////////////////

			ydisp += 50
			xdisp := 9
			
			zdisp := ydisp - 21
			Gui, Main:Add, Button, x%xdisp% y%zdisp% w22 h22 gSetChCenter vbtCh, + 
			
			xdisp += 29
			zdisp := ydisp + 4
			Gui, Main:Add, Text,    x%xdisp% y%zdisp% vTextlabel12, Ch X:
			
			xdisp += 35
			Gui, Main:Add, Edit,    x%xdisp% y%ydisp% vChxAxis hwndEdit w50 number Limit4
			tempf := Func("UpdateAxis").bind(Edit,"ChxAxis")
			GuiControl, Main:+g, % Edit, % tempf
			Gui, Main:Add, UpDown, Range1-1366 vEditText9 , 801
			
			xdisp += 59
			Gui, Main:Add, Text,    x%xdisp% y%zdisp% vTextlabel13, Ch Y:
			
			xdisp += 35
			Gui, Main:Add, Edit,    x%xdisp% y%ydisp% vChyAxis hwndEdit w50  number Limit3
			tempf := Func("UpdateAxis").bind(Edit,"ChyAxis")
			GuiControl, Main:+g, % Edit, % tempf
			Gui, Main:Add, UpDown, Range1-766 vEditText10 , 400

			;///////////////////////////////////////////////////////////////////////////////////////////////

			ydisp += 30

			;msgbox % ydisp
			Gui, Main:Add, ComboBox, vCbV1 x10 y%ydisp% w80 hWndhCbx1, %cbStr%
			tempf := Func("Cbfunc").bind(hCbx1,"Main","CbV1","cbArr")
			GuiControl, Main:+g, % hCbx1, % tempf
			
			ydisp -=1
			Gui, Main:Add, Button ,x95 y%ydisp% w20 vbtSave gcbSave,Save
			Gui, Main:Add, Button ,x135 y%ydisp% vbtLoad gcbLoad,Load
			Gui, Main:Add, Button ,x175 y%ydisp% vbtDelete gcbDelete,Delete
			
			
		Gui,Main:Tab, Main
			
			ydisp := 30
			Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h47, Lucky Wheel 
			
			ydisp += 25
			Gui, Main:Add, Text,x10 y%ydisp% ,Alarm ETA:
			
			xdisp := 80
			Gui, Main:Add, Text,vtbText1 x%xdisp% y%ydisp% w20,00hr:00:00
			
			xdisp += 60
			zdisp :=ydisp-4
			
			;Gui, Main:Add, Progress,vProgressBar x%xdisp% y%zdisp% w80 h20 cBlue BackgroundE2E2E2,0
			pSlider := New Progress_Slider("Main","ProgressBar",xdisp,zdisp,80,20,0,100,0,"E2E2E2","Blue","AlarmSlider")
			
			ydisp += 30
			Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h140, Settings
			
			ydisp += 25
			Gui, Main:Add, CheckBox,vToggleHotkey gCbHotkey x10 y%ydisp%, HotKey
			
			ydisp += 30
			Gui, Main:Add, CheckBox,vHoldLCtrl gCbHoldSneak x10 y%ydisp%,Hold Sneak
			
			ydisp += 30
			Gui, Main:Add, CheckBox,vToggleSound gCbSound x10 y%ydisp%,Sound
			
			ydisp += 30
			Gui, Main:Add, CheckBox,vPopMsg gCbPopUp x10 y%ydisp%,Confirm Kill/Suspend
			
			ydisp += 33
			Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h171, Features
			
			ydisp += 25
			Gui, Main:Add, Text,x10 y%ydisp% ,Resource Monitor
			zdisp :=ydisp-4
			Gui, Main:Add, Button, x170 y%zdisp% w50 gbtSuspend,Suspend
			
			ydisp += 30
			Gui, Main:Add, Text,x10 y%ydisp% ,Toggle AFK
			zdisp :=ydisp-4
			Gui, Main:Add, Button, x170 y%zdisp% w50 gbtAfk,On
			
			ydisp += 30
			Gui, Main:Add, Text,x10 y%ydisp% ,Contacts
			zdisp :=ydisp-4
			Gui, Main:Add, Button, x170 y%zdisp% w50 gContactsCheck,Detect
			
			ydisp += 30
			Gui, Main:Add, Text,x10 y%ydisp% ,UnStuck ?
			zdisp :=ydisp-4
			Gui, Main:Add, Button, x170 y%zdisp% w50 vbtKeyInfo hwndhbutton,Press
			tempf := Func("SolveInputs").bind(1)
			GuiControl, Main:+g, % hbutton, % tempf
			
			ydisp += 30
			Gui, Main:Add, Text,x10 y%ydisp% ,Quick Peek
			zdisp :=ydisp-4
			Gui, Main:Add, Button, x170 y%zdisp% w50 gbtHelp,Open
		
		Gui,Main:Tab, Misc
		
			ydisp := 20
			
			zdisp := ydisp + 5
			Gui, Main:Add, GroupBox, x5 y%zdisp% Section w220 h28
			
			ydisp += 15
			Gui, Main:Add, Text,x10 y%ydisp% ,Snippets

			;zdisp := ydisp-1
			;Gui, Main:Add, Button,x206 y%zdisp% h15 w15,X

			zdisp := ydisp+15
			Gui, Main:Add, GroupBox, x5 y%zdisp% Section w220 h312
			
			ydisp += 30
			Gui, Main:Add, Radio, vRadioSp1 gUpdateRadiotb3 x10 y%ydisp%, Chat
			Gui, Main:Add, Radio, vRadioSp2 gUpdateRadiotb3 x80 y%ydisp%, Phone
			
			Gui, Main:Add, Text, vLbText gLAltLabel border x200 y%ydisp% w20 cGray, Edit 

			ydisp+=20
			Gui, Main:Add, Text,x10 y%ydisp% w210 h250 hwndhFrameL 
			
			
			LbInit(LbMSelect)
			Gui, Lb:Show,x0 y0
			
			
			
			
			ydisp +=250
			Gui, Main:Add, Edit, vEditTb3 gTypeSnippet x10 y%ydisp% w155
			
			ydisp -=1
			Gui, Main:Add, Button,default  vbtSnippetText gbtSnippet x170 y%ydisp% w50 
			
			
			zdisp := ydisp+37
			Gui, Main:Add, GroupBox, x5 y%zdisp% Section w220 h28

			ydisp += 47
			Gui, Main:Add, Text,x10 y%ydisp% ,Hacks
			
			zdisp := ydisp+15
			Gui, Main:Add, GroupBox, x5 y%zdisp% Section w220 h38

			ydisp += 30
			Gui, Main:Add, Checkbox,vToggleHacks gCbHacks x10 y%ydisp%, Auto

			zdisp := ydisp-5
			
			xdisp := 55
			Gui, Main:Add, DropDownList, AltSubmit vdblSelected gdblfunc x%xdisp%  y%zdisp% w110, % dblpipeline
			xdisp += 115

			zdisp := ydisp-6
			Gui, Main:Add, Button, x%xdisp% y%zdisp% w50 gbtHacks,Unlock
			
		
		
		Gui,Main:Tab, Other
		
		;////////////////////////////////////////////////////////////////////////////////////////////
		;tab4
			
			
			
			ydisp :=30
			Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h80,Menu
			
			ydisp+=20
			Gui, Main:Add, CheckBox,x10 y%ydisp% vtb4ch1 gWindowDrag, Draggable
			
			ydisp+=25
			Gui, Main:Add, CheckBox,    x10 y%ydisp% vtb4ch2 gWindowOpacity, Transparent
			
			zdisp:=ydisp-3
			xdisp:=81
			Gui, Main:Add, Slider,  x%xdisp% y%zdisp% hwndSlider vtb4slider1 AltSubmit Range0-50 w100, 0
			xdisp:=181
			Gui, Main:Add, Edit,    x%xdisp% y%zdisp% hwndEdit vtb4edit1 number Limit3 w40 , 0
			Gui, Main:Add, UpDown, Range0-50 , 0

			tempf := Func("SliderEdit").bind("Main","tb4slider1","tb4edit1",0,"WindowOpacity") 
			GuiControl, Main:+g, % Slider, % tempf 

			tempf := Func("SliderEdit").bind("Main","tb4slider1","tb4edit1",1,"WindowOpacity") 
			GuiControl, Main:+g, % Edit, % tempf 

			;////////////////////////////////////////////////////////////////////////////////////////////
			;phone
			
			ydisp+=44
			Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h123,Variables
			
			ydisp+=20
			zdisp:=ydisp
			
			ydisp+=15
			
			;////////////////////////////////////////////////////////////////////////////////////////////
			;weapons
			
			Gui, Main:Add, Text,    x119 y%zdisp%, Weapon Bind
			
			creategrid("Main",119,ydisp,106,4,widg:=3,21,42,60)
			weapon := ["3:Pistol","4:Smg","5:Riffle","6:Sniper","1:NoWeapon","7:Shotgun","8:Heavy","9:Special"]
			
			inum := 106
			menu["Extrabutton4"] := new Manage("Main",inum++,widg,"Key G8",{"variable":"Extrabutton4","default":Extrabutton4,"save":"Weapon"},weapon)
			menu["Extrabutton3"] := new Manage("Main",inum++,widg,"Key G7",{"variable":"Extrabutton3","default":Extrabutton3,"save":"Weapon"},weapon)
			menu["Extrabutton2"] := new Manage("Main",inum++,widg,"Key G5",{"variable":"Extrabutton2","default":Extrabutton2,"save":"Weapon"},weapon)
			menu["Extrabutton1"] := new Manage("Main",inum++,widg,"Key G4",{"variable":"Extrabutton1","default":Extrabutton1,"save":"Weapon"},weapon)

			;////////////////////////////////////////////////////////////////////////////////////////////
			;network
			
			
			Gui, Main:Add, Text, x10 y%zdisp%, Internet Connection
			
			creategrid("Main",10,ydisp,110,1,3,21,42,60)
			
			menu["network"] := new Manage("Main",110,3,"Network",{"function":"private_network","default":NetworkAdapter},AdapterRadioArr)
			
			;////////////////////////////////////////////////////////////////////////////////////////////
			;Snacks
			
			ydisp+=25
			Gui, Main:Add, Text, x10 y%ydisp%, Snacks
			
			ydisp+=15
			creategrid("Main",10,ydisp,111,1,3,21,42,60)
			
			menu["snack"] := new Manage("Main",111,3,"Eat",{"function":"private_snack"},["P's & Q's","EgoChaser","Meteorite","eCola"])
			menu["snack"].set(SelectedSnacks)
			
			;////////////////////////////////////////////////////////////////////////////////////////////
			;debug
			
			inum:=1
			widg:=3
			
			debug["recent"] := new Manage("pin1",0,1,"","")
			debug["incar"] := new Manage("pin2",inum++,widg,"Scroll",{"default":1,"function":"private_incar"},["0:Off","1:On"])
			debug["hotkey"] := new Manage("pin2",inum++,widg,"Hotkey ",{"default":1,"function":"private_hotkey"},["0:Off","1:On"])
			debug["menu"] := new Manage("pin2",inum++,widg,"Menu",{"default":1,"function":"private_menu"},["None","chatbox","home","discord","Esc","IntMenu","Phone"])
			debug["fov"] := new Manage("pin2",inum++,widg,"FOV",{"default":2,"function":"private_fov"},["FPV","TPV 1","TPV 2","TPV 3"])
			debug["weapon"] := new Manage("pin2",inum++,widg,"Weapon",{"variable":"CurrentWeapon","default":CurrentWeapon},weapon)
			debug["role"] := new Manage("pin2",inum++,widg,"Role",{"default":1,"function":"private_role"},["1:nul","5:mbr","7:ceo","8:mcp"])
			
			ydisp+=1
			DebugStyler(ydisp)
			
		Gui,Main:Tab, Sys
			ydisp:=0
			HvIntGui(ydisp)
			
			ydisp+=7
			MixerGui(ydisp)
		
		Gui, Main:Add, StatusBar,vStatusbar h10 y%ydisp%,loaded
		

		AllRead()
		AllLoad()
		rpMain()
		
		
		tbload()
		dbload()
		SpRead()
		SpLoad()
		UpdateRadiotb3()
		
		CbRead()
		CbLoad()
		
		
		
		
		
		this.SizeTab()
		
		
		
		
	}
	
	SizeTab()
	{
		global
		
		GuiControlGet, value, Main:, TabSelected
		TabSelected := value
		
		Switch TabSelected
		{
			case 1:
			{
				ShowMainGui(442)
			}
			case 2:
			{
				this.Chs()
			}
			case 3:
			{
				ShowMainGui(472)
			}
			case 4:
			{
				ShowMainGui(tb4height)
			}
			case 5:
			{
				ShowMainGui(665)
			}
		}
		
		SpecificTimer(TabSelected)
		ToggleSG(TabSelected)
		
	}
	
	Chs()
	{
		global
		static doOnce := true
		
		if doOnce
		{
			this.reShape()
			doOnce := false
		}
		else
		{
			ShowMainGui(tb2height)
		}
	}
	
	;////////////////////////////////////////////////////////
	
	
	reShape(Selector=1)
	{
		global
		
		ydisp := 75+20
		
		if SectionStat1
		{
			GuiControl, Main:Text, boxSection1, X
			
			;this.HideSection1()
			
			this.MoveSection1(ydisp)
		}
		else
		{
			GuiControl, Main:Text, boxSection1, -
			this.HideSection1()
		}
		
		if (Selector=1)
			this.HideTitle2()
		
		
		this.MoveTitle2(ydisp)
		
		if SectionStat2
		{
			GuiControl, Main:Text, boxSection2, X
			
			if (Selector!=3)
				this.HideSection2()
				
			this.MoveSection2(ydisp)
		}
		else
		{
			GuiControl, Main:Text, boxSection2, -
			this.HideSection2()
		}
		
		if (Selector!=3)
			this.HideTitle3()
			
		this.MoveTitle3(ydisp)
		
		if SectionStat3
		{
			GuiControl, Main:Text, boxSection3, X
			
			this.HideSection3()
			this.MoveSection3(ydisp)
		}
		else
		{
			GuiControl, Main:Text, boxSection3, -
			this.HideSection3()
		}
		
		this.HideOther()
		this.MoveOther(ydisp)
		
		ydisp+=21
		
		this.Show()
		
		ShowMainGui(ydisp)
		tb2height := ydisp
	}
	
	
	Show()
	{
		global

		if SectionStat1
		{
			this.ShowSection1()
		}
		
		this.ShowTitle2()
		
		if SectionStat2
		{
			this.ShowSection2()
		}
		
		this.ShowTitle3()
		
		if SectionStat3
		{
			this.ShowSection3()
		}
		
		this.ShowOther()
	}
	
	
	MoveTitle2(byref ydisp)
	{
		zdisp := ydisp+50
		GuiControl, Main:Move,boxhead2, y%zdisp%

		ydisp += 60
		GuiControl, Main:Move,Chbox4, y%ydisp%

		zdisp := ydisp-1
		GuiControl, Main:Move,boxSection2, y%zdisp%
	}
	
	MoveTitle3(byref ydisp)
	{
		zdisp := ydisp+50
		GuiControl, Main:Move,boxhead3, y%zdisp%

		ydisp += 60
		GuiControl, Main:Move,Chbox5, y%ydisp%

		zdisp := ydisp-1
		GuiControl, Main:Move,boxSection3, y%zdisp%
	}
	
	MoveSection1(byref ydisp)
	{

		;////////////////////////////////////////////////////////
		
		zdisp := ydisp+15
		GuiControl, Main:Move,boxbody1, y%zdisp% w220 h170
		
		;////////////////////////////////////////////////////////
		
		ydisp += 30
		GuiControl, Main:Move,Textlabel1, y%ydisp%
		GuiControl, Main:Move,SliderStat1, y%ydisp%
		GuiControl, Main:Move,EditText1, y%ydisp%
		GuiControl, Main:Move,EditUd1,y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel2, y%ydisp% 
		GuiControl, Main:Move,SliderStat2, y%ydisp% 
		GuiControl, Main:Move,EditText2, y%ydisp%
		GuiControl, Main:Move,EditUd2,y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel3, y%ydisp%
		GuiControl, Main:Move,SliderStat3, y%ydisp% 
		GuiControl, Main:Move,EditText3, y%ydisp%
		GuiControl, Main:Move,EditUd3,y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel4, y%ydisp%
		GuiControl, Main:Move,SliderStat4, y%ydisp% 
		GuiControl, Main:Move,EditText4, y%ydisp%
		GuiControl, Main:Move,EditUd4,y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel5, y%ydisp%
		GuiControl, Main:Move,SliderColor1, y%ydisp%
		GuiControl, Main:Move,ProgressColor1, y%ydisp%
	}
	
	MoveSection2(byref ydisp)
	{
		;////////////////////////////////////////////////////////
		
		zdisp := ydisp+15
		GuiControl, Main:Move,boxbody2, y%zdisp% w220 h142

		;////////////////////////////////////////////////////////

		ydisp += 30
		GuiControl, Main:Move,Radio1, y%ydisp%
		GuiControl, Main:Move,Radio2, y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel6, y%ydisp% 
		GuiControl, Main:Move,SliderStat5, y%ydisp%
		GuiControl, Main:Move,EditText5, y%ydisp%
		GuiControl, Main:Move,EditUd5,y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel7, y%ydisp%
		GuiControl, Main:Move,SliderStat6, y%ydisp%
		GuiControl, Main:Move,EditText6, y%ydisp%
		GuiControl, Main:Move,EditUd6,y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel8, y%ydisp% 
		GuiControl, Main:Move,SliderColor2, y%ydisp%
		GuiControl, Main:Move,ProgressColor2, y%ydisp%
	}
	
	MoveSection3(byref ydisp)
	{
		;////////////////////////////////////////////////////////
		
		zdisp := ydisp+15
		GuiControl, Main:Move,boxbody3, y%zdisp% w220 h112

		;////////////////////////////////////////////////////////
		
		
		ydisp += 30
		GuiControl, Main:Move,Textlabel9, y%ydisp%
		GuiControl, Main:Move,SliderStat7, y%ydisp%
		GuiControl, Main:Move,EditText7, y%ydisp%
		GuiControl, Main:Move,EditUd7, y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel10,  y%ydisp% 
		GuiControl, Main:Move,SliderStat8, y%ydisp% 
		GuiControl, Main:Move,EditText8, y%ydisp%
		GuiControl, Main:Move,EditUd8,y%ydisp%


		ydisp += 30
		GuiControl, Main:Move,Textlabel11, y%ydisp%
		GuiControl, Main:Move,SliderColor3, y%ydisp%
		GuiControl, Main:Move,ProgressColor3, y%ydisp%
	
	}
	
	MoveOther(byref ydisp)
	{
		ydisp += 50
		GuiControl, Main:Move,EditText9, y%ydisp%
		GuiControl, Main:Move,ChxAxis,y%ydisp%
		GuiControl, Main:Move,EditText10, y%ydisp%
		GuiControl, Main:Move,ChyAxis,y%ydisp%

		GuiControl, Main:Move,btCh  , y%ydisp%
		
		ydisp += 4
		GuiControl, Main:Move,Textlabel12, y%ydisp%
		GuiControl, Main:Move,Textlabel13, y%ydisp%
		
		;////////////////////////////////////////////////////////

		ydisp += 30
		GuiControl, Main:Move,CbV1, y%ydisp%

		ydisp -=1
		GuiControl, Main:Move,btSave, y%ydisp%
		GuiControl, Main:Move,btLoad, y%ydisp%
		GuiControl, Main:Move,btDelete, y%ydisp%

		ydisp += 30
		GuiControl, Main:Move,Statusbar, h10 y%ydisp%
	}
	
	
	;////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	ShowTitle2()
	{
		GuiControl,Main:Show,boxhead2
		GuiControl,Main:Show,Chbox4
		GuiControl,Main:Show,boxSection2
	}
	
	ShowTitle3()
	{
		GuiControl,Main:Show,boxhead3
		GuiControl,Main:Show,Chbox5
		GuiControl,Main:Show,boxSection3
	}
	
	ShowSection1()
	{

		;////////////////////////////////////////////////////////
		
		GuiControl,Main:Show,boxbody1

		;////////////////////////////////////////////////////////
		
		GuiControl,Main:Show,Textlabel1
		GuiControl,Main:Show,SliderStat1
		GuiControl,Main:Show,EditText1
		GuiControl,Main:Show,EditUd1

		GuiControl,Main:Show,Textlabel2
		GuiControl,Main:Show,SliderStat2
		GuiControl,Main:Show,EditText2
		GuiControl,Main:Show,EditUd2

		GuiControl,Main:Show,Textlabel3
		GuiControl,Main:Show,SliderStat3
		GuiControl,Main:Show,EditText3
		GuiControl,Main:Show,EditUd3

		GuiControl,Main:Show,Textlabel4
		GuiControl,Main:Show,SliderStat4
		GuiControl,Main:Show,EditText4
		GuiControl,Main:Show,EditUd4

		GuiControl,Main:Show,Textlabel5
		GuiControl,Main:Show,SliderColor1
		GuiControl,Main:Show,ProgressColor1
	}
	
	ShowSection2()
	{
		;////////////////////////////////////////////////////////

		GuiControl,Main:Show,boxbody2

		;////////////////////////////////////////////////////////

		GuiControl,Main:Show,Radio1
		GuiControl,Main:Show,Radio2

		GuiControl,Main:Show,Textlabel6
		GuiControl,Main:Show,SliderStat5
		GuiControl,Main:Show,EditText5
		GuiControl,Main:Show,EditUd5

		GuiControl,Main:Show,Textlabel7
		GuiControl,Main:Show,SliderStat6
		GuiControl,Main:Show,EditText6
		GuiControl,Main:Show,EditUd6

		GuiControl,Main:Show,Textlabel8
		GuiControl,Main:Show,SliderColor2
		GuiControl,Main:Show,ProgressColor2
	}
	
	ShowSection3()
	{
		;////////////////////////////////////////////////////////

		GuiControl,Main:Show,boxbody3

		;////////////////////////////////////////////////////////

		GuiControl,Main:Show,Textlabel9
		GuiControl,Main:Show,SliderStat7
		GuiControl,Main:Show,EditText7
		GuiControl,Main:Show,EditUd7

		GuiControl,Main:Show,Textlabel10
		GuiControl,Main:Show,SliderStat8
		GuiControl,Main:Show,EditText8
		GuiControl,Main:Show,EditUd8

		GuiControl,Main:Show,Textlabel11
		GuiControl,Main:Show,SliderColor3
		GuiControl,Main:Show,ProgressColor3
	}
	
	ShowOther()
	{
		GuiControl,Main:Show,EditText9
		GuiControl,Main:Show,ChxAxis
		GuiControl,Main:Show,EditText10
		GuiControl,Main:Show,ChyAxis
		
		GuiControl,Main:Show,btCh
		GuiControl,Main:Show,Textlabel12
		GuiControl,Main:Show,Textlabel13

		;////////////////////////////////////////////////////////

		GuiControl,Main:Show,CbV1

		GuiControl,Main:Show,btSave
		GuiControl,Main:Show,btLoad
		GuiControl,Main:Show,btDelete

		GuiControl,Main:Show,StatusBar
	}
	
	
	HideTitle2()
	{
		GuiControl,Main:Hide,boxhead2
		GuiControl,Main:Hide,Chbox4
		GuiControl,Main:Hide,boxSection2
	}
	
	HideTitle3()
	{
		GuiControl,Main:Hide,boxhead3
		GuiControl,Main:Hide,Chbox5
		GuiControl,Main:Hide,boxSection3
	}
	
	HideSection1()
	{
		;////////////////////////////////////////////////////////

		GuiControl,Main:Hide,boxbody1

		;////////////////////////////////////////////////////////

		GuiControl,Main:Hide,Textlabel1
		GuiControl,Main:Hide,SliderStat1
		GuiControl,Main:Hide,EditText1
		GuiControl,Main:Hide,EditUd1

		GuiControl,Main:Hide,Textlabel2
		GuiControl,Main:Hide,SliderStat2
		GuiControl,Main:Hide,EditText2
		GuiControl,Main:Hide,EditUd2

		GuiControl,Main:Hide,Textlabel3
		GuiControl,Main:Hide,SliderStat3
		GuiControl,Main:Hide,EditText3
		GuiControl,Main:Hide,EditUd3

		GuiControl,Main:Hide,Textlabel4
		GuiControl,Main:Hide,SliderStat4
		GuiControl,Main:Hide,EditText4
		GuiControl,Main:Hide,EditUd4

		GuiControl,Main:Hide,Textlabel5
		GuiControl,Main:Hide,SliderColor1
		GuiControl,Main:Hide,ProgressColor1
	}
	
	
	HideSection2()
	{
		;////////////////////////////////////////////////////////

		GuiControl,Main:Hide,boxbody2

		;////////////////////////////////////////////////////////

		GuiControl,Main:Hide,Radio1
		GuiControl,Main:Hide,Radio2

		GuiControl,Main:Hide,Textlabel6
		GuiControl,Main:Hide,SliderStat5
		GuiControl,Main:Hide,EditText5
		GuiControl,Main:Hide,EditUd5

		GuiControl,Main:Hide,Textlabel7
		GuiControl,Main:Hide,SliderStat6
		GuiControl,Main:Hide,EditText6
		GuiControl,Main:Hide,EditUd6

		GuiControl,Main:Hide,Textlabel8
		GuiControl,Main:Hide,SliderColor2
		GuiControl,Main:Hide,ProgressColor2
	}
	
	HideSection3()
	{
	
		;////////////////////////////////////////////////////////

		GuiControl,Main:Hide,boxbody3

		;////////////////////////////////////////////////////////
		
		GuiControl,Main:Hide,Textlabel9
		GuiControl,Main:Hide,SliderStat7
		GuiControl,Main:Hide,EditText7
		GuiControl,Main:Hide,EditUd7

		GuiControl,Main:Hide,Textlabel10
		GuiControl,Main:Hide,SliderStat8
		GuiControl,Main:Hide,EditText8
		GuiControl,Main:Hide,EditUd8

		GuiControl,Main:Hide,Textlabel11
		GuiControl,Main:Hide,SliderColor3
		GuiControl,Main:Hide,ProgressColor3
	}
	
	HideOther()
	{
	
		;////////////////////////////////////////////////////////

		GuiControl,Main:Hide,EditText9
		GuiControl,Main:Hide,ChxAxis

		GuiControl,Main:Hide,EditText10
		GuiControl,Main:Hide,ChyAxis
		
		GuiControl,Main:Hide,btCh
		GuiControl,Main:Hide,Textlabel12
		GuiControl,Main:Hide,Textlabel13

		;////////////////////////////////////////////////////////

		GuiControl,Main:Hide,CbV1
		GuiControl,Main:Hide,btSave
		GuiControl,Main:Hide,btLoad
		GuiControl,Main:Hide,btDelete
		GuiControl,Main:Hide,StatusBar
	
	}
	
}

ShowMainGui(ydisp="")
{
	global gui_position,ShowCh
	static OnlyOnce := true
	static height
	
	if ydisp
		height := ydisp
	
	if !ShowCh
		return

	if !OnlyOnce
	{
		Gui, Main:Show, h%height%
	}
	else if height
	{
		Gui, Main:Show, %gui_position% w230 h%height%
		OnlyOnce := false
	}
}

HideMainGui()
{
	wpMain()
	Gui, Main:Hide
}

wpMain()
{
	global MainGui,gui_position,gSavePath
	WinGetPos, gui_x, gui_y,,, ahk_id %MainGui%
	if (gui_x > 0 && gui_x < 1366 && gui_y > 0 && gui_y < 800)
	{
		gui_position = x%gui_x% y%gui_y%
		
	}
	else
	{
		if ShowCh
		{
			gui_position = x933 y17
		}
	}
	
	writeinit(gSavePath,"window position","gui_position")
}

rpMain()
{
	global gui_position,gSavePath
	readinit(gSavePath,"window position","gui_position")
	data := Invformat(gui_position,"x{} y{}")
	gui_x := data[1]
	gui_y := data[2]
	
	if (gui_x > 0 && gui_x < 1366 && gui_y > 0 && gui_y < 800)
	{
		gui_position = x%gui_x% y%gui_y%
	}
	else
	{
		gui_position = x933 y17
	}
	
}

Invformat(haystack,patterns)
{
	pattern := StrSplit(RegExReplace(patterns, "`am)\{([^{}]|(?R))*\}", "|"),"|")
	matches := [], index := 1
	While(index < pattern.count())
	{
		pos1 := InStr(haystack,pattern[index])+strlen(pattern[index])
		pos2 := !trim(pattern[index+1]) ? strlen(haystack)+1-StrLen(pattern[index+1]) : InStr(haystack,pattern[index+1])
		matches.push(SubStr(haystack,pos1,abs(pos2-pos1)))
		index++
	}
	return matches
}

;//////////////////////////////////////////////////////////////////


cbDelete:
GuiControlGet, value, Main:, CbV1
CbV1 := value
trimspace(CbV1)
If check(cbArr,CbV1) && CbV1
{
	cbremove(cbArr,CbV1)
	cbStr := cbjoin(cbArr,0)
	writeinit(gSavePath,"default","cbStr")
	guiControl , Main:,CbV1,|%cbStr%
	
	LoadedSection := CbV1
	deleteinit(gSavePath,LoadedSection)
	LoadedSection = 
	
	SB_SetText("deleted " . CbV1)
}
return



cbLoad:
GuiControlGet, value, Main:, CbV1
CbV1 := value
trimspace(CbV1)
if CbV1
{
	If check(cbArr,CbV1)
	{
		cbStr := cbjoin(cbArr,CbV1)
		writeinit(gSavePath,"default","cbStr")
		guiControl , Main:,CbV1,|%cbStr%
		
		LoadedSection := CbV1
		
		AllRead()
		AllLoad()
		UpdateCrosshair()
		
		SB_SetText("load ini " . CbV1 )
		;tooltip, load ini %cbStr%
	}
	else
	{
		Newdefault()

		AllLoad()
		
		SB_SetText("load new " . CbV1 )
	}
	
}
return



cbSave:
GuiControlGet, value, Main:, CbV1
CbV1 := value
trimspace(CbV1)
if CbV1
{
	If !check(cbArr,CbV1)
	{
			cbArr.push(CbV1)
			
			cbStr := cbjoin(cbArr,CbV1)
			writeinit(gSavePath,"default","cbStr")
			
			guiControl , Main:,CbV1,|%cbStr%

			LoadedSection := CbV1
			AllWrite()
			
			SB_SetText("save new " . CbV1)
			;tooltip, save new %CbV1%

	}
	else
	{
		cbStr := cbjoin(cbArr,CbV1)
		writeinit(gSavePath,"default","cbStr")
		
		LoadedSection := CbV1
		AllWrite()
		
		SB_SetText("save old " . CbV1)
		;tooltip, save ini %CbV1%
	}
}
return







Cbfunc(head,uid,var,ptr)
{
	global
	
	GuiControlGet, value, %uid%:, %var%
	arr := %ptr%
	
	%var% := Trim(value)
	
	If (%var% == "")
	{
		str := cbjoin(arr,0)
		Control HideDropDown,,, ahk_id %head%
		guiControl , %uid%:,%var%,|%str%
		return
	}
	If (GetKeyState("Up","P") || GetKeyState("Down","P"))
		return

	GuiControlGet, Output,%uid%:, %head%
	
	Control HideDropDown,,, ahk_id %head%
	
	matchArr := []
	Loop % arr.Count()
	{
		elem := arr[A_index]
		tr := cbmatch(%var%,elem)
		if (tr=2 || tr=3)
			matchArr.push(elem)
	}
	
	If (GetKeyState("Delete","P") || GetKeyState("Backspace","P"))
	{
		str := cbjoin(matchArr,0)
		guiControl , %uid%:,%var%,|%str%
		if (matchArr.Count()=0)
			Control HideDropDown,,, ahk_id %head%
		else
			Control ShowDropDown,,, ahk_id %head%
		GuiControl, %uid%:Text, %var%, %Output%
		Sendinput, ^{End}
		;ControlSend, ,^{End}, ahk_id %head% 
		return
	}
	
	
	if (matchArr.Count()=0)
	{
		str := cbjoin(arr,0)
		guiControl , %uid%:,%var%,|%str%
		GuiControl, %uid%:Text, %var%, %Output%
		Sendinput, ^{End}
		;ControlSend, ,^{End}, ahk_id %head% 

	}
	else
	{
		str := cbjoin(matchArr,0)
		guiControl , %uid%:,%var%,|%str%
		Control ShowDropDown,,, ahk_id %head%
		GuiControl, %uid%:Text, %var%, %Output%
		AutoComplete(head,%var%)
	}
}



CbEnter(head)
{
	Control HideDropDown,,, ahk_id %head%
	Sendinput, ^{End}
	;ControlSend, ,^{End}, ahk_id %hCbx1% 
}

;https://autohotkey.com/board/topic/19165-smart-comboboxes/

AutoComplete(h,needle)
{
	static lf = "`n" 
	SetControlDelay, -1 
	SetWinDelay, -1 
	ControlGet, haystack, List, , , ahk_id %h% 
	StringMid, text, haystack, pos := InStr(lf . haystack, lf . needle) 
	  , InStr(haystack . lf, lf, false, pos) - pos 
	If text !=
	{
	    if pos != 0
	    {
			ControlSetText, , %text%, ahk_id %h% 
			Sendinput, % "{Right " . StrLen(needle) . "}+^{End}"
			;ControlSend, , % "{Right " . StrLen(needle) . "}+^{End}", ahk_id %h% 
		}
	}
}

cbmatch(item,Str)
{
	StrSize := Strlen(Str)
	itemSize := Strlen(item)
	needle := InStr(str, item)
	
	if (needle=1)
	{
		if (itemSize=StrSize)
			return 2
		else
			return 3
	}
	
	needle := InStr(item,str)
	if (needle=1)
	{
		return 1
	}
	
	return 0
}






cbparse(str,byref elem,byref unique=0)
{
	letters := StrSplit(str) 
	size := strlen(str)

	putdata := false
	Arr := []
	
	
	
	Loop % size
	{
		if letters[A_index] != "|"
			conc .= letters[A_index]
		else 
		{
			putdata := true
			if letters[A_index-1]=="|"
				unique := Arr.Count()
		}
		
		if (A_index = size)
			putdata := true
			
		if putdata
		{
			if conc
				Arr.push(Trim(conc))
			putdata := false
			conc := ""
		}
	}
	
	elem := Arr[unique]

	return Arr
}


cbjoin(Arr,elem=0)
{
	unique := 0
	if elem
		unique := cbindex(Arr,elem)
	
	str := ""
	size := Arr.Count()
	Loop % size
	{

		if A_index = %unique%
			split := "||"
		else if A_index != %size%
			split := "|"
		else
			split := ""
		
		str .= Arr[A_index] . split
	}
	return str
}

cbremove(Arr,elem)
{
	Arr.remove(cbindex(Arr,elem))
}

trimspace(byref string)
{
	string := Trim(string)
}


cbindex(obj, item)
{
	for i, val in obj
	{
		if (val == item)
			return i
	}
	;return 0
}


;//////////////////////////////////////////////////////////////////

UpdateSection(widget,index)
{
	global
	SectionStat%index% := !SectionStat%index%
	;msgbox % SectionStat%index%
	Obj.reShape(index)
}

UpdateCheckbox(widget,index)
{
	global
	guiControlGet,value, Main:, % widget
	Chbox%index% := value
	;tooltip % value "   " index
	UpdateCrosshair(format("Chbox{}",index))
}

UpdateEdit(widget,index)
{
	global
	GuiControlGet, value, Main:, % widget
	GuiControl, Main:, EditText%index%, %value%
	;tooltip % value
	UpdateCrosshair(format("EditText{}",index))
}

UpdateSlider(widget,index)
{
	global
	GuiControlGet, value, Main:, % widget
	if limitentry("Main",0,100,value,widget)
		return
	GuiControl, Main:, SliderStat%index%, %value%
	SliderStat%index% := value
	;tooltip % value
	UpdateCrosshair(format("SliderStat{}",index))
}

UpdatepColor(widget,index)
{
	global
	GuiControlGet, value, Main:, % widget
	SliderColor%index% := value
	color := getwidgetcolor(value)
	GuiControl, Main:+c%color% , ProgressColor%index%
	;tooltip % value
	ProgressColor%index% := color
	UpdateCrosshair(format("ProgressColor{}",index))
}

UpdateAxis(widget,Name)
{
	global
	guiControlGet,value, Main:, % widget
	
	if (Name="ChxAxis")
		limitvalue := 1366
	else
		limitvalue := 766
		
	if limitentry("Main",0,limitvalue,value,widget)
		return
	
	%Name% := value
	
	;tooltip % value
	UpdateCrosshair(Name)
}

UpdateRadio()
{
	global
	Loop % 2
	{
		GuiControlGet, value, Main:, Radio%A_index%
		if (value=1)
			RadioIndex := A_index
	}
	;tooltip % RadioIndex
	UpdateCrosshair("RadioIndex")
}



;//////////////////////////////////////////////////////////////////

SliderEdit(Id,Slider,Edit,State,Name="",Size=100)
{
	global
	
	if State
	{
		GuiControlGet, value, %Id%:, % Edit
		if limitentry(Id,0,Size,value,Edit)
			return
		GuiControl, %Id%:, %Slider%, %value%
	}
	else
	{
		GuiControlGet, value, %Id%:, % Slider
		SupUnSup(1)
		GuiControl, %Id%:, %Edit%, %value%
		SupUnSup(0)
	}
	%Slider% := value
	%Edit% := value
	if Name
		Func(Name).bind(value).Call()
}

limitentry(id,minima,maxima,value,vname)
{

	if (value > maxima)
	{
		value := SubStr(value,1,-1*(Log(value/10)))
		
		GuiControl, %id%:, %vname% , %value%
		ControlSend, ,^{End}, ahk_id %vname% 
		return 1
	}
	else if (value ="" || value < minima)
	{
		GuiControl, %id%:, %vname% , %minima%
		ControlSend, ,^{End}, ahk_id %vname% 
		return 1
	}
	return 0
}

;//////////////////////////////////////////////////////////////////

Newdefault()
{
	global
	#includeAgain %A_WorkingDir%\temp\lib\gdefault.ahk
}

AllLoad()
{
	global Obj
	
	LoadChbox()
	LoadSlider()
	LoadColor()
	LoadChAxis()
	LoadRadio()
	Obj.reShape()
}

AllRead()
{
	global
	
	if LoadedSection
	{
		readinit(gSavePath,LoadedSection,"Chbox1")
		readinit(gSavePath,LoadedSection,"Chbox2")
		
		
		readinit(gSavePath,LoadedSection,"SectionStr")
		SectionArr := StrSplit(SectionStr,"|")
		SectionStat1 := SectionArr[1]
		SectionStat2 := SectionArr[2]
		SectionStat3 := SectionArr[3]
		
		
		readinit(gSavePath,LoadedSection,"Chbox3")
		readinit(gSavePath,LoadedSection,"SliderStat1")
		readinit(gSavePath,LoadedSection,"SliderStat2")
		readinit(gSavePath,LoadedSection,"SliderStat3")
		readinit(gSavePath,LoadedSection,"SliderStat4")
		readinit(gSavePath,LoadedSection,"SliderColor1")
		
		readinit(gSavePath,LoadedSection,"Chbox4")
		readinit(gSavePath,LoadedSection,"RadioIndex")
		readinit(gSavePath,LoadedSection,"SliderStat5")
		readinit(gSavePath,LoadedSection,"SliderStat6")
		readinit(gSavePath,LoadedSection,"SliderColor2")
		
		readinit(gSavePath,LoadedSection,"Chbox5")
		readinit(gSavePath,LoadedSection,"SliderStat7")
		readinit(gSavePath,LoadedSection,"SliderStat8")
		readinit(gSavePath,LoadedSection,"SliderColor3")
		
		readinit(gSavePath,LoadedSection,"ChxAxis")
		readinit(gSavePath,LoadedSection,"ChyAxis")
	}
}



AllWrite()
{
	global
	writeinit(gSavePath,LoadedSection,"Chbox1")
	writeinit(gSavePath,LoadedSection,"Chbox2")
	
	SectionStr := SectionStat1 . "|" . SectionStat2 . "|" . SectionStat3
	writeinit(gSavePath,LoadedSection,"SectionStr")
	
	writeinit(gSavePath,LoadedSection,"Chbox3")
	writeinit(gSavePath,LoadedSection,"SliderStat1")
	writeinit(gSavePath,LoadedSection,"SliderStat2")
	writeinit(gSavePath,LoadedSection,"SliderStat3")
	writeinit(gSavePath,LoadedSection,"SliderStat4")
	writeinit(gSavePath,LoadedSection,"SliderColor1")
	
	writeinit(gSavePath,LoadedSection,"Chbox4")
	writeinit(gSavePath,LoadedSection,"RadioIndex")
	writeinit(gSavePath,LoadedSection,"SliderStat5")
	writeinit(gSavePath,LoadedSection,"SliderStat6")
	writeinit(gSavePath,LoadedSection,"SliderColor2")
	
	writeinit(gSavePath,LoadedSection,"Chbox5")
	writeinit(gSavePath,LoadedSection,"SliderStat7")
	writeinit(gSavePath,LoadedSection,"SliderStat8")
	writeinit(gSavePath,LoadedSection,"SliderColor3")
	
	writeinit(gSavePath,LoadedSection,"ChxAxis")
	writeinit(gSavePath,LoadedSection,"ChyAxis")
}


LoadChbox()
{
	global
	Loop % 5
	{
		value := Chbox%A_index%
		GuiControl,Main:, Chbox%A_index%, %value%
	}
}

LoadSlider()
{
	global
	Loop % 8
	{
		value := SliderStat%A_index%
		GuiControl,Main:, SliderStat%A_index%, %value%
		GuiControl,Main:, EditText%A_index%, %value%
	}
}

LoadColor()
{
	global
	Loop % 3
	{
		value := SliderColor%A_index%
		GuiControl,Main:, SliderColor%A_index%, %value%
		color := getwidgetcolor(value)
		GuiControl ,Main: +c%color% , ProgressColor%A_index%
		ProgressColor%A_index% := color
	}
}

LoadChAxis()
{
	global
	value := ChxAxis
	GuiControl,Main:, ChxAxis, %value%
	value := ChyAxis
	GuiControl,Main:, ChyAxis, %value%
}

LoadRadio()
{
	global RadioIndex
	GuiControl,Main:,Radio%RadioIndex%,1
}

;https://autohotkey.com/board/topic/60769-color-changing-slider/ 
;http://www.autohotkey.com/forum/viewtopic.php?t=57368&postdays=0&postorder=asc&start=0)



dec2hex(N) 
{
   SetFormat, Integer, Hex 
   N += 0 
   SetFormat, Integer, D 
   StringTrimLeft, N, N, 2 
   If(StrLen(N) < 2) 
      N = 0%N%
   Return N 
}

getwidgetcolor(aa)
{
	Max = 255
	a2=0
	a3=0

	n := Round(max/50,0)
	
	if aa between 1 and 50
	{
		ab := dec2hex(round((50-aa)*2*2.55))
		a1 := ab
		a2 := ab
		a3 := ab
	}
	else if aa between 51 and 100
	{
		a1 := dec2hex(max)
		ab := (aa-50)*n
		a2 := dec2hex(ab)
		a3 := dec2hex(0)
	}
	else if aa between 101 and 150
	{
		a2 := dec2hex(max)
		ab := (max-(aa-50))*n
		a1 := dec2hex(ab)
		a3 := dec2hex(0)
	}
	else if aa between 151 and 200
	{
		a2 := dec2hex(max)
		ab := ((aa-50)-100)*n
		a3 := dec2hex(ab)
		a1 := dec2hex(0)
	}
	else if aa between 201 and 250
	{
		a3 := dec2hex(max)
		ab := (max-((aa-50)-150))*n
		a2 := dec2hex(ab)
		a1 := dec2hex(0)
	}
	else if aa between 251 and 300
	{
		a3 := dec2hex(max)
		ab := ((aa-50)-200)*n
		a1 := dec2hex(ab)
		a2 := dec2hex(0)
	}
	else if aa between 301 and 350
	{
		a1 := dec2hex(max)
		ab := (max-((aa-50)-250))*n
		a3 := dec2hex(ab)
		a2 := dec2hex(0)
	}
	
	return format("{:06}",SubStr(a1 . a2 . a3,-5))
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



CbSound()
{
	global ToggleSound
	GuiControlGet, value, Main:, ToggleSound
	ToggleSound := value
}

CbPopUp()
{
	global PopMsg
	GuiControlGet, value, Main:, PopMsg
	PopMsg := value
}

CbHacks()
{
	global ToggleHacks
	GuiControlGet, value, Main:, ToggleHacks
	ToggleHacks := value
}







dblsave()
{
	global 
	writeinit(gSavePath,"Gui","dblSelected")
}

dbload()
{
	global
	readinit(gSavePath,"Gui","dblSelected")
	GuiControl , Main:Choose, dblSelected, % dblSelected

}

tbsave()
{
	global 
	writeinit(gSavePath,"Gui","TabSelected")
}

tbload()
{
	global
	readinit(gSavePath,"Gui","TabSelected")
	GuiControl , Main:Choose, TabSelected, % TabSelected

}


UpdateRadiotb3()
{
	global
	
	static LocalVar
	Loop % 2
	{
		GuiControlGet, value, Main:, RadioSp%A_index%
		if (value=1)
			RadioIndex2 := A_index
	}
	
	if (LocalVar=RadioIndex2)
		return
	
	GuiControl, Lb:+AltSubmit, LbStr%RadioIndex2%
	GuiControlGet, LocalIndex, Lb:, LbStr%RadioIndex2%
	GuiControl, Lb:-AltSubmit, LbStr%RadioIndex2%
	
	if !LocalIndex
		GuiControl, Lb:Choose, LbStr%RadioIndex2%, 1
	
	LbState()
	
	LocalVar := RadioIndex2
}

LbState()
{
	global
	if RadioIndex2=1
	{
		Gui, Lb:Font,, Courier New
		GuiControl, Lb:Font, LbStr1
		
		GuiControl,Lb:Hide,LbStr2
		GuiControl,Lb:Show,LbStr1
		GuiControl ,Main:,btSnippetText, Type
	}
	else
	{
		Gui, Lb:Font,, Courier New
		GuiControl, Lb:Font, LbStr2
		
		GuiControl,Lb:Hide,LbStr1
		GuiControl,Lb:Show,LbStr2
		
		GuiControl ,Main:,btSnippetText, Dial
	}
}

ListboxLoad(byref arr, widget, hwnd = "Main")
{
	pipetext := ""
	for i, item in arr
		pipetext .= "|" item
	if (pipetext)
		GuiControl,%hwnd%:,%widget%,%pipetext%
	else
		GuiControl,%hwnd%:,%widget%,|
}

;/////////////////////////////////////////////////////////////////////////////////

LbToggle(AtSelect)
{
	global
	
	color := (AtSelect) ? "Gray" : "Lime" 
	Gui, Main:Font, c%color%
	GuiControl, Main:Font, LbText
	
	GuiControl, Lb:+AltSubmit, LbStr1
	GuiControlGet, LocalIndex1, Lb:, LbStr1
	LocalIndex1 := RegExReplace(LocalIndex1, "\|.*$")
	GuiControl, Lb:-AltSubmit, LbStr1
	GuiControlGet, OutputId, Lb:Hwnd, LbStr1
	temp1 := GetScrollPos(OutputId,1)
	
	GuiControl, Lb:+AltSubmit, LbStr2
	GuiControlGet, LocalIndex2, Lb:, LbStr2
	LocalIndex2 := RegExReplace(LocalIndex2, "\|.*$")
	GuiControl, Lb:-AltSubmit, LbStr2
	GuiControlGet, OutputId, Lb:Hwnd, LbStr2
	temp2 := GetScrollPos(OutputId,1)
	
	LbInit(AtSelect)
	LbState()
	Gui, Lb:Show,x0 y0
	
	GuiControlGet, OutputId, Lb:Hwnd, LbStr1
	vSetScrollPos(OutputId,temp1)
	GuiControl, Lb:Choose, LbStr1, % LocalIndex1
	GuiControlGet, OutputId, Lb:Hwnd, LbStr2
	vSetScrollPos(OutputId,temp2)
	GuiControl, Lb:Choose, LbStr2, % LocalIndex2
	
	
}

LbInit(AtSelect)
{
	global
	
	destroy("hFrameL")
	localwindow(hFrameL,"Lb","-Caption")
	Multi := AtSelect ? "Multi":""
	
	Gui, Lb:Font,, Courier New
	GuiControl, Lb:Font, LbStr1
	
	Gui, Lb:Add, ListBox, %Multi% vLbStr1 hWndLbList x0 y0 w210 h250 +HScroll, 
	tempf := Func("Lbfunc").bind(1)
	GuiControl, Lb:+g, % LbList, % tempf
	
	Gui, Lb:Add, ListBox, vLbStr2 hWndLbList x0 y0 w210 h250 +HScroll
	tempf := Func("Lbfunc").bind(2)
	GuiControl, Lb:+g, % LbList, % tempf
	
	ListboxLoad(ArrayChatSnippets,"LbStr1","Lb")
	ListboxLoad(ArrayPhonebook,"LbStr2","Lb")
	
}

;/////////////////////////////////////////////////////////////////////////////////

SetGuiFocus(Uid,vName)
{
	GuiControlGet, hvar, %Uid%:Hwnd, % vName
	ControlFocus,, ahk_id %hvar%
}


GetGuiFocus(Hwnd,Uid)
{
	ControlGetFocus, rvar, ahk_id %Hwnd% 
	GuiControlGet, nvar, %Uid%:Name, % rvar
	return nvar
}

GetGuiSelected(Uid)
{
	MouseGetPos,,,,rvar
	GuiControlGet, nvar, %Uid%:Name, % rvar
	return nvar
}

IsTabSelected(Index)
{
	global TabSelected
	return (TabSelected == Index)
}

;/////////////////////////////////////////////////////////////////////////////////
;https://www.autohotkey.com/boards/viewtopic.php?style=1&p=454275

GetScrollPos(HCTL, Bar)
{
	VarSetCapacity(SI, 28, 0)  ; SCROLLINFO structure
	NumPut(28, SI, 0, "Int")   ; cbSize
	NumPut(4,  SI, 4, "Int")   ; fMask
	DllCall("GetScrollInfo", "Ptr", HCTL, "UInt", Bar, "Ptr", &SI, "UInt")
	ErrorLevel := A_LastError
	Return NumGet(SI, 20, "Int")
}

SetScrollPos(HCTL, Bar, Pos)
{
	VarSetCapacity(SI, 28, 0)  ; SCROLLINFO structure
	NumPut(28,  SI,  0, "Int") ; cbSize
	NumPut(4,   SI,  4, "Int") ; fMask
	NumPut(Pos, SI, 20, "Int") ; nPos
	Pos := DllCall("SetScrollInfo", "Ptr", HCTL, "UInt", Bar, "Ptr", &SI, "UInt", 1, "Int")
	ErrorLevel := A_LastError
	Return Pos
}

vSetScrollPos(hCtrl, Pos)
{
	static WM_VSCROLL := 0x115, SB_THUMBPOSITION := 4
	PostMessage, WM_VSCROLL, SB_THUMBPOSITION | Pos << 16,,, ahk_id %hCtrl%
}

;/////////////////////////////////////////////////////////////////////////////////

Lbfunc(index)
{
	global
	
	GuiControlGet, value, Lb:, LbStr%index%
	LbStr%index% := value
	
	if(A_GuiEvent = "DoubleClick")
		triggerSnippet()
}

TypeSnippet()
{
	global
	GuiControlGet, value, Main:, EditTb3
	EditTb3 := value
}

btSnippet()
{
	global
	
	GuiControlGet, value, Lb:, LbStr1
	LbStr1 := value
	GuiControlGet, value, Lb:, LbStr2
	LbStr2 := value
	
	if !Trim(EditTb3) && Strlen(EditTb3)
	{
		GuiControl,Main:, EditTb3,
		return
	}
	
	EditTb3 := Trim(EditTb3)
	if (!EditTb3 && (LbStr1 || LbStr2))
	{
		triggerSnippet()
	}
	else
	{
		insertSnippet()
		triggerEdit()
	}
}

insertSnippet()
{
	global
	if RadioIndex2=1
	{
		ArrayChatSnippets.Insert(EditTb3)
		ListboxLoad(ArrayChatSnippets,"LbStr1","Lb")
		GuiControl, Lb:Choose, LbStr1, % ArrayChatSnippets.Count()
		
	}
	else
	{
		
		Index := InStr(EditTb3," ")
		if Index
		{
			Number := SubStr(EditTb3,1,Index-1)
			Info := Trim(SubStr(EditTb3,Index,Strlen(EditTb3)-1))
			StringUpper, Info, Info, T
			EditTb3 := SubStr(Number "                ",1,14) "- " Info 
		}
		else
		{
			EditTb3 := SubStr(EditTb3 "                ",1,14) "- " "Unknown"
		}
		
		ArrayPhonebook.Insert(EditTb3)
		ListboxLoad(ArrayPhonebook,"LbStr2","Lb")
		GuiControl, Lb:Choose, LbStr2, % ArrayPhonebook.Count()
		
	}
	GuiControl,Main:, EditTb3,
}

triggerEdit()
{
	global
	if RadioIndex2=1
	{
		typeOutText(EditTb3,false)
	}
	else
	{
		DialpInterface(EditTb3)
	}
}

triggerSnippet()
{
	global
	
	if RadioIndex2=1
	{
		typeOutText(LbStr1,true)
	}
	else
	{
		DialpInterface(LbStr2)
	}
}

CbRead()
{
	global
	readinit(gSavePath,"Gui","ToggleHotkey")
	readinit(gSavePath,"Gui","ToggleSound")
	readinit(gSavePath,"Gui","PopMsg")
	readinit(gSavePath,"Gui","ToggleHacks")
	readinit(gSavePath,"Gui","HoldLCtrl")
}

CbWrite()
{
	global
	writeinit(gSavePath,"Gui","ToggleHotkey")
	writeinit(gSavePath,"Gui","ToggleSound")
	writeinit(gSavePath,"Gui","PopMsg")
	writeinit(gSavePath,"Gui","ToggleHacks")
	writeinit(gSavePath,"Gui","HoldLCtrl")
}

CbLoad()
{
	global
	GuiControl,Main:, ToggleHotkey, %ToggleHotkey%
	GuiControl,Main:, ToggleSound, %ToggleSound%
	GuiControl,Main:, PopMsg, %PopMsg%
	GuiControl,Main:, ToggleHacks, %ToggleHacks%
	GuiControl,Main:, HoldLCtrl, %HoldLCtrl%
}

CbHoldSneak()
{
	global 
	GuiControlGet, HoldLCtrl, Main:, HoldLCtrl
}

SpRead()
{
	global
	readinit(gSavePath,"Gui","RadioIndex2")
}

SpLoad()
{
	global
	GuiControl,Main:,RadioSp%RadioIndex2%,1
	
}

SpWrite()
{
	global
	writeinit(gSavePath,"Gui","RadioIndex2")
}


;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


StrStyle(Str,Case="T")
{
	if (Case == "L")
		StringLower, Str, Str
	else if (Case=="U")
		StringUpper, Str, Str
	else if (Case=="T")
		StringUpper, Str, Str , T
	return Str
}

SpamText(LocalStr)
{
	global InitLeftClick
	
	static h := 20
	static a := 2
	static b := 2.1
	
	ElapsedSeconds := (A_TickCount-InitLeftClick)/1000
	
	;logistic growth function https://courses.lumenlearning.com/ivytech-collegealgebra/chapter/use-logistic-growth-models/
	multiplier := ceil(h/(1+(h-1)*Exp(-b*ElapsedSeconds+a)))
	
	if (multiplier>1)
	{
		GuiControl ,Main:,btSnippetText, x%multiplier%
		sleep, 500
		GuiControl ,Main:,btSnippetText, Type
		return StrRep(LocalStr," ", multiplier)
	}
	else
	{
		return LocalStr
	}
}

StrRep(Str,Separator,Count)
{
	Loop % Count
	{
        Output .= Str
		if (A_index!=Count)
			Output .= Separator
    }
	return Output
}








