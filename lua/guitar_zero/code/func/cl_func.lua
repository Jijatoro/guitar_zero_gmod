----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные и функции :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
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

----------------------------------------------------------------------------------------------|>
--[+] Прогрузка Json на клиенте :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
----------------------------------------------------------------------------------------------|>
local current_progress, end_progress
local function DrawLoad()
	local w, h = ScrW(), ScrH()
	local ply = LocalPlayer()
	local my_setting = Guitar_Hero.MySetting["setting"]
	local text = Guitar_Hero.Languages[my_setting["language"]]

	local b1_w, b2_w = w*0.4, w*0.4+3
	local b1_h, b2_h = h-95, h-95+3
	local t1_w, t2_w = w*0.4+172, w*0.4+170
	local t1_h, t2_h = h-44-24, h-27

	draw.RoundedBox(32, b1_w, b1_h, 350, 90, clr()["line"])
	draw.RoundedBox(32, b2_w, b2_h, 350-6, 90-6, clr()["head"])
	draw.SimpleTextOutlined(text["Загрузка музыки"], "s1-32", t1_w, t1_h, clr()["t_head"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(54, 54, 54))
	draw.SimpleTextOutlined(tostring(current_progress) .. "/" .. tostring(end_progress), "s1-24", t2_w, t2_h, clr()["t_p1"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(54, 54, 54))
end

function Guitar_Hero.LoadJson()
	local path = "data_static/guitar_hero_music/"
	local data = file.Find(path .. "*", "GAME")

	for k, v in pairs(data) do
		if not (string.EndsWith(v, ".json")) then table.remove(data, k) end
	end

	if not (data) or (#data == 0) then return end 

	current_progress = 1
	end_progress = #data
	hook.Add("HUDPaint", "GuitarHero.LoadJson", DrawLoad)

	local delay = 0.3
	local amount = 0
	for _, v in pairs(data) do
		timer.Simple(delay, function()
			amount = amount + 1
			Guitar_Hero.JsonData[v] = util.JSONToTable(file.Read(path .. v, "GAME"))
			current_progress = current_progress + 1

			if (amount >= #data) then
				hook.Remove("HUDPaint", "GuitarHero.LoadJson")
				Guitar_Hero.JsonReady = true
			end	
		end)
		delay = delay + 0.3
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Сообщаем серверу о желании сыграть :--:--:--:--:--:--:--:--:--:--:--:}>                 |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.PlayNet(type, keys, music)
	net.Start("GuitarHero.Play")
	net.WriteTable({ply = LocalPlayer(), type = type, keys = keys, music = music})
	net.SendToServer()
end

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   
--