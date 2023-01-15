;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

ImageIntSlash()
{
	global
	return SimpleDetect(X,Y,317,110,334,127,path4 "\slash","*100")
}

ImageIntMenu()
{
	global
	return SimpleDetect(X,Y,343,103,347,107,path4 "\menu","*50")
}

ImageIntLabel()
{
	global
	return SimpleDetect(X,Y,46,105,170,130,path4 "\int","*50")
}

ImageIntIndex(index)
{
	global
	return SimpleDetect(X,Y,301,110,326,127,path4 "\m." index,"*100")
}

ImageIntSize(index)
{
	global
	return SimpleDetect(X,Y,326,110,346,127,path4 "\m." index,"*100")
}

ImageLabels(incr,mark,label,args)
{
	global 
	return SimpleDetect(X,Y,46+incr,130+26*(mark-1),170+incr,130+26*(mark),path4 "\" label,args)
}



recognize_parent()
{
	x := 51, y := 110
	ScrMode(x,y)
	return OCR([x,y,298,17],"eng")
}

recognize_child()
{
	node := ""
	index := intpointer()
	if index
	{
		x := 46, y := 130+26*(index-1)
		ScrMode(x,y)
		node := OCR([x,y,306,26],"eng")
	}
	return node
}

intpointer()
{
	yaxis := 143
	Loop % 7
	{
		color := pixelcolor(49,yaxis)
		if iprop.InRange(color,0xf0f0f0,30)
		{
			return A_index
			break
		}
		yaxis+=26
	}
	return 0
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

intpage1(inc)
{
	
	mark := intpointer()
	menu := 0
	
	index := mark
	temp2 := 0
	offset := 0
	
	gps := intlabel("quickgps1",1,4,mark)
	
	if (gps=0)
	{
		service := intlabel("services",1,5,mark)
		
		if service
		{
			index := intpos(6-service+mark,4)
			
			if intlabel("hide",service+1,1,mark)
			{
				menu :=-1
			}
			else
			{
				menu := 1
			}
			
			if (introle(menu))
			{
				offset := (inc=1) ?  1-index : inc+service-mark-7
				size := 9
			}
			else
			{
				offset := inc+service-mark-6
				size := 11
			}
			
			stop := index+offset
			size += index+service-mark-1
			
		}
		else
		{
			hide := intlabel("hide",1,3,mark)
			
			index := intpos(8-hide+mark,4)
			
			if (hide>1)
			{
				menu := 1
			}
			
			if (introle(menu))
			{
				offset := (inc=1) ?  1-index : inc+hide-mark-8
			}
			else
			{
				offset := inc+hide-mark-9
			}
			
			stop := index+offset
			size += 7+index+hide-mark
			
		}
	}
	else
	{
		
		
		if !intpos(mark,1)
		{
			index := intpos(mark+1,3)
			temp2 := index
		}
		
		if (temp2=0 && gps>1)
		{
			if intlabel("securoserv",1,1,mark,40)
			{
				menu := 7
			}
			else if intlabel("motorcycle",1,1,mark,40)
			{
				menu := 8
			}
			else if intlabel("associate",1,1,mark,40)
			{
				menu := 5
			}
			else if intlabel("prospect",1,1,mark,40)
			{
				menu := 5
			}
			else
			{
				menu := 1
			}
		}
		
		if (gps=1)
		{
			if !intlabel("hide",7,1,mark)
			{
				
				menu := 1
			}
		}
		
		
		
		if (introle(menu))
		{
			offset := (inc=1) ? (temp2 ? 1-temp2 : inc-mark) : inc+gps-mark-2
			size := 14
		}
		else
		{
			offset := inc+gps-mark-1
			size := 16
		}
		
		stop := index+offset
		size += index+gps-mark-1
		
	}
	;tooltip % format("inc:{},gps:{},mark:{}",inc,gps,mark)
	
	intsize(size)
	
	return {menu:menu,index:index,stop:stop,size:size,offset:offset}
}

introle(byref menu)
{
	global player
	
	if (menu > 0)
	{
		mark := player.get()
		if (menu != mark)
		{
			player.set(menu)
			public_role()
		}
	}
	return menu>4
}





LabelParse(label,byref label1,byref args1,byref label2,byref args2)
{
	data0 := StrSplit(RegExReplace(label, "\s+", " ")," ")
	
	label1 := data0[1]
	label2 := data0[1] ".inv"
	
	if data0[2]
	{
		args1 := data0[2]
		args2 := data0[2]
	}
	else
	{
		args1 := "*140"
		args2 := "*120"
	}
}

intlabel(name,start,len,mark,incr=0)
{
	
	if (len=1)
	{
		if (mark=start)
		{
			Error := ImageLabels(incr,mark,name,"*140")
			if !Error
			{
				
				return mark
			}
			
		}
		else
		{
			Error := ImageLabels(incr,start,name ".inv","*140")
			if !Error
			{
				
				return start
			}
		}
	}
	else
	{
		if (start<=mark && mark<=len+start-1)
		{
			Error := ImageLabels(incr,mark,name,"*140")
			if !Error
			{
				
				return mark
			}
		}
		
		rank := start
		Loop % len
		{
			if (rank!=mark)
			{
				Error := ImageLabels(incr,rank,name ".inv","*140")
				if !Error
				{
					return rank
				}
			}
			rank++
		}
	}
	
	return 0
}

intpos(start,len)
{
	rank := start
	Loop % len
	{
		Error := ImageIntIndex(rank)
		if !Error
		{
			return rank
		}
		rank++
	}
	return 0
}

intsize(byref size)
{
	
	Error := ImageIntSize(size)
	if Error
	{
		name := 15
		Loop % 4
		{
			if (size!=name)
			{
				Error := ImageIntSize(name)
				if !Error
				{
					size := name
					return 0
				}
			}
			name++
		}
	}
	return 1
}



indexparse(title)
{
	mid := RegExMatch(title, "\d")
	if (mid=0)
	{
		text := title
		index := intpointer()
		size := 0
	}
	else
	{
		text := Trim(RegExReplace(SubStr(title,1,mid-1),"\/.*"))
		num := RegExReplace(SubStr(title,mid),"[^0-9\/]")
		StringReplace, num, num, %A_SPACE%,, All
		dash := (Strlen(num)>3) ? -1:0 
		index := SubStr(num,1,-2+dash)+0
		size := SubStr(num,dash)+0
		index := (index<=size) ? index : SubStr(num,1,-3+dash)
	}
	
	intdata(index,size)
	
	return {text:text,index:index,size:size}
}

nodeparse(title)
{
	num := RegExMatch(title,"[^A-Za-z0-9\s]")-1
	return Trim(SubStr(title,1,num))
}


intdata(byref index,byref size)
{
	
	Error := ImageIntSlash()
	if !Error
	{
		Error := ImageIntIndex(index)
		if Error
		{
			rank := 1
			Loop % 18
			{
				Error := ImageIntIndex(rank)
				if !Error
				{
					index := rank
					break
				}
				rank++
			}
		}
		Error := ImageIntSize(size)
		if Error
		{
			rank := 8
			Loop % 18
			{
				Error := ImageIntSize(rank)
				if !Error
				{
					size := rank
					break
				}
				rank++
			}
		}

		return 1
	}
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

searchtree(Array,Head,Node,byref result,byref size,prev="Interaction Menu")
{
	width := Array.Count()-1
	
	for key,value in Array
	{
		if IsObject(value)
		{
			result.push(key)
			size.push(width)
			
			if (Node="")
			{
				if (InMatch(value[0],Head))
					return 1
			}
			else
			{
				if ((InMatch(prev,Head) || Head="") && InMatch(value[0],Node))
					return 1
			}
			
			if (searchtree(value,Head,Node,result,size,value[0]))
			{
				return 1
			}
			else
			{
				result.pop()
				size.pop()
			}
		}
		else if Node
		{
			if ((InMatch(prev,Head) || Head="") && InMatch(value,Node) && key)
			{
				result.push(key)
				size.push(width)
				return 1
			}
		}
	}
	return 0
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

translatemenu(byref pointb,byref data,mIndex)
{
	global
	
	if (data.menu != 0 && data.menu != mIndex)
	{
		labelb := GetNameifObject(MenuItem%mIndex%[pointb[1]])
		
		mark1 := Getlabel(MenuItem%mIndex%,labelb)
		offset := data.stop - mark1
		
		mdata := data.menu
		mark2 := Getlabel(MenuItem%mdata%,labelb)
		
		if (mark2 = 0)
		{
			pointb := []
			return 1
		}
		
		data.stop := mark2 + offset
	}
	
	pointb[1] := data.stop
	
}

Getlabel(byref array,label)
{
	match := 0
	count := array.Count()
	index := 1
	while(index<count)
	{
		title := GetNameifObject(array[index])
		
		if (title == label)
		{
			match := index
			break
		}
		
		index += 1
	}
	return match
}




GetNameifObject(byref value)
{
	if (value)
	{		
		if IsObject(value)
		{
			return value[0]
		}
		else
		{
			return value
		}
		
	}
}


;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

OpenIntMenu()
{
	Error := ImageIntMenu()
	if Error
	{
		Send {m}
		sleep 200
	}
	Error2 := ImageIntMenu()
	if Error2
	{
		throw 0
	}
	TrackMenu("IntMenu")
	return Error
}

IsMenuOpen()
{
	sleep 200
	Error := ImageIntMenu()
	if Error
	{
		EmptyLastLog("IntMenu")
	}
}

InteractionMenu(dest,next="",byref mError=0)
{
	global
	
	try 
	{
		temp3 := []
		pointa := []
		mIndex := player.get()
		
		if !OpenIntMenu()
		{
			if ImageIntLabel()
			{
				if (intr=1)
				{
					head0 := recognize_parent()
					data0 := indexparse(head0)
					mtemp := MultiMatch(data0.text,title0)
					ntemp := (mtemp <= title1.count()) ? 1 : 2 
					
					if mtemp
					{
						init := ""
						send {Esc %ntemp%}
						sleep 200
					}
					else
					{
						init :=[data0.text,""]
						temp3.push(data0.index)
					}
				}
				
				if init
				{
					searchtree(MenuItem%mIndex%,init[1],init[2],pointa,pin0:=[])
					pointa.push(temp3*)
				}
				
			}
		}
		
		searchtree(MenuItem%mIndex%,dest[1],dest[2],pointb:=[],size:=[])
		
		;item1 := format("pointa:{} `n pointb:{}", pointa.join(","),pointb.join(","))
		;tooltip % item1,,,3
		
		;item2 := format("{}`n{},{},{}", head0, data0.text, data0.index, data0.size)
		;tooltip % item2,357,106,2
		
		
		ent := 0
		Loop % pointa.count()-1
		{
			if (pointa[A_index]!=pointb[A_index])
				break
			ent++
		}
		Loop % ent
		{
			pointb.removeat(1)
			pointa.removeat(1)
			size.removeat(1)
		}
		escape := pointa.count()-1
		
		
		
		Loop % escape 
		{
			Send {Backspace}
			
		}
		sleep 200
		
		if (ent=0)
		{
			data := intpage1(pointb[1])
			
			mError := translatemenu(pointb,data,mIndex)
			
			size[1] := data.size
			cursor := data.index
			
		}
		else
		{
			cursor := pointa[1] 
			
		}
		
		if (mError)
		{
			next.close := 1
			goto ExitIntMenu
		}
		
		len := pointb.count()
		Loop % len
		{
			uMoves(displacement(cursor,pointb[A_index],size[A_index]))
			
			if(A_index!=len)
				Send {Enter}
			
			cursor := 1
		}
		sleep 200
		
		init := dest
		intr := 0
		
		if next.arrow
		{
			rMoves(next.arrow)
		}
		
		if next.press
		{
			Send {Enter}
		}
		
		ExitIntMenu:
		
		if next.close
		{
			Send {m}
		}
		
	}
	
	;TrackMenu("IntMenu")
	IsMenuOpen()
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

CustomMenuSearch()
{
	global
	
	if (GetLastLog()="IntMenu")
	{
		mIndex := player.get()
		dest := [indexparse(recognize_parent()).text,nodeparse(recognize_child()),mIndex]
		
		if (mIndex != 1)
		{
			searchtree(MenuItem1,dest[1],dest[2],pointb:=[],size:=[])
		}
		
		if !pointb.count()
		{
			searchtree(MenuItem%mIndex%,dest[1],dest[2],pointb:=[],size:=[])
		}
		else
		{
			dest[3] := 1
		}
		
		if pointb.count()
		{
			CustomMenuLabel := dest
		}
		else
		{
			CustomMenuLabel := []
		}
		
		Send {m}
		IsMenuOpen()
		
		CustomMenuSave.write()
		return 1
	}
	
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

MultiMatch(text,list)
{
	for key,val in list
	{
		if InMatch(text,val,2)
		{
			return key
		}
	}
	return 0
}

InMatch(str1,str2,mode:=1)
{
	for key,val in StrSplit(str1,",")
	{
		if (pMatch(val,str2)[mode]>0.85)
		{
			return 1
		}
	}
	return 0
}

eMatch(str1,str2)
{
	if (str1="" || str2="")
		return 0
	if InStr(str1,str2,false)
		return 1
	else
		return 0
}

DiMatch(str1,str2)
{
	if (str1="" || str2="")
		return 0
	
	size1 := StrLen(str1)-1
	size2 := StrLen(str2)-1
	total := size1+size2
	
	part1 := []
	Loop % size1
		part1.push(SubStr(str1,A_index,2))
	
	output := 0
	Loop % size2
	{
		part2 := SubStr(str2,A_index,2)
		output+=check(part1,part2)
	}
	
	return [2*(output/total),output/size2]
}

pMatch(str1,str2)
{
	part1 := {words:strsplit(str1),size:strlen(str1)}
	part2 := {words:strsplit(str2),size:strlen(str2)}
	
	if (part1.size=0 || part2.size=0)
		return []
	
	total := part1.size + part2.size
	output := 0
	Loop % part1.size
	{
		match := 0, index1 := A_index, index2 := 1
		while(index1 <= part1.size && index2 <= part2.size)
		{
			if (part1.words[index1]=part2.words[index2])
				match++
			index1++,index2++
		}
		if (output<match)
		{
			output := match
			if (output>=part2.size)
				break
		}
	}
	return [2*(output/total),output/part2.size]
}



