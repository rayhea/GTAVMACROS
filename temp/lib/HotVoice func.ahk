
parsegrammar(obj,array)
{
	main := obj.NewGrammar()
	
	for key,value in array
	{
		if IsObject(value)
		{
			param := []
			Loop % value.count()
			{
				temp0 := obj.NewGrammar()
				insertgrammar(temp0,obj,value[A_index])
				param.push(temp0)
			}
			main.AppendGrammars(param*)
		}
		else
		{
			insertgrammar(main,obj,[value])
		}
	}
	return main
}

insertgrammar(byref var,obj,data)
{
	array := IsObject(data) ? data : [data]
	
	Loop % array.count()
	{
		value := array[A_index]
		if InStr(value,",")
		{
			choices := obj.NewChoices(value)
			var.AppendChoices(choices)
		}
		else
		{
			if InStr(value,"/")
			{
				param := StrSplit(value,"/")
				special := obj.GetChoices(param[1])
				var.AppendChoices(special)
				value := param[2]
			}
			var.AppendString(value)
		}
	}
}


LogWords(name,words)
{
	s := ""
	Loop % words.count()
		s .= words[A_index] " "
	
	tooltip % s
}

loadgrammar()
{
	global
	try
	{
		CLR_LoadLibrary(A_WorkingDir "\temp\lib\hv\HotVoice.dll").CreateInstance("HotVoice.HotVoice")
		
		HotVoiceObj := new HotVoice()
		HotVoiceObj.Initialize(0)

		grammar1 := ["Call",[["Anne,Mary","on-her"],["James,Sam","on-his"],["mechanic,lester","from"],"max"],["cell,home,work"],"phone"]
		HotVoiceObj.LoadGrammar(parsegrammar(HotVoiceObj,grammar1), "Contact", Func("LogWords"))

		grammar2 := ["Volume",[["Percent/Percentage"],["quarter,half,three-quarters,full","blast"]]]
		HotVoiceObj.LoadGrammar(parsegrammar(HotVoiceObj,grammar2), "Volume", Func("LogWords"))

		grammar3 := ["Test","up, down, left, right"]
		HotVoiceObj.LoadGrammar(parsegrammar(HotVoiceObj,grammar3), "direction", Func("LogWords"))
	}
}

toggleHv(value)
{
	global
	try
	{
		if value
		{
			HotVoiceObj.StopRecognizer()
			HotVoiceObj.StartRecognizer()
		}
		else
		{
			HotVoiceObj.StopRecognizer()
		}
	}
}
