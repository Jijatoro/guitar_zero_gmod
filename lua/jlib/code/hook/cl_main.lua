--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib.vgui) then jlib.vgui = {} end
jlib.vgui.drag_ready, jlib.vgui.drag_image, jlib.vgui.drag_size = false, nil, {}
local check_save = {
	["lan"] = function(arg)
		local result = false
		if not (arg) then return false end
		if not (isstring(arg)) then return false end
		local all_lan = {} 
		for k, _ in pairs(jlib.cfg.lans) do 
			table.insert(all_lan, k) 
		end
		for _, v in pairs(all_lan) do
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
		if (arg>1.1) or (-0.1>arg) then return false end
		return true
	end,
	["music_volume"] = function(arg)
		if not (arg) then return false end
		if not (isnumber(arg)) then return false end
		if (arg>5.1) or (-0.1>arg) then return false end
		return true
	end		
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Saving and uploading data  :--:--:--:--:--:--:--:--:--:--:--:}>                                         |>
--------------------------------------------------------------------------------------------------------------|>
local function failload()
	jlib.SaveData(jlib.cfg.clientsetting)
end

hook.Add("InitPostEntity", "jlib.lib-setting", function(ply, bool)
	local setting = jlib.GetSaveData()
	if not (setting) then
		failload() return
	else
		for k, v in pairs(check_save) do
			if not (setting[k]) or not (v(setting[k])) then
				failload() return
			end
		end
		jlib.UpdateConfig(setting)
	end	
end)

--------------------------------------------------------------------------------------------------------------|>
--[+] Creating screenshots for drag :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
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