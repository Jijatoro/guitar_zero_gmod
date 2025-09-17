----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>

----------------------------------------------------------------------------------------------|>
--[+] Прогрузка json :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
----------------------------------------------------------------------------------------------|>
hook.Add("InitPostEntity", "Guitar_Hero.Ready", function()
	timer.Simple(3, function()
		Guitar_Hero.LoadJson()
	end)
end)

----------------------------------------------------------------------------------------------|>
--[+] Игрок умер :--:--:--:--:--:--:--:--:--:--:--:}>                                         |>
----------------------------------------------------------------------------------------------|>
hook.Add("PlayerDeath", "Guitar_Hero.Death", function(ply, reason, killer)
	if (ply.GH_Play) then
		timer.Remove("GuitarHero.EndPlay." .. ply:SteamID())
			timer.Remove("GuitarHero.TickHero." .. ply:SteamID())
		ply.GH_Play = false
		Guitar_Hero.SetAnim(ply, nil, "stop", nil, nil)
	end
end)

----------------------------------------------------------------------------------------------|>
--[+] Игрок вышел :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
----------------------------------------------------------------------------------------------|>
hook.Add("PlayerDisconnected", "Guitar_Hero.Disconnect", function(ply)
	if (ply.GH_Play) then
		timer.Remove("GuitarHero.EndPlay." .. ply:SteamID())
		timer.Remove("GuitarHero.TickHero." .. ply:SteamID())
		ply.GH_Play = false
	end
end)

----------------------------------------------------------------------------------------------|>
--[+] Игрок закончил играть :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
----------------------------------------------------------------------------------------------|>
hook.Add("Guitar_Hero.EndPlay", "Guitar_Hero.End", function(ply, music, type, reason, counter)
	ply.GH_Play = false
	if not (ply:Alive()) then return end

	if (reason == "fail") then
		Guitar_Hero.SetAnim(ply, "hero_guitar.play_fail", "base", 0, nil)
		return
	end
	if (reason == "won") then
		Guitar_Hero.SetAnim(ply, "hero_guitar.play_won", "base", 0, nil)
		return
	end	
end)

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   