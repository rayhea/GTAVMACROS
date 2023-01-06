;////////////////////////////////////////////////////////////////////////////////////////////


SetOpacity(hndl,percent,redraw=0)
{
	value := 255-255*(percent/100)
	WinSet, Transparent, %value%, ahk_id %hndl%
	if (redraw)
		WinSet, ReDraw, , ahk_id %hndl%
}

;////////////////////////////////////////////////////////////////////////////////////////////

DebugStyler(ydisp)
{
	global
	if DeMoStyle
	{
		ydisp+=26
		zdisp:=ydisp+30
		Gui, Main:Add, GroupBox, x5 y%zdisp% Section w220 h30
		
		ydisp+=40
		Gui, Main:Add, CheckBox,x10 y%ydisp% vdebugcht hwndCheckbox,Debug Mode
		tempf := Func("debugmode").bind(1)
		GuiControl, Main:+g, % Checkbox, % tempf 
		
		ydisp+=20
		Gui, Main:Add, Text,x0 y%ydisp% w230 h298 hwndhFrameM
		
		tb4height := 591
		
		debugread()
		debugmode()
		debugdelay()
	}
	else
	{
		debugcht := 0
		
		ydisp+=56
		Gui, Main:Add, GroupBox, x5 y%ydisp% Section w220 h188, Internal
		
		ydisp+=20
		zdisp:=ydisp
		
		ydisp+=15
		
		Gui, Main:Add, Text, x10 y%zdisp%,Script
		creategrid("Main",10,ydisp,specialindex+1,3,3,21,42,60)
		
		
		ydisp+=70
		zdisp:=ydisp
		
		ydisp+=15
		
		Gui, Main:Add, Text,    x10 y%zdisp%,Player
		creategrid("Main",10,ydisp,specialindex+4,3,3,21,42,60)
		
		reloadgrid("Main")
		debugread()
		
		tb4height := 477
	}
}

;////////////////////////////////////////////////////////////////////////////////////////////

debugmode(mode=0)
{

	global
	if mode
		GuiControlGet,debugcht,Main:,debugcht
		
	SplashQueue.state := debugcht
	if debugcht
	{
		localwindow(hFrameM,"debugM","-Caption")
		;Gui, debugM:Color, 00FF00
		
		ydisp:=0

		Gui, debugM:Add, GroupBox, x5 y%ydisp% Section w220 h272
		
		ydisp+=15
		Gui, debugM:Add, CheckBox,x10 y%ydisp% vdebugch1 hwndCheckbox,update delay
		tempf := Func("debugdelay").bind(1)
		GuiControl, debugM:+g, % Checkbox, % tempf 
		
		ydisp+=25
		Gui, debugM:Add, CheckBox,x10 y%ydisp% vdebugchp gdebugopac,opac grid

		zdisp :=ydisp-4
		Gui, debugM:Add, Button, x170 y%zdisp% w50 gcleardebug,reset

		ydisp+=25
		Gui, debugM:Add, CheckBox,x10 y%ydisp% vdebugchj gdebugpopjoin,pop join

		ydisp+=25
		Gui, debugM:Add, CheckBox,x10 y%ydisp% vdebugch2 hwndCheckbox,pop recent
		tempf := Func("DebugCheckbox").bind("debugch2")
		GuiControl, debugM:+g, % Checkbox, % tempf

		ydisp+=15
		Gui, debugM:Add, Text,x10 y%ydisp% w103 h21 hwndhFrameA
		
		
		
		
		ydisp+=25
		Gui, debugM:Add, CheckBox,x10 y%ydisp% vdebugch3 hwndCheckbox,pop table
		tempf := Func("DebugCheckbox").bind("debugch3")
		GuiControl, debugM:+g, % Checkbox, % tempf

		ydisp+=15
		Gui, debugM:Add, Text,x10 y%ydisp% w103 h121 hwndhFrameB
		
		
		
		
		debugload()
		DebugCheckbox()
		
		Gui,debugM:Show,x0 y0
	}
	else
	{
		destroy("debugM")
		destroy("pop")
		destroy("pop1")
		destroy("pop2")
	}
}

DebugCheckbox(widget:="")
{
	global
	
	if (widget != "")
	{
		GuiControlGet,value, debugM:, % widget
		%widget% := value
	}
	
	if (debugch2 && debugch3 && debugchj)
	{
		destroy("pin2")
		destroy("pin1")
		destroy("pop2")
		destroy("pop1")
		popgrid("pop")
		
		reloadrecent("pop")
		reloadgrid("pop")
	}
	else
	{
		destroy("pop")
		if (widget="debugch2" || widget="" || debugchj)
		{
			if debugch2
			{
				destroy("pin1")
				popgrid("pop1")
				
				reloadrecent("pop1")
			}
			else
			{
				destroy("pop1")
				
				localwindow(hFrameA,"pin1","-Caption")
				specialgrid1("pin1",0,0)
				Gui, pin1:Show, x0 y0
				
				reloadrecent("pin1")
			}
		}
		if (widget="debugch3" || widget="" || debugchj)
		{
			if debugch3
			{
				destroy("pin2")
				popgrid("pop2")
				
				reloadgrid("pop2")
			}
			else
			{
				destroy("pop2")
				
				localwindow(hFrameB,"pin2","-Caption")
				specialgrid2("pin2",0,0)
				Gui, pin2:Show, x0 y0
				
				reloadgrid("pin2")
			}
		}
	}
}

reloadrecent(Uid)
{
	global debug
	debug.recent.reload(Uid)
}

reloadgrid(Uid)
{
	global debug
	debug.incar.reload(Uid)
	debug.hotkey.reload(Uid)
	debug.menu.reload(Uid)
	debug.fov.reload(Uid)
	debug.weapon.reload(Uid)
	debug.role.reload(Uid)
}

popgrid(Uid)
{
	global
	
	static FontName:="Courier",FontColor:="Black",FontSize:=2
	
	Gui, %Uid%:New, +LastFound -Caption +AlwaysOnTop +ToolWindow +E0x08000000 hwnd%Uid%
	
	if opacpop(Uid)
	{
		Gui, %Uid%:Font, S%FontSize% C%FontColor%, %FontName%
		Gui, %Uid%:Color, 000001
		WinSet, TransColor, 000001
	}
	
	ydisp:=1,height:=0
	if (Uid="pop1" || Uid="pop")
	{
		specialgrid1(Uid,1,1)
		ydisp:=24,height+=23
	}
	if (Uid="pop2" || Uid="pop")
	{
		specialgrid2(Uid,1,ydisp)
		height+=123
		
		
	}
	
	rpdebug()
	showpop(Uid,height)
}

specialgrid1(Uid,x,y)
{
	global specialindex
	creategrid(Uid,x,y,specialindex,1,1,21,42,60)
}

specialgrid2(Uid,x,y)
{
	global specialindex
	pop := opacpop(Uid) ? 1 : 3
	creategrid(Uid,x,y,specialindex+1,6,pop,21,42,60)
}

showpop(Uid,height)
{
	global
	
	position = %Uid%_position
	data := %position%
	Gui, %Uid%:Show,%data% w103 h%height%
}

destroy(Uid)
{
	Gui,%Uid%:destroy
}

opacpop(value)
{
	global
	exp := InStr(value,"pop") && debugchp
	return exp
}

displaypop(type)
{
	global 
	
	if (type="Hide")
	{
		Gui, pop1:Hide
		Gui, pop2:Hide
		Gui, pop:Hide
	}
	else
	{
		if (debugch2 && debugch3)
		{
			Gui, pop:Show
			return
		}
		if debugch2
		{
			Gui, pop1:Show
		}
		if debugch3
		{
			Gui, pop2:Show
		}
	}
}

;////////////////////////////////////////////////////////////////////////////////////////////

debugdelay(mode=0)
{
	global
	if mode
		GuiControlGet,debugch1,debugM:,debugch1
		
	SplashQueue.interval := debugch1 ? 1000 : 100
}

debugpopjoin()
{
	global
	GuiControlGet,value,debugM:,debugchj
	debugchj := value
	;if debugch2 && debugch3
	DebugCheckbox()
}

debugopac()
{
	global
	GuiControlGet,debugchp,debugM:,debugchp
	destroy("pop2")
	destroy("pop1")
	destroy("pop")
	;if debugch2 || debugch3
	DebugCheckbox()
}

cleardebug()
{
	global 
	debug.recent.reset()
	debug.incar.reset()
	debug.hotkey.reset()
	debug.menu.reset()
	debug.fov.reset()
	debug.weapon.reset()
	debug.role.reset()
	logger := []
}

WindowDrag()
{
	global
	GuiControlGet,value,Main:,tb4ch1
	tb4ch1 := value
}

WindowOpacity()
{
	global
	GuiControlGet,value,Main:,tb4ch2
	tb4ch2 := value
	if tb4ch2
	{
		SetOpacity(MainGui,tb4edit1)
	}
	else
	{
		SetOpacity(MainGui,0)
	}
}

;/////////////////////////////////////////////////////////////////////////////////

debugread()
{
	global
	
	readinit(gSavePath,"Tab4","tb4ch1")
	GuiControl, Main:, tb4ch1, % tb4ch1
	
	readinit(gSavePath,"Tab4","tb4ch2")
	GuiControl, Main:, tb4ch2, % tb4ch2
	
	readinit(gSavePath,"Tab4","tb4edit1")
	GuiControl, Main:, tb4edit1, % tb4edit1
	tb4slider1 := tb4edit1
	GuiControl, Main:, tb4slider1, % tb4edit1
	
	readinit(gSavePath,"Tab4","debugcht")
	GuiControl, Main:, debugcht, % debugcht

	readinit(gSavePath,"Tab4","debugchj")
	readinit(gSavePath,"Tab4","debugch1")
	readinit(gSavePath,"Tab4","debugchp")
	readinit(gSavePath,"Tab4","debugch2")
	readinit(gSavePath,"Tab4","debugch3")
}

debugload()
{
	global
	
	GuiControl, debugM:, debugchj, % debugchj
	GuiControl, debugM:, debugch1, % debugch1
	GuiControl, debugM:, debugchp, % debugchp
	GuiControl, debugM:, debugch2, % debugch2
	GuiControl, debugM:, debugch3, % debugch3
}

debugwrite()
{
	global
	
	writeinit(gSavePath,"Tab4","tb4ch1")
	writeinit(gSavePath,"Tab4","tb4ch2")
	writeinit(gSavePath,"Tab4","tb4edit1")
	
	if DeMoStyle
		return
	
	writeinit(gSavePath,"Tab4","debugcht")
	writeinit(gSavePath,"Tab4","debugchj")
	writeinit(gSavePath,"Tab4","debugch1")
	writeinit(gSavePath,"Tab4","debugchp")
	writeinit(gSavePath,"Tab4","debugch2")
	writeinit(gSavePath,"Tab4","debugch3")
	
}



wpdebug()
{
	global 
	if debugch2 && debugch3 && debugchj
	{
		svwp(pop,"pop_position")
	}
	else
	{
		if debugch2
			svwp(pop1,"pop1_position")
		if debugch3
			svwp(pop2,"pop2_position")
	}
}

rpdebug()
{
	global pop_position,pop1_position,pop2_position,gSavePath
	
	readinit(gSavePath,"window position","pop_position")
	readinit(gSavePath,"window position","pop1_position")
	readinit(gSavePath,"window position","pop2_position")
	chwp(pop_position)
	chwp(pop1_position)
	chwp(pop2_position)
}

svwp(hwnd,position)
{
	global gSavePath
	WinGetPos, gui_x, gui_y,,, ahk_id %hwnd%
	if (gui_x > 0 && gui_x < 1366 && gui_y > 0 && gui_y < 800)
	{
		%position% = x%gui_x% y%gui_y%
	}
	else
	{
		%position% = x933 y17
	}
	writeinit(gSavePath,"window position",position)
}

chwp(byref position)
{
	data := Invformat(position,"x{} y{}")
	gui_x := data[1]
	gui_y := data[2]
	
	if (gui_x > 0 && gui_x < 1366 && gui_y > 0 && gui_y < 800)
	{
		position = x%gui_x% y%gui_y%
	}
	else
	{
		position = x933 y17
	}
}

;/////////////////////////////////////////////////////////////////////////////////



;////////////////////////////////////////////////////////////////////////////////////////////

localwindow(parent,child,attr)
{
	global
	Gui, %child%:New, +Parent%parent% %attr%
}


class Manage
{
	__New(window,id,widget,name,attr,list:="")
	{
		this.window := window
		this.id := id
		this.name := name
		this.widget := widget
		
		this.blank := "tag" . id
		this.label := "stat" . id
		this.keys := ""
		this.tags := ""
		this.select := ""
		this.wrap := ""
		
		this.pop := 0
		
		this.var := attr.variable
		this.default := attr.default
		this.function := attr.function
		this.save := attr.save
		this.store := attr.write
		this.trigger := attr.label
		this.modifier := attr.modifier
		this.pattern := attr.pattern
		
		this.init(list)
		this.read()
		this.load()
		this.bind()
	}
	
	__Delete()
	{
		this.write()
	}
	
	init(list)
	{
		Switch this.widget
		{
			case 2:
			{
				if (this.default="")
					this.default := 0
			}
			case 3:
			{
				if list
				{
					if (this.default="")
						this.default := 1
					
					this.size := list.count()
					if !InStr(list[1],":")
					{
						this.tags := list
					}
					else
					{
						this.keys := []
						this.tags := []
						i:=1
						while (i<=this.size)
						{
							dict := StrSplit(list[i],":")
							this.keys.push(dict[1]+0)
							this.tags.push(dict[2])
							i++
						}
					}
				}
			}
		}
	}
	
	read()
	{
		global
		if (this.save && this.var)
			readinit(SavePath,this.save,this.var)
	}
	
	write()
	{
		global
		if (this.save && this.var)
			writeinit(SavePath,this.save,this.var)
	}
	
	set(value)
	{
		
		if (this.widget=3)
		{
			if value is not integer
			{
				if value
				{
					index := this.check(value)
					if !index
						return
					value := this.reverse(index)
				}
				else
				{
					value := this.default
				}
			}
			
			if this.pop
			{
				this.edit(this.tags[this.search(value)])
			}
			else
			{
				this.ddl(value)
			}
		}
		else if (this.widget=4)
		{
			this.fg(value)
			return
		}
		else
		{
			this.edit(value)
		}
		
		this.select := value
	}
	
	update()
	{
		if this.var
			this.set(this.deref())
	}
	
	load()
	{
		this.title()
		this.build()
		if this.var
		{
			this.set(this.deref())
		}
		else
		{
			this.set(this.default)
		}
	}
	
	reload(window)
	{
		this.window := window
		this.pop:=opacpop(window)
		
		this.title()
		this.build()
		this.bind()
		this.pre()
	}
	
	pre()
	{
		this.set(this.select)
	}
	
	reset()
	{
		if (this.widget=1)
			this.title("",1)
		this.set(this.default)
		this.follow()
	}
	
	bind()
	{
		global
		tempf := ObjBindMethod(this, "follow")
		GuiControl, % this.window ":+g", % this.label, % tempf
		
		tempf := ObjBindMethod(this, "reset")
		GuiControl, % this.window ":+g", % this.blank, % tempf
		
		if this.function
			this.wrap := Func(this.function).bind(this)
	}
	
	follow()
	{
		global
		
		if (this.widget=3 && this.pop=0)
		{
			this.select := this.reverse(this.get())
		}
		else if (this.widget=4)
		{
			this.fg(this.get())
		}
		else
		{
			this.select := this.get()
		}
		
		if this.var
		{
			tempv := this.var
			%tempv% := this.select
		}
		
		if this.function
		{
			this.wrap.call()
		}
		
		if this.store
		{
			this.write()
		}
	}
	
	prop(name,value)
	{

		this.title(name)
		this.set(value)
	}
	
	retrieve(type="")
	{
		if (type="str")
			return this.tags[this.search(this.select)]
		else
			return this.select
	}
	
	;internal functions
	
	fg(data)
	{
		global
		
		;"[+!\^]"
		value := trim(RegExReplace(data, this.pattern))
		
		if (value!="" )
		{
			for index,key in keyreg
			{
				if (key=value && index!=this.id && key!="")
				{
					value := this.select
					break
				}
			}
		}
		else
		{
			if (trim(data)!="")
			{
				value := this.select
			}
		}
		
		if (this.select!=value)
		{
			key2bind := this.modifier . value
			previous := this.modifier . this.select
			
			this.edit(value)
			keyreg[this.id] := value
			try
			{
				if this.select
					Hotkey, % previous, Off
			}
			try
			{
				Hotkey, % key2bind,% this.trigger,On
			}
			catch e
			{
				OutputDebug,Hotkey Not Defined %key2bind%
			}
			this.select := value
		}
		
	}
	
	deref()
	{
		global
		tempv := this.var
		data := %tempv%
		return data
	}
	
	get()
	{
		GuiControlGet,value,% this.window ":",% this.label
		return value
	}
	
	title(value:="",state:=0)
	{
		if (value!="" || state)
			this.name := value
		
		GuiControl,% this.window ":",% this.blank,% this.name
	}
	
	edit(value)
	{
		GuiControl,% this.window ":",% this.label,% value
	}
	
	ddl(select)
	{
		GuiControl,% this.window ":choose",% this.label,% this.search(select)
	}
	
	build()
	{
		if (this.widget=3 && this.pop=0)
			GuiControl,% this.window ":",% this.label,% this.join()
	}
	
	join()
	{
		return this.tags.join("|")
	}
	
	;list to key
	reverse(index)
	{
		if this.keys
			return this.keys[index]
		else
			return index
	}
	
	;key to list
	search(key)
	{
		if this.keys
		{
			i:=1
			while(i<=this.size)
			{
				if (key=this.keys[i])
					return i
				i++
			}
		}
		return key
	}
	
	check(data)
	{
		for key, value in this.tags
		{
			if (value = data)
				return key
		}
		return 0
	}
}



;r := serial("ddefault nName vVariable gfunction")
;r.n,r.v,r.g,r.d
serial(data)
{
	arr := StrSplit(RegExReplace(data, " +", " ")," ")
	result := {}
	
	i:=1
	size := arr.count()
	while(i<=size)
	{
		result[SubStr(arr[i], 1, 1)] := SubStr(arr[i], 2)
		i++
	}
	return result
}

;////////////////////////////////////////////////////////////////////////////////////////////

creategrid(Uid,gpx,gpy,num,rows,widget,cllh,cllw,cllw0)
{
	global
	
	;create a display grid
	cols:=2, wsp:=-1, hsp:=-1
	opt:="0x200 BackGroundTrans border "
	r:=0,c:=0
	While r++ < rows
	{
		While c++ < cols
		{
			name := (c=1) ? "tag" num : "stat" num
			id := " v" name " Hwnd" name
			
			
			if (c=1)
			{
				if (r=1)
					attr := " w"cllw " x"gpx " y"gpy " section"
				else
					attr := " w"cllw " xs" " y+"hsp
				Gui, %Uid%: add, text, % opt " h"cllh id attr,
			}
			else
			{
				attr := " w"cllw0 " x+"wsp " yp"
				
				Switch widget
				{
					case 1:
					{
						Gui, %Uid%: Add, text, % opt " h"cllh id attr,
					}
					case 2:
					{
						Gui, %Uid%:Add, Edit, % id attr " number Limit2 w" cllw0,
						Gui, %Uid%:Add, UpDown, ,
					}
					case 3:
					{
						Gui, %Uid%: Add, DropDownList,% id attr "w" cllw0 " AltSubmit",
					}
					case 4:
					{
						Gui, %Uid%: Add, Hotkey, % opt " h"cllh id attr,
					}
				}
				
			}
		}
		c:=0
		num++
	}
}
;/////////////////////////////////////////////////////////////////////////////////
