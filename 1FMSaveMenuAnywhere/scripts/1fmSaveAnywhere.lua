local lasttitle = 0

function _OnInit()
	print("Sora HP:")
	print(ReadInt(0x2D592CC-0x3A0606))
end

function _OnFrame()
	local input = ReadInt(0x233D034-0x3A0606)
	local savemenuopen = ReadByte(0x232A604-0x3A0606)
	if (input == 1793) and savemenuopen~=4 then 
		WriteByte(0x2350CD4-0x3A0606, 0x1)
	end
	
	local titletest = ReadInt(0x7A8EE8-0x3A0606)
	if titletest == 0 and lasttitle ~= 0 then 
		print("game restarted, type 'reload' once game is running")
	end
	lasttitle = titletest
end