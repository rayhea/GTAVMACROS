;//////////////////////////////////////////////////////////////////
;Imported Macros
;https://www.reddit.com/r/gtaonline/comments/bokair/i_polished_my_gtao_autohotkey_script_for_you_guys/




;//////////////////////////////////////////////////////////////////

ToggleAFK:
bringGameIntoFocus()
Sleep 100
SplashTextOn("AFK MODE ON",0,0)
Loop 
{
	xturn := rMdist*((-1)**A_index)
	MouseMove, xturn, 0, 2, R
	
	;key := xturn < 0 ? "a" : "d"
	;Send {%key%}
	
	sleep, 500
	if (0<=A_TimeIdlePhysical && A_TimeIdlePhysical<300)
	{
		break
	}
}
SplashTextOff()
return

typeOutText(Str,State)
{
	global KeySendDelay, KeyPressDelay, ChatSnippetKey, TextSendDelay, TextPressDelay, logger

	bringGameIntoFocus()
	TextStyle := "L"
	
	setkeydelay, %TextSendDelay%, %TextPressDelay%
	
	ChatOpen := (GetLastLog()="chatbox")
	;tooltip % ChatOpen
	if !ChatOpen
	{
		Send {%ChatSnippetKey%}
	}
	
	if State
	{
		type := SpamText(StrStyle(Str,TextStyle))
		
		if InStr(type,"|")
		{
			StrArr := StrSplit(type,"|")
			Loop % StrArr.Count()
			{
				if (A_index!=1)
					Send {%ChatSnippetKey%}
				temp0 := StrArr[A_index]
				Send {text} %temp0%
				Send {Enter}
			}
		}
		else
		{
			StrArr := StrSplit(type)
			Loop % StrArr.Count()
			{
				temp0 := StrArr[A_index]
				Send {text}%temp0%
				if (0<=A_TimeIdleKeyboard && A_TimeIdleKeyboard<300)
				{
					break
				}
			}
			Send {Enter}
		}
	}
	else
	{
		Send % StrStyle(Str,TextStyle)
	}
	
	setkeydelay, %KeySendDelay%, %KeyPressDelay%
	
	if ChatOpen
	{
		TrackMenu("Enter")
	}

}



;//////////////////////////////////////////////////////////////////

btAfk()
{
	BlockMain()
	BlockCh()
	goSub,ToggleAFK
}

btHelp()
{
	global quickpath
	
	try 
	{
		SplitPath,quickpath,,,,nfile
		If WinExist(nfile)
			WinActivate
		else
			run,% "notepad.exe " quickpath
	}
}

dblfunc()
{
	global 
	GuiControlGet, value, Main:, dblSelected
	dblSelected := value
}







;//////////////////////////////////////////////////////////////////


HackDetectMode()
{
	global
	
	try
	{
		if (dblSelected=1 || dblSelected=5)
		{
			fingerprint()
		}
		if (dblSelected=2 || dblSelected=5)
		{
			keypad()
		}
		if (dblSelected=3 || dblSelected=5)
		{
			retro()
		}
		if (dblSelected=4 || dblSelected=5)
		{
			Voltz()
		}
	}
}


;//////////////////////////////////////////////////////////////////
;basic

GetLine(arr,dir)
{
	Loop, read, %dir% 
	{
		Line:=""
		Loop, parse, A_LoopReadLine
		{
			if (A_LoopField = ";")
				break
			Line .= A_LoopField
		}
		
		if Line is not space
			arr.push(Line)
	}
	return
}


Sort(array)
{
	
	size := array.Count()
	marker := 1
	
	While (marker<=size)
	{
		index := 1
		number := array[marker]
		i := marker
		
		while(i<=size)
		{
			if (number>=array[i])
			{
				number:=array[i]
				index:=i
			}
			i++
		}
		
		array.swap(index,marker)
		marker++
	}
	
	return array
}



traverse(i,d,m)
{
	if (d>0)
	{
		q := mod((i+d),m)
		return q ? q : m
	}
	else if (d<0)
	{
		q := mod(abs(i+d),m)
		return (i>abs(d)) ? q : m-q
	}
}


CircularShort(x,d)
{
	return displacement(x,d,8)
}


LateralShort(y,d)
{
	return displacement(ceil(y/2),ceil(d/2),4)
}

displacement(i,d,len)
{
    u := d-i
	a := abs(u)
	b := len-a
	
	(u>0) ? Swap(a,b) : 0
	return (a<b) ? -a : b
	
}

Swap(ByRef Left, ByRef Right)
{
    temp := Left
    Left := Right
    Right := temp
}

;//////////////////////////////////////////////////////////////////
;Movements

xMoves(x)
{
	Key := (x<0) ? "a":"d"
	mul := abs(x)
	Send {%Key% %mul%}
}

yMoves(y)
{
	Key := (y<0) ? "w":"s"
	mul := abs(y)
	Send {%Key% %mul%}
}

;//////////////////////////////////////////////////////////////////

ScrMode(byref x1,byref y1,byref x2=0,byref y2=0)
{
	global target 
	
	WinGetPos, x0, y0,,,% target
	x1 := x1 + x0, y1 := y1 + y0
	x2 := x2 + x0, y2 := y2 + y0
}

pixelcolor(x,y)
{
	ScrMode(x,y)
	CoordMode, Pixel, Screen
	PixelGetColor,color,x,y,RGB 
	return color
}

pixeldetect(x,y,data)
{
	color := pixelcolor(x,y)
	if (color=data)
		return 1
	else 
		return 0
}

ImageDetect(byref X, byref Y,x1,y1,x2,y2,paths,args="*50")
{
	ScrMode(x1,y1,x2,y2)
	CoordMode, Pixel, Screen
	Loop % paths.Count()
	{
		dir := paths[A_index] ".bmp"

		ImageSearch, X, Y, x1, y1, x2, y2, %args% %dir%
		if !ErrorLevel
			return ErrorLevel
	}
	return ErrorLevel
}

SimpleDetect(byref x,byref y,x1,y1,x2,y2,path0,args="*50")
{
	ScrMode(x1,y1,x2,y2)
	CoordMode, Pixel, Screen
	dir := path0 ".bmp"
	ImageSearch, x, y, x1, y1, x2, y2, %args% %dir%
	return ErrorLevel
}

InsertCorner(y,w,h,t,v*)
{
	frame := []
	Loop % v.count()
		frame.push(New LocateCorner(v[A_index],y,w,h,t))
	return frame
            
}

DetectCorner(byref box)
{
	global ToggleHacks
	index := 1
	if (ToggleHacks)
	{
		Loop % size := box.count()
		{
			if box[A_index].findcorner(70,0.30)
			{
				index := size-A_index+1
				break
			}
		}
	}
	;tooltip % index
	return index
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;fingerprint hack

fingerprint()
{
	global path3
	
	static box1 := InsertCorner(604,76,76,2,944,854,764,673)
	extra := "f2.4.4,f4.1.1"
	
	index := 0
	
	detecthack1:
	if (index != last)
	{
		if (index != 0)
		{
			sleep 4300
		}
		
		Error := SimpleDetect( X, Y, 848, 91, 901, 107,path3 "\t" 1)
		if Error
		{
			SplashTextOff()
			if (index)
				throw 0
			else 
				return 0
		}
		
		if (index = 0)
		{
			SplashTextOn("Fingerprint",0,0)
			last := DetectCorner(box1)
		}
	}
	
	index += 1
	
	
	while(index <= last)
	{
		Steps := []
		
		Loop % 4
		{
			root = f%A_index%
			Error := SimpleDetect( X, Y, 675, 131, 944, 494,path3 "\" root)
			if !Error
			{
				
				
				Loop % 4
				{
					child := root "." A_index
					paths := [path3 "\" child]
					find := child "." A_index
					
					If InStr(extra,find)
					{
						paths.insert(path3 "\" find)
					}
						
					Error := ImageDetect( X, Y, 339, 199, 539, 598, paths)
					If !Error
					{
						Steps.Insert(findSubpart(X,Y))
					}
					
				}
				
				
				break
			}
		}
		
		if (Steps.Count()=4)
		{
			MoveFp(SolveFp(Sort(Steps))[2])
			Send {Tab}
		}
		
		goto detecthack1
	}
	
	SplashTextOff()
	throw 1
}

SolveFp(Arr)
{
	static table := [1,2,3,4].permute()
	result := []
	data := []
	minima := 100
	Loop % table.Count()
	{
		combos := table[A_index]
		a := combos[1]
		b := combos[2]
		c := combos[3]
		d := combos[4]
		
		
		steps := [findShortFp(1,Arr[a]),findShortFp(Arr[a],Arr[b]),findShortFp(Arr[b],Arr[c]),findShortFp(Arr[c],Arr[d])]
		
		term := SumFp(steps)
		
		if (minima > term)
		{
			minima := term
			result := [1,Arr[a],Arr[b],Arr[c],Arr[d]]
			data := steps
		}
	}
	
	return [result,data]
}


SumFp(Arr)
{
	total := 0
	
	Loop % Arr.Count()
	{
		total += abs(Arr[A_index][1])+abs(Arr[A_index][2])
	}
	return total
}

MoveFp(Arr)
{
	Loop % 4
	{
		x := Arr[A_index][1]
		y := Arr[A_index][2]
		if x!=0
			xMoves(x)
		if y!=0
			yMoves(y)
		Send {Enter}
	}
}


findShortFp(init,dest)
{
	r := [0,0]
	
	if (init!=dest)
	{
		if (mod(dest,2)=mod(init,2))
		{
			;lateral movement
			
			n :=LateralShort(init,dest)
			r[2]:= n
			
		}
		else
		{
			;circular movement

			t := CircularShort(init,dest)
			
			if (t=1 || t=-1)
			{
				r[1]:= t
			}
			else
			{
				x := (t<0) ? -1:1
				l := traverse(init,x,8)
				r[1]:=x
				
				n := LateralShort(l,dest)
				r[2]:= n
				
			}
		}
	}
	return r
}


CalcFp()
{
	x := 339, y := 199, l := 100, b := 100
	r := []
	Loop % 8
	{
		p := !mod(A_index,2)
		n := (A_index-1)//2
		r.insert([[x+b*p,y+n*l],[x+(p+1)*b,y+(n+1)*l]])
	}
	return r
}


findSubpart(x1,y1)
{
	Static Arr := CalcFp()
	Loop % Arr.Count()
	{
		E := Arr[A_index]
		L := E[1]
		R := E[2]

		if (L[1]<=x1 && x1<R[1] && L[2]<=y1 && y1<R[2])
			return A_index
	}
}


;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;keypad hack

keypad()
{
	global path3
	
	static box2 := InsertCorner(580,35,35,2,1019,970,920,871)
	static start := 0
	static count := 1
	static cursor := 1
	
	index := 0
	
	detecthack2:
	if (index != last)
	{
		if (index != 0)
		{
			sleep 3900
		}
		
		Error := SimpleDetect( X, Y, 489, 174, 542, 190,path3 "\t" 2)
		if Error
		{
			SplashTextOff()
			if (index)
				throw 0
			else
				return 0
		}
		
		if (index = 0)
		{
			SplashTextOn("Keypad",0,0)
			last := DetectCorner(box2)
			
			Error := SimpleDetect(X, Y,860,569,915,625,path3 "\k2")
			if !Error
			{
				start := 0
				count := 1
				cursor := 1
			}
		}
	}
	
	index += 1
	
	
	while(index <= last)
	{
		arr1 := refresh()
		sleep 300
		
		size := arr1.Count()
		if (size!=6)
			return
			
		Loop % size
		{
			x := arr1[A_index]
			t := displacement(cursor,x,5)
			yMoves(t)
			Send {Enter}
			cursor := x
			
			if (A_index!=size)
				sleep 2800
		}
		
		start := A_now
		count ++
		goto detecthack2
	}
	
	SplashTextOff()
	throw 1
}

refresh()
{
	global path3
	
	;SplashTextOn("Refresh",0,0)
	
	temp0 := []
	mark := 1
	size := 5
	output := []
	result := []
	b := 71
	
	start := A_Now
	While(A_now-start<5)
	{
		
		Loop % 6
		{
			x1 := 337 + (A_index-1)*b
			x2 := 337 + A_index*b
			
			Error := SimpleDetect(X,Y,x1,230,x2,593,path3 "\" "k1")
			If !Error
			{
				temp0[A_index] := findSubdot(X,Y,A_index)
			}
		}
		
		if (temp0.count()=6)
		{
			output[mark] := temp0
			
			;tooltip % format("mark:{} {}",mark,output[mark].join(",")),100,0,4
			temp0 := []
			mark += 1
			if (mark>=size+1)
			{
				mark := 1
			}
			
		}
	}
	
	Loop % 6
	{
		temp2 := []
		N := A_index
		Loop % size
		{
			temp2.push(output[A_index][N])
		}
		result.push(findfreq(temp2))
	}
	
	;tooltip % result.join(","),210,0,5
	;SplashTextOff()
	
	return result
}

findfreq(array)
{
	mfreq := 0
	size := array.count()
	i := 1
	mElem := array[1]
	while(i <= size)
	{
		sfreq := 0
		j := 1
		while(j<=size)
		{
			if (array[i]==array[j])
			{
				sfreq += 1
			}
			j += 1
		}
		
		if (sfreq > mfreq)
		{
			mfreq := sfreq
			mElem := array[i]
		}
		i += 1
	}
	return mElem
}


findSubdot(x1,y1,N)
{
	l := 72
	Loop % 5
	{
		U :=230+(A_index-1)*l
		D :=230+A_index*l
		if (U<y1 && y1<D)
			return A_index
	}
	
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;retro fingerprint hack

retro()
{
	global path3
	
	static box3 := InsertCorner(118,87,87,2,886,793,700)
	
	index := 0
	
	detecthack3:
	if (index != last)
	{
		if (index != 0)
		{
			sleep 4000
		}
		
		Error := SimpleDetect( X, Y, 866, 229, 919, 245,path3 "\t" 3)
		if Error
		{
			SplashTextOff()
			if (index)
				throw 0
			else
				return 0
		}
		
		if (index = 0)
		{
			SplashTextOn("Retro",0,0)
			last := DetectCorner(box3)
		}
	}
	
	index += 1
	
	while(index <= last)
	{
		Loop % 7
		{
			root = r%A_index%
			Error := SimpleDetect( X, Y, 646, 246, 1097, 695,path3 "\" root,"*170")
			if !Error
			{
				Loop % 8
				{
					pos := cycle(root,A_index)
					
					if (pos=0)
						break
					
					xMoves(displacement(pos,A_index,8))
					Send {s}
					
					sleep 100
				}
				break
			}
		
		}
		goto detecthack3
	}
	
	SplashTextOff()
	throw 1
}

cycle(root,n)
{
	global path3
	index := 0
	Loop % 8
	{
		child := root "." A_index
		Error := SimpleDetect( X, Y, 288, 267+52*(n-1), 607, 267+52*n, path3 "\" child,"*170")
		If !Error
		{
			;tooltip % child, 0,0
			index := A_index
			break
		}
	}
	return index
}


;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;Voltz Lab hack

Voltz()
{
	global path3
	
	Error := SimpleDetect( X, Y, 651, 78, 709, 94,path3 "\t" 4)
	if !Error
	{
		SplashTextOn("Voltz",0,0)
		sleep 700
		try
		{
			equat := [findnumber(349,198,404,272,"dw",1,9),findnumber(349,359,404,431,"dw",1,9),findnumber(349,519,404,593,"dw",1,9)]
			coef := [findmult(933,194,1013,274),findmult(933,355,1013,434),findmult(933,514,1013,594)]
			rhs := findnumber(590,97,646,173,"dr",0,10)*100 + findnumber(650,97,707,173,"dr",0,10)*10 + findnumber(710,97,767,173,"dr",0,10)

			SolveEq(equat,coef,rhs)
		}
		SplashTextOff()
	}
	
}

SolveEq(equat,coef,rhs)
{
	static perms := [1,2,3].permute()
	
	lhs := ""
	index := ""
	
	for each,index in perms
	{
		lhs := equat[1]*coef[index[1]] + equat[2]*coef[index[2]] +equat[3]*coef[index[3]]
		if (rhs=lhs)
			break
	}
	
	;tooltip % format("sum {}x{},{}x{},{}x{} = {} `n moves {} {}",equat[1],coef[index[1]],equat[2],coef[index[2]],equat[3],coef[index[3]],lhs,index[1],index[2])
	
	moves1 := index[1]
	moves2 := index[2]
	
	cursor := 1
	
	Send {Enter}
	yMoves(displacement(cursor,moves1,3))
	cursor := (moves1=3) ? 2 : moves1+1
	
	Send {Enter}
	sleep 2000
	
	Send {Enter}
	yMoves(displacement(cursor,moves2,3))
	
	Send {Enter}
	sleep 2000
	
	Send {Enter}
	Send {Enter}
}


findnumber(x1,y1,x2,y2,root,i,n)
{
	global path3
	
	Loop % n
	{
		child := root . i
		Error := SimpleDetect( X, Y, x1, y1, x2, y2, path3 "\" child,"*170")
		If !Error
		{
			return i
			break
		}
		i++
	}
	throw -1
}

findmult(x1,y1,x2,y2)
{
	global path3
	
	mul := -1
	Loop % 3
	{
		root = v%A_index%
		Error := SimpleDetect(x,y,x1,y1,x2,y2,path3 "\" root,"*170")
		If !Error
		{
			mul := A_index
			break
		}
	}
	mul := (mul=3) ? 10:mul
	if (mul!=-1)
		return mul
	else
		throw -1
}

find7Segments(a,b,c,d,e,f,g)
{
	static m :=   [[1,1,1,1,1,1,0]
				  ,[0,1,1,0,0,0,0]
				  ,[1,1,0,1,1,0,1]
				  ,[1,1,1,1,0,0,1]
				  ,[0,1,1,0,0,1,1]
				  ,[1,0,1,1,0,1,1]
				  ,[0,0,1,1,1,1,1]
				  ,[1,1,1,0,0,0,0]
				  ,[1,1,1,1,1,1,1]
				  ,[1,1,1,0,0,1,1]]
	
	Loop % 10
	{
		i := A_index
		if (a=m[i][1] && b=m[i][2] && c=m[i][3] && d=m[i][4] && e=m[i][5] && f=m[i][6] && g=m[i][7])
			return i-1
	}
	return -1
}

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
