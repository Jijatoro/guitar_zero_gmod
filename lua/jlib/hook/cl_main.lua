--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib.vgui) then jlib.vgui = {} end
jlib.vgui.drag_ready = false
jlib.vgui.drag_image = nil
jlib.vgui.drag_size = {}

local function icon()
    return jlib.cfg.icons[jlib.cfg.icon]  or {}
end

local function clr()
    return jlib.cfg.themes[jlib.cfg.theme]  or {}
end

local function lan()
    return jlib.cfg.lans[jlib.cfg.lan] or {}
end

local file_data = {
	["lib-setting"] = {
		name = "lib-setting",
		check = {
			["lan"] = function(arg)
				local result = false
				if not (arg) then return false end
				if not (isstring(arg)) then return false end
				for _, v in pairs(jlib.cfg.lan_all) do
					if (v == arg) then result = true break end
				end
				return result
			end,
			["theme"] = function(arg)
				local result = false
				if not (arg) then return false end
				if not (isstring(arg)) then return false end
				for _, v in pairs(jlib.cfg.theme_ChangeList) do
					if (v == arg) then result = true break end
				end
				return result
			end,
			["sound_ui"] = function(arg)
				if not (isbool(arg)) then return false end
				return true			
			end,
			["sound_ui_volume"] = function(arg)
				if not (arg) then return false end
				if not (isnumber(arg)) then return false end
				if (arg>1) or (0>arg) then return false end
				return true
			end			
		}
	}
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Saving and uploading data |~| Сохранение и загрузка данных :--:--:--:--:--:--:--:--:--:--:--:}>         |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Uploading Settings |~| Загрузка настроек
local function failload()
	jlib.SaveData("lib-setting", jlib.cfg.clientsetting)
end

hook.Add("InitPostEntity", "jlib.lib-setting", function(ply, bool)
	local data_set = jlib.GetSaveData("lib-setting")
	if not (data_set) then
		failload()
	else
		for k, v in pairs(file_data["lib-setting"].check) do
			if not (data_set[k]) then
				failload() return
			end
			if not (v(data_set[k])) then
				failload() return 
			end
		end
		jlib.UpdateConfig(data_set)
	end

	MsgC(Color(100, 200, 255), "[jlib] ", Color(255, 255, 255), lan()["jlib-download"], "!\n")		
end)

--------------------------------------------------------------------------------------------------------------|>
--[+] Creating screenshots for drag |~| Создание скринов для drag :--:--:--:--:--:--:--:--:--:--:--:}>        |>
--------------------------------------------------------------------------------------------------------------|>
local path_drag = "jlib/drag/"

hook.Add("PostRender", "jlib.drag", function()
    if not (jlib.vgui.drag_ready) then return end
    jlib.vgui.drag_ready = false
    local data = jlib.vgui.drag_size
    local size_x, size_y, pos_x, pos_y = data[1], data[2], data[3], data[4]

    local photo  = render.Capture( {
        format = "png",
        x = pos_x,
        y = pos_y,
        w = size_x,
        h = size_y,
        alpha = false
    }) 

    file.CreateDir("jlib/drag")
    file.Write(path_drag .. tostring(pos_x) .. tostring(pos_y) .. ".png", photo)
    jlib.vgui.drag_image = path_drag .. tostring(pos_x) .. tostring(pos_y) .. ".png"
end)

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 