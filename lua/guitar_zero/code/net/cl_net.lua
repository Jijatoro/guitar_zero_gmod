----------------------------------------------------------------------------------------------|>
--[+] Сервер связывается с нами :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
----------------------------------------------------------------------------------------------|>
net.Receive("GuitarHero.Play", function()
	local data = net.ReadTable()
	if not (data) then return end
	if (data == nil) then return end

	if (data.type == "hero") then
		Guitar_Hero.UI_Play(data.music .. ".json", false, nil)
		return
	end

	if (data.type == "hero_result") then
		Guitar_Hero.UI_Play(data.music .. ".json", true, data.my_tick)
		return
	end
end)

net.Receive("GuitarHero.Anim", function()
	local data = net.ReadTable()
	if not (data) then return end
	if (data == nil) then return end
	local ply = data.ply
	if not (IsValid(ply)) then return end
	local steamid = ply:SteamID()
	local swep = data.swep

	if (data.type == "stop") then
		timer.Remove("GuitarHero.AnimNote." .. steamid)
		return
	end
	if (data.type == "note") then
		timer.Create("GuitarHero.AnimNote." .. steamid, 1, data.duration, function()
			if not (IsValid(swep)) or not (IsValid(ply)) then timer.Remove("GuitarHero.AnimNote." .. steamid) return end
			local count = math.random(1, 5)	
			local anim = ply:LookupSequence("hero_guitar.play_note_" .. tostring(count))
			local duration = ply:SequenceDuration(anim)
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, anim, 0, true) 
		end)
		return
	end

	local anim = ply:LookupSequence(data.act)
	local duration = ply:SequenceDuration(anim)
	ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, anim, 0, true) 
end)

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   