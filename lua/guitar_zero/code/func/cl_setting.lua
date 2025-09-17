----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
Guitar_Hero.MySetting = {}
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

----------------------------------------------------------------------------------------------|>
--[+] Обновляем тему :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.UpdateThemes(arg)
	if not (Merry.CanTheme) then return end
	Merry.Theme = arg
end

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
	Guitar_Hero.UpdateThemes(data["theme"])	
end 

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   