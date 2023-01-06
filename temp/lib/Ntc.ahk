
class iprop
{
	;https://www.autohotkey.com/boards/viewtopic.php?t=30908
	hsl360(Color)
	{
		r:=(Color>>16)&0xFF
		g:=(Color>>8)&0xFF
		b:=Color&0xFF
		
		minima:=(r<g) ? r:g
		minima:=(minima<b) ? minima:b

		maxima:=(r>g) ? r:g
		maxima:=(maxima>b) ? maxima:b

		h:=s:=l:=(maxima+minima)/2

		if (maxima=minima)  ;-- Achromatic
			h:=s:=0
		 else
		{
			d:=maxima-minima
			s:= abs(l>0.5 ? d/(2-maxima-minima):d/(maxima+minima))

			if (maxima=r)
				h:=(g-b)/d+(g<b ? 6:0)
			 else if (maxima=g)
				h:=(b-r)/d+2
			 else if (maxima=b)
				h:=(r-g)/d+4

			h/=6.0
		}
		l/=255
		return [round(h),round(s),round(l)]
	}


	InRange(test, data, range:=4)
	{
	  return (Abs((test     & 0xFF) - ( data        & 0xFF)) <= range
	  &&  Abs(((test >> 8)  & 0xFF) - ((data >> 8)  & 0xFF)) <= range
	  &&  Abs(((test >> 16) & 0xFF) - ((data >> 16) & 0xFF)) <= range)
	}
}


;https://chir.ag/projects/ntc/ntc.js
class ntc
{
	
	__New(byref names)
	{
		;this.sort(names)
		this.names := []
		Loop % names.Count()
		{
			color := "0x" . names[A_index][1]
			rgb := this.rgb(color)
			hsl := this.hsl(color)
			this.names.Insert([color,names[A_index][2],rgb[1], rgb[2], rgb[3], hsl[1], hsl[2], hsl[3]])
		}
	}
	
	name(color)
	{
		rgb := this.rgb(color)
		r := rgb[1], g := rgb[2], b := rgb[3]
		
		;msgbox % "name " r " " g " " b " "
		
		hsl := this.hsl(color)
		h := hsl[1], s := hsl[2], l := hsl[3]
		
		ndf1 := 0, ndf2 := 0, ndf := 0
		cl := -1, df := -1
		
		Loop % this.names.Count()
		{
		  if(color = "0x" . this.names[A_index][1])
			return [this.names[A_index][1], this.names[A_index][2], true]

		  ndf1 := (r - this.names[A_index][3])**2 + (g - this.names[A_index][4])**2 + (b - this.names[A_index][5])**2
		  ndf2 := (h - this.names[A_index][6])**2 + (s - this.names[A_index][7])**2 + (l - this.names[A_index][8])**2
		  ndf := ndf1 + ndf2 * 2
		  if(df < 0 || df > ndf)
		  {
			df := ndf
			cl := A_index
		  }
		}
		
		return (cl < 0 ? ["0x000000", "Invalid Color: " . color, false] : [this.names[cl][1], this.names[cl][2], false])
	}
	
	display()
	{
		Loop % this.names.Count()
		{
			tooltip % format("Hex:{} Color:{} r:{} g:{} b:{} h:{} s:{} l:{}",this.names[A_index][1], this.names[A_index][2], this.names[A_index][3], this.names[A_index][4], this.names[A_index][5], this.names[A_index][6], this.names[A_index][7], this.names[A_index][8])
			sleep,1000
		}
	}
	
	
	hsl(color)
	{

		r:=((color>>16)&0xFF)/255
		g:=((color>>8)&0xFF)/255
		b:=(color&0xFF)/255
		
		;msgbox % "hsl" r " " g " " b " "
		
		minima := Min(r,Min(g,b))
		maxima := Max(r,Max(g,b))
		delta := maxima - minima
		l := (maxima + minima)/2
		s := 0
		if (l>0 && l<1)
			s := delta/(l < 0.5 ? (2 * l) : (2 - 2 * l))
			
		h:=0
		if(delta>0)
		{
			if (maxima == r && maxima != g)
				h += (g - b) / delta
			if (maxima == g && maxima != b)
				h += (2 + (b - r) / delta)
			if (maxima == b && maxima != r)
				h += (4 + (r - g) / delta)
			h /= 6
		}
		return [round(h * 255), round(s * 255), round(l * 255)]
	}
	
	rgb(color)
	{
		return [(color>>16)&0xFF,(color>>8)&0xFF,color&0xFF]
	}
	
	sort(Arr)
	{
		size := Arr.Count()
		marker := 0
		
		While(marker<=size)
		{
			number := "0x" . Arr[marker][1]
			
			capture := 0
			index := marker
			While(index<=size)
			{
				data := "0x" . Arr[index][1]
				
				if (number >= data)
				{
					number := "0x" . Arr[index][1]
					capture := index
				}
				
				index+=1
			}
			
			if (capture!=marker)
			{
				tempVar := Arr[capture]
				Arr[capture] := Arr[marker]
				Arr[marker] := tempVar
			}
			
			marker+=1
		}
	}

	find(data)
	{
		if data is xdigit
			check := 1
		else
			check := 2
			
		Loop % this.names.Count()
		{
			store := this.names[A_index][check]
			if (data=store)
			{
				if check=1
					return this.names[A_index][2]
				else
					return this.names[A_index][1]
			}
		}
	}


}



;https://stackoverflow.com/questions/9224404/get-color-name-by-hex-or-rgb
class bcr
{
	hsl(color)
	{
		r:=((color>>16)&0xFF)/255
		g:=((color>>8)&0xFF)/255
		b:=(color&0xFF)/255

		maxima := max(r,g,b)
		minima := min(r,g,b)

		l := (maxima + minima) / 2 
		s := 0
		h := 0

		if(maxima != minima)
		{
			if (l < 0.5)
				s := (maxima - minima) / (maxima + minima)
			else
				s := (maxima - minima) / (2.0 - maxima - minima)

			if (r = maxima)
				h := (g-b) / (maxima - minima)
			else if (g = maxima)
				h := 2.0 + (b - r) / (maxima - minima)
			else
				h := 4.0 + (r - g) / (maxima - minima)
		}
		
		l := l * 100
		s := s * 100
		h := h * 60
		
		if (h<0)
			h += 360
		
		return [h, s, l]
	}


	Name(rgb)
	{
		hsl := this.hsl(rgb)
		
		l := floor(hsl[3])
		s := floor(hsl[2])
		h := floor(hsl[1])
		
		if (s <= 10 && l >= 90)
			return "White"
		else if (l <= 15)
			return "Black"
		else if ((s <= 10 && l <= 70) || s = 0)
			return "Gray"
		else if ((h >= 0 && h <= 15) || h >= 346)
			return "Red"
		else if (h >= 16 && h <= 35)
			return (s < 90) ? "Brown" : "Orange"
		else if (h >= 36 && h <= 54)
			return (s < 90) ? "Brown" : "Yellow"
		else if (h >= 55 && h <= 165)
			return "Green"
		else if (h >= 166 && h <= 260)
			return "Blue"
		else if (h >= 261 && h <= 290)
			return "Purple"
		else if (h >= 291 && h <= 345)
			return "Pink"
	}
}






class LocateCorner
{
	__New(x,y,w,h,t,c="",id="")
	{
		this.x := x, this.y := y, this.w := w, this.h := h, this.t := t, this.c := c
		this.scope()
	}
	
	;https://autohotkey.com/board/topic/38968-hex-to-rgb/
	rgbtodec(hex)
	{
		return {"r": hex >> 16 & 0xFF, "g" : hex >> 8 & 0xFF, "b" : hex & 0xFF}
	}
	
	scope()
	{
		s1 := [[this.x,this.y],[this.x+this.t,this.y+2*this.t]]
		s2 := [[this.x+this.t,this.y],[this.x+2*this.t,this.y+this.t]]
		
		s5 := [[this.x+this.w-this.t,this.y+this.h-2*this.t],[this.x+this.w,this.y+this.h]]
		s6 := [[this.x+this.w-2*this.t,this.y+this.h-this.t],[this.x+this.w-this.t,this.y+this.h]]
		
		s3 := [[this.x+this.w-2*this.t,this.y],[this.x+this.w,this.y+this.t]]
		s4 := [[this.x+this.w-this.t,this.y+this.t],[this.x+this.w,this.y+2*this.t]]
		
		s7 := [[this.x,this.y+this.h-this.t],[this.x+2*this.t,this.y+this.h]]
		s8 := [[this.x,this.y+this.h-2*this.t],[this.x+this.t,this.y+this.h-this.t]]
		
		this.corner := [s1,s2,s5,s6,s3,s4,s7,s8]
		
	}
	
	showc()
	{
		Loop 8
		{
			frag := this.id . "s" A_index
			Gui, %frag%: -Caption +ToolWindow +AlwaysOnTop
			
			this.c := mod(A_index,2) ? "FF0000" : "00FF00"
			Gui, %frag%: Color, % this.c
			x := this.corner[A_index][1][1], y := this.corner[A_index][1][2]
			w := this.corner[A_index][2][1] - this.corner[A_index][1][1]
			h := this.corner[A_index][2][2] - this.corner[A_index][1][2]
			Gui, %frag%:Show, % "NA X" x " Y" y " W" w " H" h
			;sleep 4000
			;Gui, %frag%:hide
		}
	}
	
	
	findcorner(threshold := 125, percent := 0.5, checks := 2)
	{
		result := 0
		Loop 2
		{
			count := 0, total := 0
			number := A_index
			Loop 2
			{
				index := 2*number-1 + A_index-1
				xStart := this.corner[index][1][1], yStart := this.corner[index][1][2], xFinal := this.corner[index][2][1], yFinal := this.corner[index][2][2]
				yInit := yStart
				while(yInit < yFinal)
				{
					xInit := xStart
					while(xInit < xFinal)
					{
						color := this.rgbtodec(pixelcolor(xInit,yInit,"Screen"))
						mono := (0.2125 * color.r) + (0.7154 * color.g) + (0.0721 * color.b)
						
						if (mono >= threshold)
							count ++
						
						;MouseMove, xInit, yInit
						
						total++
						xInit++
					}
					yInit++
				}
				
			}
			
			result += (count/total >= percent)
			if (result >= checks)
				return result
			
		}
		return 0
	}
}






