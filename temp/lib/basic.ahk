;https://www.npmjs.com/package/array.ahk
;https://raw.githubusercontent.com/chunjee/array.ahk/master/export.ahk

; Apply "native" support, redefines Array() to add custom _Array base object
Array(prms*)
{
	prms.base := _Array
	return prms
}


; Define the base class.
class _Array 
{
	join(delim:=",") 
	{
		result := ""
		for index, element in this
			result .= element (index < this.Count() ? delim : "")
		return result
	}

	;[[1,3,2],[[1,2],[7,8,9,[7,8,10]]]].Concat(result:=[])
	Concat(byref result)
	{
		for Index,Elements in this
		{
			if IsObject(Elements)
			{
				Elements.Concat(result)
			}
			else
			{
				result.push(Elements)
			}
		}
	}



	;https://www.autohotkey.com/boards/viewtopic.php?t=76049
	slice(start, end = "")
	{
		len := this.Count()
		if(end == "" || end > len)
			end := len
		
		ret := []
		start -= 1
		c := end - start
		loop %c%
			ret.push(this[A_Index + start])
		return ret
	}

	;_Array.merge([1,2,3,4],[1,2]).join("`n")
	merge(params*)
	{
		result:= []
		result.push(this*)
		for index,param in params
			result.push(param*)
		return result
	}


	;https://www.autohotkey.com/boards/viewtopic.php?t=34230
	;[1,2,3,4].permute()
	permute()
	{

		If (Len := this.count()) = 1
			return [this]
			
		result := []
		Loop, %Len%
		{
			Split1 := this.clone()
			Split2 := Split1.RemoveAt(A_index)
			For each, perm in Split1.permute()
			{
				perm.InsertAt(1,Split2)
				result.Push(perm)
			}
		}
		return result
	}
	
	swap(pointa,pointb)
	{
		temp := this[pointa]
		this[pointa] := this[pointb]
		this[pointb] := temp
	}
	
}

;///////////////////////////////////////////////////////////////////

class keybind
{
	__New()
	{
		this.data := {}
	}
	
	pair(name)
	{
		return this.data[name]["key"]
	}
	
	data(name)
	{
		return this.data[name]
	}
	
	join(name)
	{
		return this.data[name]["mod"] . this.data[name]["key"]
	}
	
	Assign(name,mod,keys*)
	{
		this.data[name] := {mod:mod,key:""}
		
		if (keys.Count()=1)
		{
			this.data[name]["key"] := keys[1]
		}
		
		for i,key in keys
		{
			Hotkey, % mod . key, % name
		}
	}
	
	Hotkey(name="",param*)
	{
		tempf := Func(name).bind(param*)
		Hotkey, if, % tempf
	}
}


