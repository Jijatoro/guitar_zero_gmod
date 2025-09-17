----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные или функции :--:--:--:--:--:--:--:--:--:--:--:}>                        |>
----------------------------------------------------------------------------------------------|>
util.AddNetworkString("GuitarHero.Play")
util.AddNetworkString("GuitarHero.Anim")

local midi_min, midi_max = 40, 94
local data_ply = {
	ply = function(val, sen)
		if (val != sen) then return false end
		return true
	end,
	type = function(val, sen)
		if not (isstring(val)) then return false end
		if (string.len(val) > 60) then return false end
		if not (Guitar_Hero.Modes[val]) then return false end
		return true
	end,
	keys = function(val, sen)
		if (val != nil) and not (istable(val)) then return false end
		if (val == nil) then return true end
		for _, key in ipairs(val) do
			if not (isnumber(key)) then return false end
			if (midi_min <= key) and (midi_max <= key) then
				return false 
			end
		end
		return true	
	end,
	music = function(val, sen)
		if not (isstring(val)) then return false end
		if (string.len(val) > 100) then return false end
		return true
	end	

}
local function ValidData(data, sen)
	for k, v in pairs(data) do
		if not (data_ply[k]) then return false end
		if (data_ply[k](v, sen)) then return false end
	end
	return true 
end

----------------------------------------------------------------------------------------------|>
--[+] Игрок хочет сыграть :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
----------------------------------------------------------------------------------------------|>
net.Receive("GuitarHero.Play", function(len, sender)
	local data = net.ReadTable()
	ValidData(data, sender)

	if not (data.type) or not (Guitar_Hero.Modes[data.type]) then return end
	if (data.type == "fail") then
		Guitar_Hero.StopPlay(sender, "hero", "fail")
		return
	end
	if (data.type == "won") and (data.keys != "hero_r") then
		Guitar_Hero.StopPlay(sender, "hero", "won")
		return
	end
	if (data.type == "won") and (data.keys == "hero_r") then
		Guitar_Hero.ValidResultHero(sender, data.music or 0, data.type or "fail")
		return
	end	

	if (sender.GH_Play) then return end
	if not (Guitar_Hero.JsonData[data.music .. ".json"]) then return end
	Guitar_Hero.Play(sender, data.type or "nil", data.music or "nil")
end)

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   