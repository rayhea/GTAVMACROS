;/////////////////////////////////////////////////////////////////////////////////

ImagePhoneV()
{
	global 
	return SimpleDetect(X,Y,1148,507,1166,523,path4 "\p0v","*120")
}

ImagePhoneH()
{
	global 
	return SimpleDetect(X,Y,1017,456,1035,472,path4 "\p0h","*120")
}

ImageDialN()
{
	global
	return SimpleDetect(X,Y,1178,547,1248,572,path4 "\dial","*100")
}

ImageMainMenu(number)
{
	global 
	return SimpleDetect(X,Y,1156,523,1275,548,path4 "\p" number,"*100")
}

ImageNoPhoto(temp0=550)
{
	global 
	return SimpleDetect(X,Y,1133,temp0,1157,temp0+33,path4 "\unknown","*120 *TransBlack")
}

ImageContacts(mark0,name)
{
	global 
	return SimpleDetect(X,Y,1155,mark0.r,1248,mark0.r+32,path4 "\c." name, "*140 *Trans" mark0.c)
}


phpointer()
{
	yaxis := 554
	Loop % 5
	{
		color := pixelcolor(1160,yaxis)
		if iprop.InRange(color,0x63BBFF,60) 
		{
			return {"i":A_index,"r":550+33*(A_index-1),"c":color}
		}
		yaxis += 33
	}
	return 0
}

NoPhotoLoc()
{
	index := 0
	Error := ImageNoPhoto()
	if !Error
	{
		index := 5
		Loop % 4
		{
			temp0 := 550+33*(index-1)
			Error := ImageNoPhoto(temp0)
			if !Error
			{
				break
			}
			index--
		}
	}
	return index
}

;/////////////////////////////////////////////////////////////////////////////////

ContactsCheck()
{
	global
	
	TargetInFocus()

	setkeydelay, %PhoneSendDelay%, %PhonePressDelay%

	if !NavpMenu(3)
	{
		return 0
	}
	
	
	ActiveContacts := []
	
	total := 10
	last0 := 1000
	
	size := TotalContacts.Count()
	outer := size
	while (outer > 0 && total > 0)
	{
		wMoves(-1,200)
		mark0 := phpointer()
		temp0 := mark0.r
		if (temp0 > last0)
			break
		
		last0 := temp0
		index := outer
		match := 0
		len := (index<6) ? index:size
		
		Loop % len
		{
			tags := TotalContacts[index]
			Error := ImageContacts(mark0,tags)
			if !Error
			{
				match := index
				break
			}
			index--
			
		}
		
		if (match)
		{
			name := TotalContacts[match]
			outer := match - 1
		}
		else
		{
			name := "xxxx"
			total -= 1
		}
		
		;tooltip % format("{} {}",match,name)
		;sleep, 1000
		
		ActiveContacts.InsertAt(1,name)
	}
	
	Send {RButton 2}
	
	setkeydelay, %KeySendDelay%, %KeyPressDelay%
	
	TrackMenu("RightClick")
	
	ContactDetails.write()
	
}



CustomPhoneSearch()
{
	global 
	
	if (GetLastLog()="Phone")
	{
		mark0 := phpointer()
		
		data0 := detectcontacts(TotalContacts,mark0)
		
		tempn := data0[1]
		
		if tempn
		{
			CustomPhoneNumber := tempn
		}
		else
		{
			CustomPhoneNumber := ""
		}
		
		Send {Rbutton 2}
		
		TrackMenu("RightClick")
		
		writeinit(SavePath,"Mics","CustomPhoneNumber")
		return 1
	}
	
}

;/////////////////////////////////////////////////////////////////////////////////

PhoneState()
{
	global PhoneDelay
	
	Error := ImagePhoneV()
	if !Error
	{
		return 100
	}
	Error := ImagePhoneH()
	if !Error
	{
		return 400
	}
	
	Send {Up}
	sleep, %PhoneDelay%
	
	Error := ImagePhoneV()
	if Error
	{
		throw 0
	}
	
	return 0
}

IntoPhone(number)
{
	if (number=3)
	{
		mark0 := phpointer()
	}
	
	if (!mark0)
	{
		Send {Enter}
		mark0 := -1
		sleep 200
	}
	
	return mark0
}

pMenuScr(number)
{
	if (number=3)
	{
		TrackMenu("Phone")
	}
}

IsDialMade()
{
	sleep 1500
	Error1 := ImageDialN()
	Error2 := ImagePhoneV()
	if !Error1 || Error2
	{
		EmptyLastLog("Phone")
	}
}



NavpMenu(number)
{
	global
	
	try
	{
		
		pState := PhoneState()
		if pState
		{
			index := pMenuHome(number,pState)
		}
		else
		{
			index := 5
		}
		
		pMenuScr(number)
		NavPhone(index,number)
		
		i := 0
		
		detectphoneN:
		Error := ImageMainMenu(number)
		if !Error
		{
			data0 := IntoPhone(number)
			return data0
		}
		
		Error := ImagePhoneV()
		if Error
		{
			throw 0
		}
		
		while(i<2)
		{
			Loop % 9
			{
				if (A_index!=number)
				{
					
					Error := ImageMainMenu(A_index)
					if !Error
					{
						NavPhone(A_index,number)
						break
					}
				}
				
			}
			i += 1
			goto detectphoneN
		}
		
	}
	
	IsDialMade()
	return 0
}

pMenuHome(number,delay)
{
	match1 := 0
	
	Loop % 2
	{
		if (delay=100)
		{
			match1 := DetectpMenu()
		}
		
		if (match1 = number)
		{
			return number
		}
		
		if (match1 = 0)
		{
			Send {Rbutton}
			sleep, %delay%
			gosub detectphone
		}
	}
	
	delay := 100
	
	sleep 100
	
	temp0 := StepNav(match1,number)
	
	Loop % 3
	{
		temp0[1].call()
		sleep 100
		
		match2 := DetectpMenu(match1)
		
		if (match2 = number)
		{
			return number
		}
		
		if (match1 = match2)
		{
			Send {Rbutton}
			gosub detectphone
		}
		else
		{
			break
		}
	}
	
	return temp0[2]
	
	detectphone:
	if (delay=400)
	{
		Error1 := ImagePhoneH()
		if !Error1
		{
			return
		}
		match1 := 1
	}
	
	Error2 := ImagePhoneV()
	if Error2
	{
		throw 0
	}
	
	return
	
}

StepNav(init,dest)
{
	if (init != 0)
	{
		cursor := displacement(init,dest,9)
		
		if (cursor=1 || cursor=-1)
		{
			label := Func("wMoves").bind(cursor)
			index := traverse(init,cursor,9)
			return [label,index]
		}
		
		data0 := postgrid(init,dest)
		term1 := data0.i
		termy := Normalz(data0.y)
		termx := Normalz(data0.x)
		
		if (termy)
		{
			label := Func("uMoves").bind(termy)
			locy := traverse(term1[1],termy,3)
			locx := term1[2]
			index := gridpost(locy,locx,3)
			return [label,index]
		}
		
		if (termx)
		{
			wRestrict(term1[2],termx,3)
			label := Func("wMoves").bind(termx)
			locx := traverse(term1[2],termx,3)
			locy := term1[1]
			index := gridpost(locy,locx,3)
			return [label,index]
		}
	}
	
	throw 3
}

wRestrict(start,byref move,width)
{
	if (start=1 || start=width)
		move := -1*move
}


DetectpMenu(number=0)
{
	if (number)
	{
		Error := ImageMainMenu(number)
		if !Error
		{
			return number
		}
		return 0
	}
	
	Loop % 9
	{
		
		Error := ImageMainMenu(A_index)
		if !Error
		{
			return A_index
			break
		}
	}
	return 0
}

postgrid(init,dest)
{
	i := matrixp(init,3,3)
	j := matrixp(dest,3,3)
	y := displacement(i[1],j[1],3)
	x := displacement(i[2],j[2],3)
	return {"i":i,"x":x,"y":y}
}

gridpost(row,col,w)
{
	return w*(row-1) + col
}

Normalz(number)
{
	if (number = 0)
		return 0
	if (number < 0)
		return -1
	if (number > 0)
		return 1
}

phListEnds(numa,pnum,select,index,size)
{
	
	if (numa < 6)
	{
		if (numa = "")
		{
			numb := pnum+index-select
			return numb
		}
		
		if (numa=select)
		{
			numb := displacement(numa,pnum,size)
			return numb
		}
	}
	else
	{
		numc := 5-size+numa
		if (numc=select)
		{
			numb := displacement(numa,pnum,size)
			return numb
		}
	}
	
	numb := pnum-numa
	return numb
}

;/////////////////////////////////////////////////////////////////////////////////

ScrollContact(tag,pnum,mark0=-1)
{
	global
	
	size := ActiveContacts.Count()
	
	Error := ImagePhoneV()
	if !Error
	{
		index := NoPhotoLoc()
		
		if (mark0!=-1)
		{
			select := mark0.i
			
			if (index<2)
			{
				data0 := detectcontacts(ActiveContacts,mark0,index,2)
				numb := phListEnds(data0[2],pnum,select,index,size)
			}
			else if (index<5)
			{
				numb := pnum+index-select
			}
			else
			{
				numb := pnum-size-select
			}
			
			;tooltip % format("{},{},{}",data0[1],select,numb)
			
		}
		else
		{
			if (index<5)
			{
				numb := displacement(1,pnum+index,size+index)
			}
			else
			{
				numb := pnum-size-1
			}
		}
		
		wMoves(numb,WheelDelay)
		;LateralMovement(-pnum,WheelMode)
	}
	
	Loop % 2
	{
		mark0 := phpointer()
		
		if mark0
		{
			valid := ErrorContacts(tag,pnum,size,mark0,5)
			if valid
			{
				Send {Enter}
				return 1
			}
		}
		
	}
	return 0
}



ErrorContacts(tag,pnum,size,mark0,range=4)
{
	global 
	
	Error := ImageContacts(mark0,tag)
	if !Error
	{
		return 1
	}
	
	minima := (pnum>range) ? pnum-range:1
	maxima := (pnum<size-3)? pnum+range:size
	index := minima
	
	While (index <= maxima)
	{
		Name := ActiveContacts[index]
		Error := ImageContacts(mark0,Name)
		if !Error
		{
			wMoves(pnum-index,WheelDelay)
			;LateralMovement(index-pnum,WheelMode)
			break
		}
		index++
	}
	
	return 0
}

detectcontacts(byref array,mark0,index=0,state=1)
{
	global
	
	size := array.Count()
	
	if mark0
	{
		Loop % abs(state)
		{
			Loop % size
			{
				Name := array[A_index]
				Error := ImageContacts(mark0,Name)
				if !Error
				{
					return [Name,A_index]
				}
				
			}
			
			if (index=1)
			{
				return ""
			}
			
			if (A_index=2)
			{
				wMoves(Normalz(state))
				mark0 := phpointer()
			}
			
		}
	}
	
	return 0
}

;/////////////////////////////////////////////////////////////////////////////////

bringGameIntoFocus()
{
	global target
	WinActivate % target
}



DialNumber(number)
{
	
	number_clean := RegExReplace(SubStr(number,1,14), "[^0-9*#]", "")
	static log := {"1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"*":10,"0":11,"#":12}
	
	pointer := 1
	
	Loop, parse, number_clean
	{
		term1 := matrixp(pointer,4,3)
		temp0 := log["" A_LoopField]
		
		if !(pointer=temp0)
		{
			term2 := matrixp(temp0,4,3)
			pointer := temp0
			
			rMoves(displacement(term1[2],term2[2],3))
			uMoves(displacement(term1[1],term2[1],4))
		}
		Send {Enter}
		
	}
}

;/////////////////////////////////////////////////////////////////////////////////

matrixp(num,row,col)
{
	quo := ((num-1)//col)+1
	rem := mod(num-1,col)+1
	return [quo,rem]
}


NavPhone(init,dest)
{
	global WheelDelay
	
	cursor := displacement(init,dest,9)
	if (cursor=1 || cursor=-1)
	{
		wMoves(cursor,WheelDelay)
	}
	else
	{
		Move2d(postgrid(init,dest))
	}
}

;/////////////////////////////////////////////////////////////////////////////////
;Movements

rMoves(x)
{
	Key := (x<0) ? "Left":"Right"
	mul := abs(x)
	Send {%Key% %mul%}
}

uMoves(y)
{
	Key := (y<0) ? "Up":"Down"
	mul := abs(y)
	Send {%Key% %mul%}
}

Move2d(grid)
{
	rMoves(grid.x)
	uMoves(grid.y)
}

wMoves(w,delay=0)
{
	Key := (w<0) ? "WheelUp":"WheelDown"
	mul := abs(w)
	Loop % mul
	{
		Send {%Key%}
		sleep %delay%
	}
}

;/////////////////////////////////////////////////////////////////////////////////

LateralMovement(KeyMul,Selector)
{
	global WheelDelay
	
	If (Selector)   ;Mouse
	{
		wMoves(KeyMul,WheelDelay)
	}
	else            ;keyboard
	{
		uMoves(KeyMul)
	}
}



MouseWheel2(by = 1)
{
	global WheelDelay
	Loop %by%
	{
		MouseClick, WheelUp, , , 20, 0, D, R
		Sleep WheelDelay
	}
}
