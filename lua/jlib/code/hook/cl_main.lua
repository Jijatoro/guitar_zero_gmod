--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib.vgui) then jlib.vgui = {} end
local function j() return jlib end
local function c() return j()["cfg"] end
local function jv() return j()["vgui"] end
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
--[+] The player entered the world :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
--------------------------------------------------------------------------------------------------------------|>
local function failload()
	jlib.SaveData(jlib.cfg.clientsetting)
end

hook.Add("InitPostEntity", "jlib.lib-setting", function(ply, bool)
	local jv = jv()
	--[*] we check for the presence of saved data
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

	--[*] we select fonts for the current screen extension
	jv.AdjustFont(ScrW(), ScrH())
end)

--[*] just in case
timer.Create("jlib.ModCheck", 5, 1, function()
	local jv = jv()
	if not (jv["current_fkey"]) then 
		jv.AdjustFont(ScrW(), ScrH())
	end
end)

--------------------------------------------------------------------------------------------------------------|>
--[+] The client changed the screen extension :--:--:--:--:--:--:--:--:--:--:--:}>                            |>
--------------------------------------------------------------------------------------------------------------|>
hook.Add("OnScreenSizeChanged", "jlib.screenchanged", function(old_w, old_h, new_w, new_h)
	local jv = jv()
	jv.AdjustFont(new_w, new_h)
end)

--------------------------------------------------------------------------------------------------------------|>
--[+] The client closed the ui menu :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
--------------------------------------------------------------------------------------------------------------|>
hook.Add("jLib.CloseUI", "jlib.cleardata", function()
	local jv = jv()
	
	--[*] clearing deleted font items
	local max_element = #jv["current_felements"]
	if (max_element > 0) then
		for i = max_element, 1, -1 do
			local pnl = jv["current_felements"][i]["element"]
			if not (IsValid(pnl)) then
				table.remove(jv["current_felements"], i)
			end
		end
	end


	--[*] clearing deleted scrolls
	local max_scrolls = #jv["current_scrolls"]
	if (max_scrolls > 0) then
		for i = max_scrolls, 1, -1 do
			if not (IsValid(jv["current_scrolls"][i])) then
				table.remove(jv["current_scrolls"], i)
			end
		end
	end	

	jv["selector"] = false
end)

--------------------------------------------------------------------------------------------------------------|>
--[+] Creating screenshots for drag :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
--------------------------------------------------------------------------------------------------------------|>
local path_drag = "jlib/drag/"
hook.Add("PostRender", "jlib.drag", function()
	local jv = jv()
    if not (jv.drag_ready) then return end
    jv.drag_ready = false
    local data = jv.drag_size
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
    jv.drag_image = path_drag .. tostring(pos_x) .. tostring(pos_y) .. ".png"
end)

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 