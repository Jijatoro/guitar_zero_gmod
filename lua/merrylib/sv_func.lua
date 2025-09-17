----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
MerryUI = {}

----------------------------------------------------------------------------------------------|>
--[+] Измерение длины строки :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
----------------------------------------------------------------------------------------------|>
function MerryUI.len(str)
  	local len = 0
  	local i = 1
  		while i <= #str do
    		local byte = string.byte(str, i)
    		if byte <= 127 then
      			i = i + 1
    		elseif byte <= 223 then
      			i = i + 2
    		elseif byte <= 239 then
      			i = i + 3
    		else
      			i = i + 4
    		end
    			len = len + 1
  		end
  	return len
end

----------------------------------------------------------------------------------------------|>
--[+] Обрезка текста :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
----------------------------------------------------------------------------------------------|>
function MerryUI.sub(str, start_char, end_char)
    local data_word = {}
    local len = 1
    local i = 1

    while i <= #str do
        if not (string.byte(str, i)) then break end
        local byte = string.byte(str, i)
        local char_length = 1

        if (len > end_char) then break end
        
        -- Определяем длину символа в UTF-8
        if byte <= 127 then
            char_length = 1
        elseif byte <= 223 then
            char_length = 2
        elseif byte <= 239 then
            char_length = 3
        else
            char_length = 4
        end

        if (len >= start_char) then
            local char = string.sub(str, i, i + char_length - 1)
            table.insert(data_word, char)
        end

        i = i + char_length
        len = len + 1
    end

    local new_data = table.concat(data_word, "")
    return new_data
end

----------------------------------------------------------------------------------------------|>
--[+] Проверка на плохие символы :--:--:--:--:--:--:--:--:--:--:--:}>                         |>
----------------------------------------------------------------------------------------------|>
function MerryUI.blacksymbol(str, form)
	if (form == "name") then
		for i = 1, string.len(str) do
			local cout = 0
			if (MerryBlackSymbol_Name[string.sub(str, i, i+cout)]) then
				return false
			end
				cout = cout+1
			end
	else
		for i = 1, string.len(str) do
			local cout = 0
			if (MerryBlackSymbol_Text[string.sub(str, i, i+cout)]) then
				return false
			end
			cout = cout+1
		end
	end
	return true
end