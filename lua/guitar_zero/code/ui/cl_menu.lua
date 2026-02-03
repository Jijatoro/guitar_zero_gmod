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
    return Guitar_Hero.Languages[jlib.cfg.lan]
end

local function SaveSound()
	jlib.vgui.PlaySound("jlib/ui/main/save.mp3", nil, false)
end

local alpha = 0
local language_sel, theme_sel, sound_ui, btn_ready
local guitar
local ui_menu, ui_welcome

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
	p1:Remove() p2:Remove()
end

--[*] Отладка
local function Debug()
	if (IsValid(ui_menu)) then ui_menu:Remove() end
	if (IsValid(ui_welcome)) then ui_welcome:Remove() end
	timer.Simple(0.1, function()
		Guitar_Hero.UI_Start()
	end)
end

--[*] Окно об ошибке
local function MyError(reason)
	jlib.vgui.SetWarning(reason, "question", nil)
end

--[*] Обработчик для создания плейлиста
local function ValidPlaylist(frame, type, switches, name, playlist, my_setting, text, old_name)
	if (table.IsEmpty(switches)) then MyError(text["Вы не выбрали даже одной музыки"]) return end

	if (type == "create") then
		if (name == "") or (name == "-") then MyError(text["Такое название плейлиста недопусимо!"]) return end
		for id, _ in pairs(playlist) do
			if (id == name) then MyError(text["Такое название плейлиста уже есть!"]) return end
		end

		Guitar_Hero.MySetting["setting"]["playlist"][name] = switches
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])				
	end

	if (type == "edit") then
		if (name == "") or (name == "-") then MyError(text["Такое название плейлиста недопусимо!"]) return end
		for id, _ in pairs(playlist) do
			if (id == name) and (name != old_name) then MyError(text["Такое название плейлиста уже есть!"]) return end
		end

		Guitar_Hero.MySetting["setting"]["playlist"][name] = switches
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])				
	end	

	frame:Remove() Debug() jlib.vgui.PlaySound("jlib/ui/main/save.mp3", val, true)	
end

----------------------------------------------------------------------------------------------|>
--[+] Контент настроек :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
local function SettingContent(pnl_setting, my_setting, text)
	--[*] Выбор языка
	local all_languages = {}
	for key, _ in pairs(Guitar_Hero.Languages) do
		table.insert(all_languages, key)
	end

	local language_sel = jlib.vgui.Create("selector", pnl_setting)
	language_sel:SetValue(my_setting["language"])
	language_sel:SetData(all_languages)
	language_sel:SetText(text["Язык"])
	language_sel:Dock(TOP)
	language_sel:DockMargin(240, 30, 240, 0)

	--[*] Выбор темы
	local theme_sel = jlib.vgui.Create("selector", pnl_setting)
	theme_sel:SetValue(jlib.cfg.theme)
	theme_sel:SetData(jlib.cfg.theme_ChangeList)
	theme_sel:SetText(text["Тема"])
	theme_sel:Dock(TOP)
	theme_sel:DockMargin(240, 20, 240, 0)

	--[*] Выбор мода
	local all_modes = {}
	for key, _ in pairs(Guitar_Hero.Modes) do
		table.insert(all_modes, key)
	end

	local mode_sel = jlib.vgui.Create("selector", pnl_setting)
	mode_sel:SetValue(my_setting["mode"])
	mode_sel:SetData(all_modes)
	mode_sel:SetText(text["Мод"])
	mode_sel:Dock(TOP)
	mode_sel:DockMargin(240, 20, 240, 0)

	--[*] Громкость UI
	local sound_ui = jlib.vgui.Create("slider", pnl_setting)
	sound_ui:SetValue(my_setting["mode"])
	sound_ui:SetText(text["Громкость звуков"])
	sound_ui:SetDecimals(1) 
	sound_ui:SetMax(1)
	sound_ui:SetValue(jlib.cfg.sound_ui_volume)
	sound_ui:Dock(TOP)
	sound_ui:DockMargin(120, 20, 120, 3)	
	sound_ui.OnValueChanged = function(self, val) 
		self:SetValue(math.Round(val, 2)) jlib.vgui.PlaySound("cursor", val, true) 
	end	

	--[*] Готово
	local btn_ready = jlib.vgui.Create("button", pnl_setting)
	btn_ready:Dock(TOP)
	btn_ready:DockMargin(240, 50, 240, 0)
	btn_ready:SetText(lan()["Выбрать"])	
	btn_ready.DoClick = function()
		Guitar_Hero.MySetting["setting"]["language"] = language_sel:GetValue()
		Guitar_Hero.MySetting["setting"]["mode"] = mode_sel:GetValue()
		Guitar_Hero.MySetting["setting"]["first"] = false
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])

		local jlib_data = {}
		jlib_data["lan"] = language_sel:GetValue()
		jlib_data["sound_ui_volume"] = sound_ui:GetValue()
		jlib_data["theme"] = theme_sel:GetValue()
		jlib.SaveData(jlib_data)

		Debug() SaveSound()
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Контент биндов :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
----------------------------------------------------------------------------------------------|>
local function BindsContent(pnl_binds, my_setting, text)
	local data = my_setting["binds"]
	local data_keys = {}

	--[*] Горячие клавиши
	for i = 1, 5 do
		local key = jlib.vgui.Create("key", pnl_binds)
		key:SetText(text["Клавиша"] .. " " .. tostring(i))
		key:SetValue(data[i])
		key:Dock(TOP)
		key:DockMargin(160, 15, 0, 0)
		data_keys[i] = key
	end

	--[*] Готово
	local btn_ready = jlib.vgui.Create("button", pnl_binds)
	btn_ready:Dock(TOP)
	btn_ready:DockMargin(240, 50, 240, 0)
	btn_ready:SetText(lan()["Выбрать"])	
	btn_ready.DoClick = function()
		local new_button = {}
		for id, key in ipairs(data_keys) do
			new_button[id] = key:GetValue()
		end
		Guitar_Hero.MySetting["setting"]["binds"] = new_button
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])
		Debug() SaveSound()
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Создание плейлиста :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
local function UI_CreatePlaylist(my_setting, text, playlist, type, old_name)
	--[*] Само меню
	local frame = jlib.vgui.Create("frame")
	frame:SetText("")
	frame:SetColorAlpha(255)
	frame:SetSize(700, 730)
	frame:Center()
	frame:MakePopup()

	--[*] Название плейлиста
	local name_playlist = jlib.vgui.Create("textentry", frame)
	name_playlist:Dock(TOP)
	name_playlist:DockMargin(210, 20, 210, 0)
	name_playlist:SetPlaceholderText(text["Название плейлиста..."])
	if (type == "edit") then name_playlist:SetValue(old_name) end

	--[*] Окно с музыкой
	local pnl_main = jlib.vgui.Create("scroll", frame)
	pnl_main:SetSize(700, 655)
	pnl_main:SetVisible(true)
	pnl_main:SetType("none")
	pnl_main:Dock(FILL)
	pnl_main:DockMargin(20, 20, 20, 20)

	--[*] Музыка
	local music_date = file.Find("sound/zero_guitar/music/*.mp3", "GAME")
	local all_ava = file.Find("materials/zero_guitar/music/*.png", "GAME")
	local data_switches = {}

	for _, music in pairs(music_date) do
		local pnl_mus = jlib.vgui.Create("panel", pnl_main)
		pnl_mus:SetType("round")
		pnl_mus:SetSize(300, 60)
		pnl_mus:Dock(TOP)
		pnl_mus:DockMargin(15, 5, 15, 5)

		local ava = jlib.vgui.Create("image", pnl_mus)
		ava:SetType("base")
		ava:SetSize(54, 54)
		ava:Dock(LEFT)
		ava:DockMargin(18, 5, 0, 5)

		for _, icons in pairs(all_ava) do
			if (jlib.sub(music, 1, jlib.len(music)-4) == jlib.sub(icons, 1, jlib.len(icons)-4)) then
				ava:SetImage("materials/zero_guitar/music/" .. icons)
			end
		end

		local name = jlib.vgui.Create("label", pnl_mus)
		name:SetSize(435, 60)
		name:Dock(LEFT)
		name:DockMargin(15, 0, 0, 0)
		name:SetFont("s1-24")
		name:SetText(jlib.sub(music, 1, jlib.len(music)-4))
		
		local status = false
		if (type == "edit") then
			for k, v in pairs(playlist[old_name]) do
				if (v == music) then status = true end
			end
		end

		local switch = jlib.vgui.Create("switch", pnl_mus)
		switch:SetText("")
		switch:SetValue(status)
		switch:SetType("none")		
		switch:Dock(RIGHT)
		switch:SetSize(100, 40)
		switch:DockMargin(0, 0, 5, 5)

		data_switches[music] = switch
	end

	--[*] Создать/Изменить
	local name_ready = text["Создать"]
	if (type == "edit") then
		name_ready  =  text["Изменить"]
	end

	local btn_ready = jlib.vgui.Create("button", pnl_main)
	btn_ready:Dock(TOP)
	btn_ready:DockMargin(230, 5, 230, 0)
	btn_ready:SetText(name_ready)
	btn_ready.DoClick = function()
		local data = {}
		for k, v in pairs(data_switches) do
			if (v:GetValue()) then
				table.insert(data, k)
			end
		end
		ValidPlaylist(frame, type, data, name_playlist:GetValue(), playlist, my_setting, text, old_name)
	end	
end

----------------------------------------------------------------------------------------------|>
--[+] Контент плейлистов :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
local function PlaylistContent(pnl_playlist, my_setting, text)
	local playlist = my_setting["playlist"]
	local playlist_current = my_setting["playlist_current"]
	playlist["-"] = true

	local data_list = {}
	local size_playlist = 0
	local check_current = false
	for name, _ in pairs(playlist) do
		table.insert(data_list, name)
		size_playlist = size_playlist + 1
		if (playlist_current == name) then check_current = true end
	end
	if not (check_current) then playlist_current = "-" end
	local playlist_sel = jlib.vgui.Create("selector", pnl_playlist)
	playlist_sel:SetValue(playlist_current)
	playlist_sel:Dock(TOP)
	playlist_sel:DockMargin(200, 20, 200, 0)
	playlist_sel:SetData(data_list)
	playlist_sel:SetText(text["Выбранный плейлист"])

	--[*] Готово
	local btn_ready = jlib.vgui.Create("button", pnl_playlist)
	btn_ready:Dock(TOP)
	btn_ready:DockMargin(240, 5, 240, 0)
	btn_ready:SetText(lan()["Готово"])
	btn_ready.DoClick = function()
		Guitar_Hero.MySetting["setting"]["playlist_current"] = playlist_sel:GetValue()
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])
		Debug() SaveSound()
	end

	--[*] Ваши плейлисты
	if (size_playlist > 1) then
		local my_playlist = jlib.vgui.Create("scroll", pnl_playlist)
		my_playlist:SetSize(500, 330)
		my_playlist:Dock(TOP)
		my_playlist:SetType("round")
		my_playlist:DockMargin(35, 15, 35, 0)
		my_playlist:SetVisible(true)

		for n, v in pairs(playlist) do
			if (n == "-") then continue end
			local slot = jlib.vgui.Create("panel", my_playlist)
			slot:SetSize(500, 50)
			slot:Dock(TOP)
			slot:DockMargin(15, 8, 15, 0)
			slot:SetType("round")

			local name = jlib.vgui.Create("label", slot)
			name:SetFont("s1-24")
			name:SetSize(360, 60)
			name:SetText(n)
			name:Dock(LEFT)
			name:DockMargin(15, 0, 0, 0)
		
			--[*] Удалить
			local btn_delete = jlib.vgui.Create("button", slot)
			btn_delete:SetSize(45, 45)
			btn_delete:Dock(RIGHT)
			btn_delete:DockMargin(5, 5, 8, 5)
			btn_delete:SetImage("close")
			btn_delete.DoClick = function()
				local function delete_it()
					Guitar_Hero.MySetting["setting"]["playlist"][n] = nil
					Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])
					Debug() jlib.vgui.PlaySound("jlib/ui/main/save.mp3", val, true)				
				end 
				local accept = jlib.vgui.Create("accept")
				accept:Center()
				accept:SetFunc(delete_it)
				accept:MakePopup()
				accept:SetText(text["Вы точно хотите удалить этот плейлист?"])
				jlib.vgui.PlaySound("zero_guitar/picnic.mp3", nil, false)
			end	

			--[*] Изменить
			local btn_edit = jlib.vgui.Create("button", slot)
			btn_edit:SetSize(45, 45)
			btn_edit:Dock(RIGHT)
			btn_edit:DockMargin(0, 5, 0, 5)
			btn_edit:SetImage("edit")
			btn_edit.DoClick = function()
				UI_CreatePlaylist(my_setting, text, playlist, "edit", n)
			end
		end
	end

	--[*] Создать плейлист
	local btn_create = jlib.vgui.Create("button", pnl_playlist)
	btn_create:SetText(text["Создать новый"])
	btn_create:Dock(TOP)
	btn_create:DockMargin(170, 5, 170, 0)		
	btn_create.DoClick = function()
		UI_CreatePlaylist(my_setting, text, playlist, "create", nil)
		jlib.vgui.PlaySound("zero_guitar/picnic.mp3", nil, false)
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Окно подтверждения :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
local function UI_Submit(parent, music, text, my_setting)
	parent:SetVisible(false)
	--[*] Меню
	local frame = jlib.vgui.Create("frame")
	frame:SetSize(700, 500)
	frame:SetText("")
	frame:Center()
	frame:MakePopup()
	frame.OnRemove = function(self)
		if (IsValid(parent)) then 
			parent:SetVisible(true)
		end
	end

	local d_name = "" local d_author = "" local complexity = 1 local d_music = Guitar_Hero.DataMusic[music] or nil
	if (d_music) then d_name = d_music.name d_author = d_music.author d_complexity = d_music.complexity	end

	--[*] Описание музыки
	local name = jlib.vgui.Create("label", frame)
	name:SetSize(150, 40)
	name:Dock(TOP)
	name:DockMargin(25, 55, 25, 0)
	name:SetText(d_name)
	name:SetFont("s1-48")
	name:SetContentAlignment(5)

	local author = jlib.vgui.Create("label", frame)
	author:SetSize(150, 30)
	author:Dock(TOP)
	author:DockMargin(25, 5, 25, 0)
	author:SetText(d_author or "")
	author:SetFont("b3-24")
	author:SetContentAlignment(5)

	local time = tostring(math.Round(SoundDuration("zero_guitar/music/" .. music))) or ""
	
	local duration = jlib.vgui.Create("label", frame)
	duration:SetSize(150, 25)
	duration:Dock(TOP)
	duration:DockMargin(25, 5, 25, 0)
	duration:SetText(time .. " " .. text["секунд"])
	duration:SetFont("s3-18")
	duration:SetContentAlignment(5)

	local panel_star = jlib.vgui.Create("panel", frame)
	panel_star:SetSize(700, 60)
	panel_star:Dock(TOP)
	panel_star:DockMargin(185, 15, 185, 0)
	panel_star:SetType("round")

	local complexity = math.min(5, d_complexity or 1)
	local amout = math.max(1, complexity)
	for i = 1, 5 do
		local pos_x = 5
		if (i == 1) then pos_x = 15 end
		local star = jlib.vgui.Create("button", panel_star)
		star:Dock(LEFT)
		star:DockMargin(pos_x, 5, 5, 5)
		star:SetSize(50, 50)
		star:SetImage("star")
		star:SetMouseInputEnabled(false)
		star:SetCursor("arrow")		
		if (i <= amout) then star:SetStatus(true) end
	end	

	--[*] Ну, пошла Родная... (или нет?)
	local btn_play = jlib.vgui.Create("button", frame)
	btn_play:SetText(text["Играть"])
	btn_play:Dock(TOP)
	btn_play:DockMargin(265, 25, 265, 0)
	btn_play.DoClick = function()
		local music = string.sub(music, 1, string.len(music)-4)
		local cfg = Guitar_Hero.Config

		if (cfg["Black_List"] == 1) and not (blacklist(ply, music)) then 
			local need
			if not (Guitar_Hero.Config["List_Music"][music]) then need = text["Неизвестно"]
			elseif not (Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer())) then need = text["Неизвестно"] return
			else need = Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer()) end

			closeready(frame, parent)
			jlib.vgui.PlaySound("zero_guitar/buzzer.mp3", nil, false)
			chat.AddText(Color(54, 54, 54), text["Чёрный список"], Color(170, 240, 112), text["Нужно: "], Color(249, 237, 205), need)
			return 
		end
		if (cfg["Black_List"] == 2) and not (whitelist(ply, music)) then 
			local need
			if not (Guitar_Hero.Config["List_Music"][music]) then need = text["Неизвестно"]
			elseif not (Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer())) then need = text["Неизвестно"] return
			else need = Guitar_Hero.Config["List_Music"][music].Need(LocalPlayer()) end

			closeready(frame, parent)
			jlib.vgui.PlaySound("zero_guitar/buzzer.mp3", nil, false)
			chat.AddText(Color(230, 230, 230), text["Белый список"], Color(170, 240, 112), text["Нужно: "], Color(249, 237, 205), need)
			return 
		end

		if (LocalPlayer():GetActiveWeapon():GetClass() != "guitar_zero") then
			closeready(parent, frame) 
			jlib.vgui.PlaySound("zero_guitar/buzzer.mp3", nil, false)
			return
		end

		if (Guitar_Hero.JsonReady) then
			closeready(frame, parent) 
			jlib.vgui.PlaySound("super_smash_impact.mp3", nil, false)
			if (my_setting["mode"] == "hero") then
				Guitar_Hero.PlayNet("hero", my_setting["binds"], music)
			elseif (my_setting["mode"] == "classic") then
				Guitar_Hero.PlayNet("classic", nil, music)
			end
		else
			jlib.vgui.PlaySound("zero_guitar/buzzer.mp3", nil, false)
		end	
	end	
end

----------------------------------------------------------------------------------------------|>
--[+] Начальное разовое меню :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
----------------------------------------------------------------------------------------------|>
local function UI_Welcome(my_setting, text)
	--[*] Само меню
	ui_welcome = jlib.vgui.Create("frame")
	ui_welcome:SetSize(700, 700)
	ui_welcome:SetText(text["Добро пожаловать"])
	ui_welcome:Center()
	ui_welcome:MakePopup()

	--[*] Окно с настройками
	local pnl_setting = jlib.vgui.Create("scroll", ui_welcome)
	pnl_setting:SetSize(700, 700)
	pnl_setting:SetVisible(true)
	pnl_setting:Dock(FILL)
	pnl_setting:DockMargin(15, 15, 15, 15)
	pnl_setting:SetType("none")

	--[*] Настройки
	SettingContent(pnl_setting, my_setting, text)
end

----------------------------------------------------------------------------------------------|>
--[+] Меню гитары :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
----------------------------------------------------------------------------------------------|>
local function UI_Menu(my_setting, text)
	--[*] Само меню
	ui_menu = jlib.vgui.Create("frame")
	ui_menu:SetText("Guitar Zero")
	ui_menu:SetSize(700, 700)
	ui_menu:Center()
	ui_menu:MakePopup()

	--[*] Окно с музыкой
	local pnl_main = jlib.vgui.Create("scroll", ui_menu)
	pnl_main:SetSize(700, 700)
	pnl_main:SetVisible(true)
	pnl_main:SetType("none")
	pnl_main:Dock(FILL)
	pnl_main:DockMargin(20, 0, 20, 0)
	pnl_main:SetName("ears")

	--[*] Окно с настройками
	local pnl_setting = jlib.vgui.Create("scroll", ui_menu)
	pnl_setting:SetSize(700, 700)
	pnl_setting:SetType("none")
	pnl_setting:Dock(FILL)
	pnl_setting:DockMargin(20, 0, 20, 0)
	pnl_setting:SetName("setting")
	pnl_setting:SetVisible(false)

	--[*] Окно с биндами
	local pnl_binds = jlib.vgui.Create("scroll", ui_menu)
	pnl_binds:SetSize(700, 700)
	pnl_binds:SetType("none")
	pnl_binds:Dock(FILL)
	pnl_binds:DockMargin(20, 0, 20, 0)
	pnl_binds:SetName("cube")
	pnl_binds:SetVisible(false)

	--[*] Окно с плейлистами
	local pnl_playlist = jlib.vgui.Create("scroll", ui_menu)
	pnl_playlist:SetSize(700, 700)
	pnl_playlist:SetType("none")
	pnl_playlist:Dock(FILL)
	pnl_playlist:DockMargin(20, 0, 20, 0)	
	pnl_playlist:SetName("star")
	pnl_playlist:SetVisible(false)			

	--[*] Выбор окна
	local page = jlib.vgui.Create("chapter", ui_menu)
	page:Dock(TOP)
	page:DockMargin(240, 5, 240, 5)
	page:SetForm("i")
	page:SetPosition("h")
	page:SetType("round")
	page:SetData(pnl_main, pnl_setting, pnl_binds, pnl_playlist)


	--[*] Обработка плейлиста
	local playlist = my_setting["playlist"]
	local playlist_current = my_setting["playlist_current"]
	playlist["-"] = true

	local check_current = false
	for name, _ in pairs(playlist) do
		if (playlist_current == name) then check_current = true end
	end
	if not (check_current) then 
		Guitar_Hero.MySetting["setting"]["playlist_current"] = "-"
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])		
		Debug() return
	end	

	--[*] Музыка
	local music_date = file.Find("sound/zero_guitar/music/*.mp3", "GAME")
	local all_ava = file.Find("materials/zero_guitar/music/*.png", "GAME")
	if (playlist_current != "-") then music_date = playlist[playlist_current] end 

	for _, music in pairs(music_date) do
		local pnl_mus = jlib.vgui.Create("panel", pnl_main)
		pnl_mus:Dock(TOP)
		pnl_mus:DockMargin(15, 5, 15, 5)
		pnl_mus:SetSize(300, 60)
		pnl_mus:SetType("round")

		local ava = jlib.vgui.Create("image", pnl_mus)
		ava:SetType("base")
		ava:SetSize(54, 54)
		ava:Dock(LEFT)
		ava:DockMargin(18, 5, 0, 5)

		for _, icons in pairs(all_ava) do
			if (jlib.sub(music, 1, jlib.len(music)-4) == jlib.sub(icons, 1, jlib.len(icons)-4)) then
				ava:SetImage("materials/zero_guitar/music/" .. icons)
			end
		end

		local name = jlib.vgui.Create("label", pnl_mus)
		name:SetSize(350, 60)
		name:Dock(LEFT)
		name:DockMargin(15, 0, 0, 0)
		name:SetFont("s1-24")
		name:SetText(jlib.sub(music, 1, jlib.len(music)-4))

		local btn_started = jlib.vgui.Create("button", pnl_mus)
		btn_started:Dock(RIGHT)
		btn_started:DockMargin(0, 5, 7, 5)
		btn_started:SetText(text["Начать"])
		btn_started.DoClick = function()
			UI_Submit(ui_menu, music, text, my_setting)
		end
	end

	--[*] Настройки
	SettingContent(pnl_setting, my_setting, text)
	--[*] Бинды
	BindsContent(pnl_binds, my_setting, text)
	--[*] Окно с плейлистами
	PlaylistContent(pnl_playlist, my_setting, text)
end

----------------------------------------------------------------------------------------------|>
--[+] Запуск UI :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
----------------------------------------------------------------------------------------------|>
function Guitar_Hero.UI_Start()
	local my_setting = Guitar_Hero.MySetting["setting"]
	local text = Guitar_Hero.Languages[jlib.cfg.lan]

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