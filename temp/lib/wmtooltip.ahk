

ToggleOnMessage(Type,State)
{
	static GWM := {0x200:"WM_MOUSEMOVE",0x201:"WM_LBUTTONDOWN"}
	Switch Type
	{
		case "Gui":
		{
			for nmsg,name in GWM
			{
				option := State ? name : ""
				OnMessage(nmsg,option)
			}
		}
	}
}

;////////////////////////////////////////////////////////////////////////////////////////////

WM_MOUSEMOVE(wParam, lParam, Msg)
{
	static current,previous
	static widgets := {}
	
	current := A_GuiControl
	obj := widgets[current]
	
	if IsObject(obj)
		value := obj.call()
	else
		value := obj
	
	if (value!="" && current!=previous)
		tooltipformat(value)
	if (value=="" && current!=previous)
		ToolTip
	previous := current
}

tooltipformat(text)
{
	ToolTip % text
}


;////////////////////////////////////////////////////////////////////////////////////////////
;https://www.autohotkey.com/boards/viewtopic.php?t=67


WM_LBUTTONDOWN(wParam, lParam, msg, hwnd)
{
    global tb4ch1,MainGui
    If (tb4ch1=1 && hwnd=MainGui)
	{
        DllCall("PostMessage", "uint", hWnd, "uint", 0x00A1, "uint", 2, "uint", 0)
	}
}








