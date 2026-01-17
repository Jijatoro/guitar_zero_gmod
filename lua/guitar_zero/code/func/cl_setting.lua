----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
local function icon()
    return jlib.cfg.icons[jlib.cfg.icon]  or {}
end

local function clr()
    return jlib.cfg.themes[jlib.cfg.theme]  or {}
end

local function lan()
    return jlib.cfg.lans[jlib.cfg.lan] or {}
end

Guitar_Hero.MySetting = {}
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

----------------------------------------------------------------------------------------------|>
--[+] Получаем данные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.GetSetting(name)
 	local text = Guitar_Hero.Languages[Guitar_Hero.MySetting]["setting"]["language"]

	if (file.Read(file_data[name].folder .. "/" .. file_data[name].path, "DATA") == nil) then
		chat.AddText(Color( 0, 159, 255 ), text["Настройки"], Color(255,255,255), text["Папка недоступна"], Color(255,106,106), text["невозможно"] .. ".")
		return file_data[name]
	else 
		local your_data = file.Read(file_data[name].folder .. "/" .. file_data[name].path, "DATA")
		return util.JSONToTable(your_data)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Сохраняем :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.SaveSetting(name, data)
	local new_data = util.TableToJSON(data, true) 
	file.Write(file_data[name].folder .. "/" .. file_data[name].path, new_data) 
end 

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   