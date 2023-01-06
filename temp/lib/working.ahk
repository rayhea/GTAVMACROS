;interprompt("",[])
interprompt(func,params)
{
	global 
	SplashQueue.push(func,params)
}

;interconsole("",)
interconsole(key,data)
{
	global 
	
	if (key!="recent")
	{
		debug[key].set(data)
	}
	if debugcht
	{
		SplashQueue.push("update_recent",[key,data])
	}
}

;////////////////////////////////////////////////////////////////////////////////////////////
;public   program -> gui
;private  gui -> program

update_recent(key,data)
{
	global 
	debug.recent.title(debug[key].name)
	debug.recent.set(debug[key].retrieve("str"))
}

public_weaponbind(button)
{
	global
	menu[button].update()
	menu[button].write()
}

public_weapon()
{
	global 
	debug.weapon.update()
}

public_fov()
{
	global 
	if ToggleFPV
	{
		value:=1
	}
	else
	{
		value:=FOV+1
	}
	debug.fov.set(value)
}

public_role()
{
	global
	debug.role.set(player.get())
}



;f::
private_incar(obj)
{
	global
	
	temp0 := obj.select
	ScrollWheelVar := temp0
	fScrollVar := false
	InterMediateScroll(temp0)
}

;CbHotkey
private_hotkey(obj)
{
	global
	temp0 := obj.select
	HotkeyStateVar := !temp0
	InterMediateHotkey(temp0)
}

private_menu(obj)
{
	global 
	logger := []
	temp0 := obj.retrieve("str")
	if (temp0 != "None")
	{
		logger.push(temp0)
	}
}

private_fov(obj)
{
	global 
	value:=obj.retrieve()
	if (value=1)
	{
		ToggleFPV:=1
	}
	else
	{
		ToggleFPV:=0
		FOV:=value-1
	}
}

private_role(obj)
{
	global 
	value:=obj.retrieve()
	player.set(value)
}

private_network(obj)
{
	global
	NetworkAdapter := obj.retrieve("str")
	AdapterPipes := cbjoin(AdapterRadioArr,NetworkAdapter)
	writeinit(SavePath,"Network","AdapterPipes")
	Gui, Net:Destroy
}

private_snack(obj)
{
	global 
	SelectedSnacks := obj.retrieve("str")
	writeinit(SavePath,"Mics","SelectedSnacks")
}








