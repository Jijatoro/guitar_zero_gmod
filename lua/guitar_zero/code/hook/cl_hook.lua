----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
local file_data = {
	["setting"] = {
		name = "setting",
		folder = "merry_world", 
		path = "guitar_hero.json", 
		data_default = {
			["language"] = "en",
			["theme"] = "Blue",
			["mode"] = "classic",
			["sound_ui"] = 0.4,
			["first"] = true,
			["binds"] = {
			    [1] = KEY_A,
			    [2] = KEY_S,
			    [3] = KEY_D,
			    [4] = KEY_F,
			    [5] = KEY_G
			}
		}
	}
}

local valid_date = {
	["language"] = function(val)
		if not (val) or not (isstring(val)) then return false end
 		if not (Guitar_Hero.Languages[val]) then return false end
 		return true
	end,
	["theme"] = function(val)
		if not (val) or not (isstring(val)) then return false end
 		if not (Merry.Themes[val]) then return false end	
		return true
	end,
	["mode"] = function(val)
		if not (val) or not (isstring(val)) then return false end
 		if not (Guitar_Hero.Modes[val]) then return false end	
		return true
	end,
	["sound_ui"] = function(val)
		if not (val) or not (isnumber(val)) then return false end
 		if (val > 1) or (val < 0) then return false end	
		return true
	end,
	["first"] = function(val)
		if not (isbool(val)) then return false end
		return true
	end,
	["binds"] = function(val)
		if not (val) or not (istable(val)) then return false end
 		for _, key in pairs(val) do
 			if not (isnumber(key)) then return false end
 			if (key < 0) or (key > 159) then return false end
 		end
		return true
	end
}

----------------------------------------------------------------------------------------------|>
--[+] Игрок прогрузился :--:--:--:--:--:--:--:--:--:--:--:}>                                  |>
----------------------------------------------------------------------------------------------|>
hook.Add("InitPostEntity", "Guitar_Hero.Ready", function()
	--[*] Создание и обработка настроек
	for _, v in pairs(file_data) do
		if (file.Read(v.folder .. "/" .. v.path, "DATA") == nil) then
			local new_data = util.TableToJSON(v.data_default, true)
			file.CreateDir(v.folder) 
			file.Write(v.folder .. "/" .. v.path, new_data) 
			Guitar_Hero.MySetting[v.name] = v.data_default
		else
			Guitar_Hero.MySetting[v.name] = util.JSONToTable(file.Read(v.folder .. "/" .. v.path, "DATA"))
			--[*] На случай ошибочных данных
			for key, val in pairs(Guitar_Hero.MySetting[v.name]) do
				if not valid_date[key](val) then
					Guitar_Hero.MySetting[v.name][key] = file_data[v.name].data_default[key]
				end
			end
		end 
	end
	Guitar_Hero.UpdateThemes(Guitar_Hero.MySetting["setting"]["theme"])	
end)

----------------------------------------------------------------------------------------------|>
--[+] Игрок закончил играть :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
----------------------------------------------------------------------------------------------|>
hook.Add("Guitar_Hero.EndPlay", "Guitar_Hero.End", function(ply, type, reason, counter)
	if (IsValid(Guitar_Hero.Panel_Play)) then Guitar_Hero.Panel_Play:Remove() end
	timer.Remove("Guitar_Hero.TickS")
	timer.Remove("Guitar_Hero.TimeEndPlay")

	timer.Simple(0.1, function()
		if (type == "hero") then
			if (reason == "won") then
				Guitar_Hero.Sound("quest_complete", "ui")
			elseif (reason == "fail") then
				Guitar_Hero.Sound("fail", "ui")
				Guitar_Hero.PlayNet("fail", nil, nil)
			end return
		end

		if (type == "hero_r") then
			if (reason == "won") then
				Guitar_Hero.Sound("quest_complete", "ui")
			elseif (reason == "fail") then
				Guitar_Hero.Sound("fail", "ui")
				Guitar_Hero.PlayNet("fail", nil, nil)
			end return		
		end
	end)
end)

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   
