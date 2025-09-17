----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные и функции :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
----------------------------------------------------------------------------------------------|>
local alpha = 0
local language_sel, theme_sel, sound_ui, btn_ready
local guitar

--[*] Блэк лист
local function blacklist(ply, music)
	local list_m = Guitar_Hero.Config["List_Music"]
	if not (list_m) or (table.IsEmpty(list_m)) then return true end
	if (list_m[music]) and not (list_m[music].CanUse(ply)) then return false
	else return true end
end

--[*] Белый лист
local function whitelist(ply, music)
	local list_m = Guitar_Hero.Config["List_Music"]
	if not (list_m) or (table.IsEmpty(list_m)) then return false end
	if (list_m[music]) and (list_m[music].CanUse(ply)) then return true
	else return false end
end

--[*] Затычка
local function closeready(p1, p2)
	p1:Remove()
	p2:Remove()
end

--[*] Отладка
local function Debug(panel)
	panel:Remove()

	timer.Simple(0.2, function()
		Guitar_Hero.UI_Menu()
	end)
end

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

--[*] Звук при наводке
local function HoverSound(self, sound)
	if (self:IsHovered()) then
		if (self.CanSound) then
			self.CanSound = false
			Guitar_Hero.Sound(sound, "ui")
		end
	else
		self.CanSound = true
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Контент настроек :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
local function SettingContent(pnl_setting, my_setting, text, type)
	--[*] Выбор языка
	local all_languages = {}
	for key, _ in pairs(Guitar_Hero.Languages) do
		table.insert(all_languages, key)
	end

	language_sel = vgui.Create("MerryUI.SelectorText", pnl_setting)
	MerryUI.Selector(language_sel, nil, text["Язык"], my_setting["language"], all_languages, true, TOP, 75, 0, 75, 0)
	language_sel:SetPosX(-23)

	--[*] Выбор темы
	if (Merry.CanTheme) then
		local all_themes = {}
		for key, _ in pairs(Merry.Themes) do
			table.insert(all_themes, key)
		end

		theme_sel = vgui.Create("MerryUI.SelectorText", pnl_setting)
		MerryUI.Selector(theme_sel, nil, text["Тема"], Merry.Theme, all_themes, true, TOP, 75, 0, 75, 0)
		theme_sel:SetPosX(-23)
	end

	--[*] Выбор мода
	local all_modes = {}
	for key, _ in pairs(Guitar_Hero.Modes) do
		table.insert(all_modes, key)
	end

	mode_sel = vgui.Create("MerryUI.SelectorText", pnl_setting)
	MerryUI.Selector(mode_sel, nil, text["Мод"], my_setting["mode"], all_modes, true, TOP, 75, 0, 75, 0)
	mode_sel:SetPosX(-23)

	--[*] Громкость UI
	local sound_date = my_setting["sound_ui"]
	if (sound_date == 1.0) then 
		sound_date = 100
	else 
		if (sound_date != 0) then sound_date = sound_date*100 end
	end

	sound_ui = vgui.Create("MerryUI.SliderText", pnl_setting)
	MerryUI.Slider(sound_ui, text["Громкость звуков"], 0, 100, sound_date, TOP, 85, 15, 75, 3)
	sound_ui.slider.OnValueChanged = function(self, value) 
		LocalPlayer():EmitSound(Sound("merry_world/ui/cancel.mp3"), 75, 100, value/100, CHAN_AUTO)
	end

	--[*] Готово
	btn_ready = vgui.Create("MerryUI.Button", pnl_setting)
	MerryUI.Button(btn_ready, text["Изменить"], true, nil, TOP, 190, 30, 190, 0)
	btn_ready.DoClick = function()
		Guitar_Hero.MySetting["setting"]["language"] = language_sel:GetValue()
		Guitar_Hero.MySetting["setting"]["mode"] = mode_sel:GetValue()
		if (Merry.CanTheme) then Guitar_Hero.MySetting["setting"]["theme"] = theme_sel:GetValue() end
		Guitar_Hero.MySetting["setting"]["first"] = false
		local sound_date = sound_ui:GetValue()
		if (sound_date == 100) then 
			sound_date = 1.0 
		else 
			if (sound_date != 0) then sound_date = sound_date/100 end
		end
		Guitar_Hero.MySetting["setting"]["sound_ui"] = sound_date
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])

		if (form == "menu") then
			Debug(frame)
		else
			pnl_setting:GetParent():Close()
			timer.Simple(0.1, function ()
				Guitar_Hero.UI_Start()
			end)
		end

		Guitar_Hero.Sound("save", "ui")
	end

	btn_ready.Think = function(self)
		HoverSound(self, "cursor")
	end	

	--[*] Прорисовка всех элементов
	DrawElements(pnl_setting:GetParent())
end

----------------------------------------------------------------------------------------------|>
--[+] Контент биндов :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
----------------------------------------------------------------------------------------------|>
local function BindsContent(pnl_binds, my_setting, text, type)
	local data = my_setting["binds"]
	local data_keys = {}

	--[*] Горячие клавиши
	for i = 1, 5 do
		local key = vgui.Create("MerryUI.Key", pnl_binds)
		MerryUI.Key(key, data[i], text["Клавиша"] .. " " .. tostring(i), TOP, 100, 15, 100, 3)
		data_keys[i] = key
	end

	--[*] Готово
	btn_ready = vgui.Create("MerryUI.Button", pnl_binds)
	MerryUI.Button(btn_ready, text["Изменить"], true, nil, TOP, 190, 30, 190, 0)
	btn_ready.DoClick = function()
		local new_button = {}
		for id, key in ipairs(data_keys) do
			new_button[id] = key:GetValue()
		end

		Guitar_Hero.MySetting["setting"]["binds"] = new_button
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])

		if (form == "menu") then
			Debug(frame)
		else
			pnl_binds:GetParent():Close()
			timer.Simple(0.1, function ()
				Guitar_Hero.UI_Start()
			end)
		end

		Guitar_Hero.Sound("save", "ui")
	end

	btn_ready.Think = function(self)
		HoverSound(self, "cursor")
	end	

	--[*] Прорисовка всех элементов
	DrawElements(pnl_binds:GetParent())
end

----------------------------------------------------------------------------------------------|>
--[+] Окно подтверждения :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
local function UI_Submit(parent, music, text, my_setting)
	--[*] Меню
	local frame = vgui.Create("MerryUI.Panel")
	MerryUI.Panel(frame, false, true, "round", nil, 700, 500, nil, nil, nil, nil, nil, true)
	frame.OnRemove = function(self)
		if (IsValid(parent)) then 
			parent:SetVisible(true)
			DrawElements(parent)
		end
	end

	local d_name = ""
	local d_author = ""
	local complexity = 1
	local d_music = Guitar_Hero.DataMusic[music] or nil

	if (d_music) then
		d_name = d_music.name
		d_author = d_music.author
		d_complexity = d_music.complexity		
	end

	--[*] Описание музыки
	local name = vgui.Create("MerryUI.Label", frame)
	MerryUI.Label(name, d_name or "", "head", 150, 40, 5, TOP, 25, 55, 25, 0)	

	local author = vgui.Create("MerryUI.Label", frame)
	MerryUI.Label(author, d_author or "", "p1", 150, 40, 5, TOP, 25, 5, 25, 0)

	local time = tostring(math.Round(SoundDuration("zero_guitar/music/" .. music))) or ""
	local duration = vgui.Create("MerryUI.Label", frame)
	MerryUI.Label(duration, time .. " " .. text["секунд"], "p1", 150, 40, 5, TOP, 25, 5, 25, 0)		

	local panel_star = vgui.Create("MerryUI.Panel", frame)
	MerryUI.Panel(panel_star, false, false, "round", nil, 700, 60, TOP, 185, 15, 185, 0, false)

	local complexity = math.min(5, d_complexity or 1)
	local amout = math.max(1, complexity)
	for i = 1, 5 do
		local pos_x = 5
		if (i == 1) then pos_x = 20 end
		local star = vgui.Create("MerryUI.ButtonIcon", panel_star)
		MerryUI.ButtonIcon(star, Merry.Mat["star"], 50, 50, LEFT, pos_x, 5, 5, 5)
		star:SetMouseInputEnabled(false)
		star:SetCursor("arrow")		
		
		if (i <= amout) then star:SetStatus(true) end
	end	

	--[*] Ну, пошла Родная... (или нет?)
	local btn_play = vgui.Create("MerryUI.Button", frame)
	MerryUI.Button(btn_play, text["Играть"], true, nil, TOP, 235, 25, 235, 0)
	btn_play.DoClick = function()
		local music = string.sub(music, 1, string.len(music)-4)
		local cfg = Guitar_Hero.Config

		if (cfg["Black_List"] == 1) and not (blacklist(ply, music)) then 
			local need
			if not (Guitar_Hero.Config["List_Music"][music]) then need = text["Неизвестно"]
			elseif not (Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer())) then need = text["Неизвестно"] return
			else need = Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer()) end

			closeready(frame, parent)
			Guitar_Hero.Sound("buzzer", "ui")
			chat.AddText(Color(54, 54, 54), text["Чёрный список"], Color(170, 240, 112), text["Нужно: "], Color(249, 237, 205), need)
			return 
		end
		if (cfg["Black_List"] == 2) and not (whitelist(ply, music)) then 
			local need
			if not (Guitar_Hero.Config["List_Music"][music]) then need = text["Неизвестно"]
			elseif not (Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer())) then need = text["Неизвестно"] return
			else need = Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer()) end

			closeready(frame, parent)
			Guitar_Hero.Sound("buzzer", "ui")
			chat.AddText(Color(230, 230, 230), text["Белый список"], Color(170, 240, 112), text["Нужно: "], Color(249, 237, 205), need)
			return 
		end

		if (LocalPlayer():GetActiveWeapon():GetClass() != "guitar_zero") then
			closeready(parent, frame)
			Guitar_Hero.Sound("buzzer", "ui")
			return
		end

		if (Guitar_Hero.JsonReady) then
			closeready(frame, parent)
			Guitar_Hero.Sound("super_smash_impact", "ui")

			if (my_setting["mode"] == "hero") then
				Guitar_Hero.PlayNet("hero", my_setting["binds"], music)
			elseif (my_setting["mode"] == "classic") then
				Guitar_Hero.PlayNet("classic", nil, music)
			end
		else
			Guitar_Hero.Sound("buzzer", "ui")
		end	
	end	
	
	btn_play.Think = function(self)
		HoverSound(self, "cursor")
	end	

	parent:SetVisible(false)
	DrawElements(frame)
end

----------------------------------------------------------------------------------------------|>
--[+] Начальное разовое меню :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
----------------------------------------------------------------------------------------------|>
local function UI_Welcome(my_setting, text)
	--[*] Само меню
	local frame = vgui.Create("MerryUI.FrameSimple")
	MerryUI.FrameSimple(frame, "round", nil, true, 700, 730)

	local label = vgui.Create("MerryUI.Label", frame)
	MerryUI.Label(label, text["Добро пожаловать"], "head", 150, 40, 5, TOP, 25, 3, 25, 0)

	--[*] Окно с настройками
	local pnl_setting = vgui.Create("MerryUI.Scroll", frame)
	MerryUI.Scroll(pnl_setting, false, 700, 720)
	pnl_setting:SetVisible(true)
	pnl_setting:Dock(BOTTOM)
	pnl_setting:DockMargin(35, 0, 35, 0)

	--[*] Настройки
	SettingContent(pnl_setting, my_setting, text, "welcome")
end

----------------------------------------------------------------------------------------------|>
--[+] Меню гитары :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
----------------------------------------------------------------------------------------------|>
local function UI_Menu(my_setting, text)
	--[*] Тех. параметры
	local my_setting = Guitar_Hero.MySetting["setting"]

	--[*] Само меню
	local frame = vgui.Create("MerryUI.FrameSimple")
	MerryUI.FrameSimple(frame, "round", nil, true, 700, 730)

	--[*] Окно с музыкой
	local pnl_main = vgui.Create("MerryUI.Scroll", frame)
	MerryUI.Scroll(pnl_main, false, 700, 720)
	pnl_main:SetVisible(true)
	pnl_main:Dock(BOTTOM)
	pnl_main:DockMargin(20, 0, 20, 0)

	--[*] Окно с настройками
	local pnl_setting = vgui.Create("MerryUI.Scroll", frame)
	MerryUI.Scroll(pnl_setting, false, 700, 720)
	pnl_setting:Dock(BOTTOM)
	pnl_setting:DockMargin(35, 0, 35, 0)

	--[*] Окно с биндами
	local pnl_binds = vgui.Create("MerryUI.Scroll", frame)
	MerryUI.Scroll(pnl_binds, false, 700, 720)
	pnl_binds:Dock(BOTTOM)
	pnl_binds:DockMargin(35, 0, 35, 0)			

	--[*] Параметры переключения
	local page_date = {
		[1] = {
			panel = pnl_main,
			mat = Merry.Mat["sound"],
			text = "Музыка",
			left = 12,
			size = 100
		},
		[2] = {
			panel = pnl_setting,
			mat = Merry.Mat["setting"],
			text = "Настройки",
			left = 7,
			size = 100
		},
		[3] = {
			panel = pnl_binds,
			mat = Merry.Mat["cube"],
			text = "Бинды",
			left = 7,
			size = 100
		}
	}

	--[*] Выбор окна
	local page = vgui.Create("MerryUI.Chapter", frame)
	MerryUI.Chapter(page, "panel", "round", 1, page_date, nil, TOP, 255, 3, 255, 3)

	--[*] Музыка
	local music_date = file.Find("sound/zero_guitar/music/*.mp3", "GAME")
	local all_ava = file.Find("materials/zero_guitar/music/*.png", "GAME")

	for _, music in pairs(music_date) do
		local pnl_mus = vgui.Create("MerryUI.Panel", pnl_main)
		MerryUI.Panel(pnl_mus, true, false, "round", nil, 300, 60, TOP, 15, 5, 15, 5, false)

		local ava = vgui.Create("MerryUI.Panel", pnl_mus)
		MerryUI.Panel(ava, true, false, "round", nil, 54, 54, LEFT, 7, 5, 0, 5, false)

		for _, icons in pairs(all_ava) do
			if (MerryUI.sub(music, 1, MerryUI.len(music)-4) == MerryUI.sub(icons, 1, MerryUI.len(icons)-4)) then
				ava:SetImageType("circle")
				ava:SetValue("materials/zero_guitar/music/" .. icons)
			end
		end

		local name = vgui.Create("MerryUI.Label", pnl_mus)
		MerryUI.Label(name, MerryUI.sub(music, 1, MerryUI.len(music)-4), "p1", 350, 60, 1, LEFT, 15, 0, 0, 13)
		
		local btn_started = vgui.Create("MerryUI.Button", pnl_mus)
		MerryUI.Button(btn_started, text["Начать"], true, nil, RIGHT, 0, 5, 7, 5)
		btn_started.DoClick = function()
			UI_Submit(frame, music, text, my_setting)
			Guitar_Hero.Sound("select", "ui")
		end

		btn_started.Think = function(self)
			HoverSound(self, "cursor")
		end	
	end

	--[*] Настройки
	SettingContent(pnl_setting, my_setting, text, "menu")
	--[*] Бинды
	BindsContent(pnl_binds, my_setting, text, "menu")
end

----------------------------------------------------------------------------------------------|>
--[+] Запуск UI :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.UI_Start()
	local my_setting = Guitar_Hero.MySetting["setting"]
	local text = Guitar_Hero.Languages[my_setting["language"]]

	if (my_setting["first"]) then
		UI_Welcome(my_setting, text)
	else
		UI_Menu(my_setting, text)
	end

	if not (Guitar_Hero.JsonReady) then 
		Guitar_Hero.LoadJson()
	end
end

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   
--