----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные и функции :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
----------------------------------------------------------------------------------------------|>
local alpha = 0
local long = 700
local width = 400
local anim_speed = 4
local line_spacing = 200
local long_line = 17
local pos_bar = long-130
local date_note = {}
local background

--[*] Счётчик
local counter_text
local counter = 0
local sum = 1
local fail = 0
local fail_need = 15

--[*] Ноты
local current_music
local delay_to_target = 2
local current_note = 0
local midi_min, midi_max = 40, 94
local interval_note = 90
local white_button = {}

local adjustmoves = {
	[1] = {
		object = nil,
		size = {x = width, y = long},
		pos = {x = 0, y = 0},
		reset_pos = {x = 0, y = -long},
		mat = ""
	},
	[2] = {
		object = nil,
		size = {x = width, y = long},
		pos = {x = 0, y = -long},
		reset_pos = {x = 0, y = -long},
		mat = ""
	},
	[3] = {
		object = nil,
		size = {x = width, y = long_line},
        pos = {x = 0, y = -long_line-line_spacing},
        reset_pos = {x = 0, y = -long_line},
		mat = "merry_world/swep/hero_guitar/ui/body/line.png"
	},
	[4] = {
		object = nil,
		size = {x = width, y = long_line},
        pos = {x = 0, y = -long_line-(line_spacing*2)},
        reset_pos = {x = 0, y = -long_line},
		mat = "merry_world/swep/hero_guitar/ui/body/line.png"
	},
	[5] = {
		object = nil,
		size = {x = width, y = long_line},
		pos = {x = 0, y = -long_line-(line_spacing*3)},
		reset_pos = {x = 0, y = -long_line},
		mat = "merry_world/swep/hero_guitar/ui/body/line.png"
	}
}

local first_string = 38
local all_strings = {
	[1] = {
		pos = {x = first_string, y = -95}
	},
	[2] = {
		pos = {x = first_string*3+2, y = -95}
	},
	[3] = {
		pos = {x = first_string*5+7, y = -95}
	},
	[4] = {
		pos = {x = first_string*7+10, y = -95}
	},
	[5] = {
		pos = {x = first_string*9+13, y = -95}
	}
}

local type_note = {
	[1] = {
		color = Color(44,201,74),
		pos = {x = all_strings[1].pos.x-21, y = 0},
		btn = nil,
		midi = {min = 40, max = 50},
		status = false
	},
	[2] = {
		color = Color(245,48,62),
		pos = {x = all_strings[2].pos.x-21, y = 0},
		btn = nil,
		midi = {min = 51, max = 61},
		status = false
	},
	[3] = {
		color = Color(249,225,2),
		pos = {x = all_strings[3].pos.x-21, y = 0},
		btn = nil,
		midi = {min = 62, max = 72},
		status = false
	},
	[4] = {
		color = Color(112,173,251),
		pos = {x = all_strings[4].pos.x-21, y = 0},
		btn = nil,
		midi = {min = 73, max = 83},
		status = false
	},
	[5] = {
		color = Color(249,106,24),
		pos = {x = all_strings[5].pos.x-21, y = 0},
		btn = nil,
		midi = {min = 84, max = 94},
		status = false
	}
}

--[*] Прорисовка всех элементов
local function DrawElements(parent)
	parent:SetAlpha(0)
	alpha = 0

	timer.Create("MerryUI.Alpha", 0.01, 0, function()
		if (alpha >= 255) then alpha = 255 timer.Remove("MerryUI.Alpha") return end
		if not (IsValid(parent)) then alpha = 255 timer.Remove("MerryUI.Alpha") return end
		
		parent:SetAlpha(alpha)
		alpha = alpha + 5
	end)	
end

----------------------------------------------------------------------------------------------|>
--[+] Анимация кнопок :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
local function SetAnimButton(btn, bool)
	local anim
	if (bool) then
		anim = "anim_up_idle"
		btn.gh_status = true
	else
		anim = "anim_idle"
		btn.gh_status = false
	end

	local anim = btn:GetEntity():LookupSequence(anim)
	btn:GetEntity():SetSequence(anim)
end

----------------------------------------------------------------------------------------------|>
--[+] Анимация элементов :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
local function AnimElements(parent)
	timer.Create("Merry.HG.AnimElements", 0.01, 0, function()
		if not (IsValid(parent)) then timer.Remove("Merry.HG.AnimElements") return end
		
		for _, v in ipairs(adjustmoves) do
			if not (IsValid(v.object)) then continue end
			local pos_x, pos_y = v.object:GetPos()
			local new_y = pos_y + anim_speed

			if (pos_y >= long) then 
				v.object:SetPos(v.reset_pos.x, v.reset_pos.y)
			else
				v.object:SetPos(pos_x, new_y)
			end
		end

		for _, n in pairs(date_note) do
			if not (IsValid(n)) then continue end
			local pos_x, pos_y = n:GetPos()
			local new_y = pos_y + anim_speed

			if (new_y >= long) then
				n:Remove()
				fail = fail + 1
			else
				n:SetPos(pos_x, new_y)
				if (type_note[n.n_type].status) and not (n.ready) and (new_y > interval_note) then
					n.ready = true
					type_note[n.n_type].status = false
				end				
			end		
		end

		if (fail >= fail_need) then hook.Run("Guitar_Hero.EndPlay", LocalPlayer(), "hero", "fail") end
	end)
end

----------------------------------------------------------------------------------------------|>
--[+] Создание нот :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
----------------------------------------------------------------------------------------------|>
local function CreateNote(type)
	if not (IsValid(background)) then return end
	local note = vgui.Create("MerryUI.Panel", background)
	MerryUI.Panel(note, false, false, "base", nil, 50, 50, nil, nil, nil, nil, nil, nil)
	note:SetPos(type_note[type].pos.x, type_note[type].pos.y)
	note.n_type = type
	note.ready = false
	table.insert(date_note, note)

	note.Paint = function(self, w, h)
		local pos_x, pos_y = self:GetPos()
		if not (pos_y >= pos_bar+60) then
        	draw.RoundedBox(64, 3, 3, w-6, h-6, type_note[type].color)
        else
        	draw.RoundedBox(64, 3, 3, w-6, h-6, Color(54, 54, 54))
        end	
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Определяем тип кнопки :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
----------------------------------------------------------------------------------------------|>
local function GetTypeNote(mide)
	for id, val in ipairs(type_note) do
		if (val.midi.min <= mide) and (mide <= val.midi.max) then
			return id
		end
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Проверка на попадение :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
----------------------------------------------------------------------------------------------|>
local function CheckNote(type)
	for _, b in pairs(date_note) do
		if (b.n_type == type) then
			local pos_x, pos_y = b:GetPos()
			if (pos_y >= pos_bar-40) and (pos_y < pos_bar+80) then
				SetAnimButton(type_note[type].btn, true)
				b:Remove()
				counter = counter + sum
				counter_text:SetText(tostring(counter))
				fail = 0
				timer.Create("HG.BthReturn." .. tostring(type), 1, 1, function()
					if not (IsValid(type_note[type].btn)) then return end
					SetAnimButton(type_note[type].btn, false)
				end)
				return true
			end
		end
	end
	return false
end

----------------------------------------------------------------------------------------------|>
--[+] Генерация нот :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
----------------------------------------------------------------------------------------------|>
local function GeneralNote(reward, my_tick)
	if not (Guitar_Hero.JsonData[current_music]) then return end
	local duration = SoundDuration("zero_guitar/music/" .. string.sub(current_music, 1, string.len(current_music)-5) .. ".mp3") or nil
	if not (duration) then return end

	local data = Guitar_Hero.JsonData[current_music]["tracks"][1]["notes"]
	current_note = 1

	local time = 0
	local lastThink = SysTime()

	hook.Add("Think", "HG.CreateNote", function()
		if not (data[current_note+1]) then hook.Remove("Think", "HG.CreateNote") return end

	    local currentTime = SysTime()
	    local delta = currentTime - lastThink
	    lastThink = currentTime
	    time = time + delta

	    if (time >= data[current_note+1]["time"]) then
	    	if (midi_min <= data[current_note+1]["midi"]) and (midi_max >= data[current_note+1]["midi"]) then
	    		local n_type = GetTypeNote(data[current_note+1]["midi"])
	    		if not (type_note[n_type].status) then 
	    			CreateNote(n_type)
	    			type_note[n_type].status = true
	    		end
	    	end
	    	current_note = current_note + 1
	    end
	end)

	if (reward) then
		timer.Create("Guitar_Hero.TickS", duration-my_tick, 1, function()
			Guitar_Hero.PlayNet("won", "hero_r", counter)
			hook.Run("Guitar_Hero.EndPlay", LocalPlayer(), "hero_r", "won", counter)
		end)
	else
		timer.Create("Guitar_Hero.TimeEndPlay", duration+delay_to_target, 1, function()
			hook.Run("Guitar_Hero.EndPlay", LocalPlayer(), "hero", "won", counter)
		end)
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Меню игры :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.UI_Play(name, reward, my_tick)
	if not (Guitar_Hero.JsonData[name]) then return end
	current_music = name

	--[*] Тех. параметры
	local my_setting = Guitar_Hero.MySetting["setting"]
	local text = Guitar_Hero.Languages[my_setting["language"]]	
	for _, v in pairs(type_note) do v.status = false end
	counter = 0
	fail = 0
	white_button = {}
	for k, v in pairs(my_setting["binds"]) do
		white_button[v] = k
	end

	--[*] Само меню
	Guitar_Hero.Panel_Play = vgui.Create("MerryUI.Panel")
	MerryUI.Panel(Guitar_Hero.Panel_Play, false, true, "base", nil, width, long, nil, nil, nil, nil, nil, false)
	Guitar_Hero.Panel_Play:CenterVertical(0.68)
	Guitar_Hero.Panel_Play.OnRemove = function(self)
		timer.Remove("Merry.HG.AnimElements")
		hook.Remove("Think", "HG.CreateNote")
		timer.Remove("Guitar_Hero.TimeEndPlay")
		timer.Remove("Guitar_Hero.TickS")
	end

	--[*] Доп. для тех. части
	background = vgui.Create("MerryUI.Panel", Guitar_Hero.Panel_Play)
	MerryUI.Panel(background, false, false, "none", nil, width, long, FILL, 0, 0, 0, 0, false)	

	--[*] Рандомим скин
	local mat_skin = "merry_world/swep/hero_guitar/ui/skin/" .. tostring(math.random(1, 8)) .. ".png"
	adjustmoves[1].mat = mat_skin
	adjustmoves[2].mat = mat_skin

	--[*] Стандартные элементы движения
	for _, v in ipairs(adjustmoves) do
		v.object = vgui.Create("MerryUI.Panel", Guitar_Hero.Panel_Play)
		MerryUI.Panel(v.object, false, false, "base", v.mat, v.size.x, v.size.y, nil, nil, nil, nil, nil, nil)
		v.object:SetPos(v.pos.x, v.pos.y)
		v.object.Paint = function(self, w, h)
            surface.SetMaterial(Material(self:GetValue(), "noclamp smooth"))
            surface.SetDrawColor(Color(255, 255, 255))
            surface.DrawTexturedRect(3, 0, w-6, h)
		end
	end

	--[*] Струны
	for _, s in pairs(all_strings) do
		local strings_line = vgui.Create("MerryUI.Panel", Guitar_Hero.Panel_Play)
		MerryUI.Panel(strings_line, false, false, "base", "merry_world/swep/hero_guitar/ui/body/line.png", 10, long, nil, nil, nil, nil, nil, nil)
		strings_line:SetPos(s.pos.x, s.pos.y)	
	end

	--[*] Панель с кнопками
	local panel_btn = vgui.Create("MerryUI.Panel", Guitar_Hero.Panel_Play)
	MerryUI.Panel(panel_btn, false, false, "none", nil, width, 72, nil, nil, nil, nil, nil, false)
	panel_btn:SetPos(0, pos_bar)

	--[*] Кнопки
	for i = 1, 5 do 
		local pnl_btn = vgui.Create("MerryUI.Panel", panel_btn)
		MerryUI.Panel(pnl_btn, false, false, "none", nil, 74, 70, LEFT, 5, 2, 0, 2, false)

		local button = vgui.Create("DModelPanel", pnl_btn)
		button:SetModel("models/merry_world/swep/hero_guitar_view/button.mdl")
		button:SetPos(7, 1)
		button:SetSize(60, 60)
	    button.LayoutEntity = function() return end
	    button:SetMouseInputEnabled(false)
	    button.Entity:SetSkin(i-1)

		timer.Simple(0.1, function()
		    if not IsValid(button) or not IsValid(button.Entity) then return end
		    local min, max = button.Entity:GetRenderBounds()
		    local size = max - min

		    button:SetCamPos(Vector(size.x * 2, size.y * 2, size.z * 3))
		    button:SetLookAt(Vector(0, 0, size.z * 0.8))
		    button:SetFOV(22)
		end)

		button:SetAnimated(true)
		button.gh_status = false
		SetAnimButton(button, false)
		type_note[i].btn = button
	end

	AnimElements(Guitar_Hero.Panel_Play)
	DrawElements(Guitar_Hero.Panel_Play)
	GeneralNote(reward, my_tick)

	--[*] Счётчик
	counter_text = vgui.Create("MerryUI.Label", Guitar_Hero.Panel_Play)
	MerryUI.Label(counter_text, tostring(counter), "head", 400, 90, 5, nil, nil, nil, nil, nil)
	counter_text:SetPos(0, long-80)
end

--[*] Отслежка нажатия
local key_status = {}
hook.Add("Think", "GuitarHero.InputCheck", function()
	if not (IsValid(Guitar_Hero.Panel_Play)) then return end
    for id, key in pairs(white_button) do
    	local isDown = input.IsKeyDown(id)
        if (isDown) and not (key_status[id]) then
        	key_status[id] = true
        	CheckNote(key)
        elseif not (isDown) and (key_status[id]) then
        	key_status[id] = false
        end
    end
end)

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   
--