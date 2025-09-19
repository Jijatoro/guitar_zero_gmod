----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные и функции :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
----------------------------------------------------------------------------------------------|>
local meta = FindMetaTable("Player")

--[*] Запуск режима "hero" на клиенте
local function HeroNet(ply, type, music, tick)
	net.Start("GuitarHero.Play")
	net.WriteTable({type = type, music = music, my_tick = tick})
	net.Send(ply)
end

--[*] Проверка при чёрном списке
local function blacklist(ply, music)
	local list_m = Guitar_Hero.Config["List_Music"]
	if not (list_m) or (table.IsEmpty(list_m)) then return true end
	if (list_m[music]) and not (list_m[music].CanUse(ply)) then return false
	else return true end
end

--[*] Проверка при белом списке
local function whitelist(ply, music)
	local list_m = Guitar_Hero.Config["List_Music"]
	if not (list_m) or (table.IsEmpty(list_m)) then return false end
	if (list_m[music]) and (list_m[music].CanUse(ply)) then return true
	else return false end
end

----------------------------------------------------------------------------------------------|>
--[+] Прогрузка Json на сервере :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.LoadJson()
	local path = "data_static/guitar_hero_music/"
	local data = file.Find(path .. "*", "GAME")

	for k, v in pairs(data) do
		if not (string.EndsWith(v, ".json")) then table.remove(data, k) end
	end

	local delay = 0.3
	local amount = 0
	for _, v in pairs(data) do
		timer.Simple(delay, function()
			amount = amount + 1
			local target = util.JSONToTable(file.Read(path .. v, "GAME"))
			Guitar_Hero.JsonData[v] = #target["tracks"][1]["notes"]

			if (amount >= #data) then
				Guitar_Hero.JsonReady = true
			end		
		end)
		delay = delay + 0.3
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Анимация игрока :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.SetAnim(ply, act, type, duration, swep)
	net.Start("GuitarHero.Anim")
	net.WriteTable({ply = ply, act = act, type = type, duration = duration, swep = swep})
	net.Broadcast()
end

----------------------------------------------------------------------------------------------|>
--[+] Остановка музыки :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.StopPlay(ply, type, reason)
	timer.Remove("GuitarHero.EndPlay." .. ply:SteamID())
	timer.Remove("GuitarHero.TickHero." .. ply:SteamID())

	if (IsValid(ply)) and not (ply.GH_Bool) then
		ply.GH_Play = false
		Guitar_Hero.SetAnim(ply, nil, "stop", nil, nil)
		hook.Run("Guitar_Hero.EndPlay", ply, ply.GH_MusicName, type, reason)
	elseif not (IsValid(ply)) and not (ply.GH_Bool) then
		hook.Run("Guitar_Hero.EndPlay", ply, ply.GH_MusicName, type, "disconnected", nil)
	end

	local swep = ply:GetActiveWeapon()
	if (swep:GetClass() == "guitar_zero") then
		swep:StopSound(ply.GH_Music)
		swep:SetHoldType("hero_guitar_default")
		swep:SendWeaponAnim(ACT_VM_IDLE)
	end

	if (ply.GH_Bool) then
		hook.Run("Guitar_Hero.EndPlay", ply, ply.GH_MusicName, "hero", "won", ply.GH_Sum)
		ply.GH_Bool = false
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Проигрывание музыки :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
----------------------------------------------------------------------------------------------|>
local function PlayMusic(ply, music, time, type)
	local swep = ply:GetActiveWeapon()
	if (swep:GetClass() != "guitar_zero") then return end
	local c_sound = "zero_guitar/music/" .. music .. ".mp3"
	local duration = SoundDuration(c_sound)
	ply.GH_Play = true
	ply.GH_Music = c_sound
	ply.GH_MusicName = music

	timer.Simple(time, function()
		if not (IsValid(ply)) or not (IsValid(swep)) then timer.Remove("GuitarHero.EndPlay." .. ply:SteamID()) return end
		swep:SetHoldType("hero_guitar_play")
		swep:EmitSound(ply.GH_Music, 75, 100, 1.0, CHAN_WEAPON)
		swep:SendWeaponAnim(ACT_USE)
		Guitar_Hero.SetAnim(ply, nil, "note", duration, swep)
	end)

	timer.Create("GuitarHero.EndPlay." .. ply:SteamID(), duration-1+time, 1, function()
		Guitar_Hero.StopPlay(ply, type, "end_music")
	end)
end

----------------------------------------------------------------------------------------------|>
--[+] Проверяем результаты игрока в режиме "Hero" :--:--:--:--:--:--:--:--:--:--:--:}>        |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.ValidResultHero(ply, result, type)
	local cfg = Guitar_Hero.Config
	if (cfg["Hero"] != 1) then return end
	if not (ply.GH_Play) or not (ply.GH_Music) then return end
	local music_ply = ply.GH_MusicName .. ".json"
	if not (Guitar_Hero.JsonData[music_ply]) then return end
	local long = Guitar_Hero.JsonData[music_ply]
	if not (ply.GH_CanReward) then
		ply.GH_Bool = false
		ply.GH_Sum = 0
		return
	end

	if (result >= long) or (type == "fail") then
		ply.GH_Bool = false
		ply.GH_Sum = 0
	else
		ply.GH_Bool = true
		ply.GH_Sum = result
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Игрок хочет начать играть музыку :--:--:--:--:--:--:--:--:--:--:--:}>                   |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.Play(ply, type, music)
	local active = ply:GetActiveWeapon()
	if (active:GetClass() != "guitar_zero") then return end
	local cfg = Guitar_Hero.Config
	ply.GH_Bool = false
	ply.GH_CanReward = false

	if (cfg["Black_List"] == 1) and not (blacklist(ply, music)) then return end
	if (cfg["Black_List"] == 2) and not (whitelist(ply, music)) then return end

	if (type == "hero") then
		if (game.SinglePlayer()) or (cfg["Hero"] == 0) then 
			HeroNet(ply, type, music, nil)
			PlayMusic(ply, music, 2.1, type)
			return
		end
		if (cfg["Hero"] == 1) then
			local rand = math.random(0.1, 2.1)
			HeroNet(ply, "hero_result", music, rand)
			PlayMusic(ply, music, 2.1, type)

			local c_sound = "zero_guitar/music/" .. music .. ".mp3"
			local duration = SoundDuration(c_sound)
			timer.Create("GuitarHero.TickHero." .. ply:SteamID(), duration-rand-0.2, 1, function()
				ply.GH_CanReward = true
			end)

			return
		end	
	elseif (type == "classic") then
		PlayMusic(ply, music, 0.5, type)
	end
end

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   
--