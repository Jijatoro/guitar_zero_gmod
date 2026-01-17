----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
local file_data = {
	["setting"] = {
		name = "setting",
		folder = "jlib", 
		path = "guitar_hero.json", 
		data_default = {
			["language"] = "en",
			["mode"] = "classic",
			["first"] = true,
			["binds"] = {
			    [1] = KEY_A,
			    [2] = KEY_S,
			    [3] = KEY_D,
			    [4] = KEY_F,
			    [5] = KEY_G
			},
			["playlist"] = {},
			["playlist_current"] = "-"
		}
	}
}

local valid_date = {
	["language"] = function(val)
		if not (val) or not (isstring(val)) then return false end
 		if not (Guitar_Hero.Languages[val]) then return false end
 		return true
	end,
	["mode"] = function(val)
		if not (val) or not (isstring(val)) then return false end
 		if not (Guitar_Hero.Modes[val]) then return false end	
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
	end,
	["playlist"] = function(val)
		if not (val) or not (istable(val)) then return false end
		return true
	end,	
	["playlist_current"] = function(val)
		if not (val) or not (isstring(val)) then return false end
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

	--[*] Закрепляющая обработка
	for k, v in pairs(file_data["setting"].data_default) do
		if (Guitar_Hero.MySetting["setting"][k] == nil) then
			Guitar_Hero.MySetting["setting"][k] = v
		end
	end

	--[*] Очищаем удалённую музыку из плейлистов
	for key, music in pairs(Guitar_Hero.MySetting["setting"]["playlist"]) do
		if (key == "-") then continue end
		for id, name in ipairs(music) do
			local mp3, fold = file.Find("sound/zero_guitar/music/" .. name, "GAME")
			if not (mp3) or (mp3 == nil) or (table.IsEmpty(mp3)) then
				Guitar_Hero.MySetting["setting"]["playlist"][key] = nil
			end
		end
	end

	Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])
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
				jlib.vgui.PlaySound("jlib/ui/main/quest_complete.mp3", nil, true)
			elseif (reason == "fail") then
				jlib.vgui.PlaySound("fail", nil, true)
				Guitar_Hero.PlayNet("fail", nil, nil)
			end return
		end

		if (type == "hero_r") then
			if (reason == "won") then
				jlib.vgui.PlaySound("jlib/ui/main/quest_complete.mp3", nil, true)
			elseif (reason == "fail") then
				jlib.vgui.PlaySound("fail", nil, true)
				Guitar_Hero.PlayNet("fail", nil, nil)
			end return		
		end
	end)
end)

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   
