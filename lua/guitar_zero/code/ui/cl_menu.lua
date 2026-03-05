----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные и функции :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
----------------------------------------------------------------------------------------------|>
local function j() return jlib end
local function jv() return j()["vgui"] end

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
	chat.AddText(Color(17, 128, 106), "[Guitar Zero] ", Color(173, 19, 2), reason)
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
	language_sel:Scale(0.38, 0.17)
	language_sel:Dock(TOP)
	language_sel:Margin(0.311, 0.05, 0.311, 0)

	--[*] Выбор темы
	local theme_sel = jlib.vgui.Create("selector", pnl_setting)
	theme_sel:SetValue(jlib.cfg.theme)
	theme_sel:SetData(jlib.cfg.theme_ChangeList)
	theme_sel:SetText(text["Тема"])
	theme_sel:Scale(0.38, 0.17)
	theme_sel:Dock(TOP)
	theme_sel:Margin(0.311, 0.02, 0.311, 0)

	--[*] Выбор мода
	local all_modes = {}
	for key, _ in pairs(Guitar_Hero.Modes) do
		table.insert(all_modes, key)
	end

	local mode_sel = jlib.vgui.Create("selector", pnl_setting)
	mode_sel:SetValue(my_setting["mode"])
	mode_sel:SetData(all_modes)
	mode_sel:SetText(text["Мод"])
	mode_sel:Scale(0.38, 0.17)
	mode_sel:Dock(TOP)
	mode_sel:Margin(0.311, 0.02, 0.311, 0)

	--[*] Громкость UI
	local sound_ui = jlib.vgui.Create("slider", pnl_setting)
	sound_ui:SetValue(my_setting["mode"])
	sound_ui:SetText(text["Громкость звуков"])
	sound_ui:SetDecimals(1) 
	sound_ui:SetMax(1)
	sound_ui:SetValue(jlib.cfg.sound_ui_volume)
	sound_ui:Scale(0.6, 0.08)
	sound_ui:Dock(TOP)
	sound_ui:Margin(0.2, 0.02, 0.2, 0)	
	sound_ui.OnValueChanged = function(self, val) 
		self:SetValue(math.Round(val, 2)) jlib.vgui.PlaySound("cursor", val, true)
		jlib.cfg.sound_ui_volume = math.Round(val, 2) 
	end	

	--[*] Готово
	local btn_ready = jlib.vgui.Create("button", pnl_setting)
	btn_ready:Scale(0.3, 0.1)
	btn_ready:Dock(TOP)
	btn_ready:Margin(0.35, 0.05, 0.35, 0)	
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
		key:Scale(0.5, 0.1)
		key:Dock(TOP)
		key:Margin(0.25, 0.05, 0.25, 0)
		data_keys[i] = key
	end

	--[*] Готово
	local btn_ready = jlib.vgui.Create("button", pnl_binds)
	btn_ready:Scale(0.3, 0.1)
	btn_ready:Dock(TOP)		
	btn_ready:SetText(lan()["Выбрать"])	
	btn_ready:Margin(0.35, 0.05, 0.35, 0)
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
	frame:Scale(0.35, 0.5)
	frame:Center()
	frame:MakePopup()
	local onremove = frame.OnRemove
	frame.OnRemove = function(self)
		onremove(self)
		ui_menu:SetVisible(true)
	end

	--[*] Название плейлиста
	local pnl_name = jlib.vgui.Create("panel", frame)
	pnl_name:SetType("none")
	pnl_name:Scale(0.5, 0.1)
	pnl_name:Dock(TOP)
	pnl_name:Margin(0.25, 0.05, 0.25, 0)

	local name_playlist = jlib.vgui.Create("textentry", pnl_name)
	name_playlist:Dock(FILL)
	name_playlist:SetPlaceholderText(text["Название плейлиста..."])
	if (type == "edit") then name_playlist:SetValue(old_name) end

	--[*] Окно с музыкой
	local pnl_main = jlib.vgui.Create("scroll", frame)
	pnl_main:Scale(0.9, 0.5)
	pnl_main:SetVisible(true)
	pnl_main:SetType("none")
	pnl_main:Dock(TOP)
	pnl_main:Margin(0.05, 0.05, 0.05, 0)

	--[*] Музыка
	local music_date = file.Find("sound/zero_guitar/music/*.mp3", "GAME")
	local all_ava = file.Find("materials/zero_guitar/music/*.png", "GAME")
	local data_switches = {}

	for _, music in pairs(music_date) do
		local pnl_mus = jlib.vgui.Create("panel", pnl_main)
		pnl_mus:SetType("round")
		pnl_mus:Scale(0.9, 0.16)
		pnl_mus:Dock(TOP)
		pnl_mus:Margin(0.05, 0.005, 0.05, 0.005)

		local ava = jlib.vgui.Create("image", pnl_mus)
		ava:SetType("base")
		ava:Scale(0, 1, 2)
		ava:Dock(LEFT)
		ava:Margin(0.02, 0.005, 0, 0.005)

		for _, icons in pairs(all_ava) do
			if (jlib.sub(music, 1, jlib.len(music)-4) == jlib.sub(icons, 1, jlib.len(icons)-4)) then
				ava:SetImage("materials/zero_guitar/music/" .. icons)
			end
		end

		local name = jlib.vgui.Create("label", pnl_mus)
		name:Scale(0.6, 1)
		name:Dock(LEFT)
		name:Margin(0.03, 0, 0, 0)
		name:SetText(jlib.sub(music, 1, jlib.len(music)-4))
		
		local status = false
		if (type == "edit") then
			for k, v in pairs(playlist[old_name]) do
				if (v == music) then status = true end
			end
		end

		local switch = jlib.vgui.Create("switch", pnl_mus)
		switch:SetText("")
		switch:SetType("base")
		switch:SetValue(status)	
		switch:Dock(RIGHT)
		switch:Scale(0, 1, 2)
		switch:Margin(0, 0, 0.03, 0)

		data_switches[music] = switch
	end

	--[*] Затычка
	local pnl_mus = jlib.vgui.Create("panel", pnl_main)
	pnl_mus:SetType("none")
	pnl_mus:Scale(0.25, 0.01)
	pnl_mus:Dock(TOP)
	pnl_mus:Margin(0.05, 0.005, 0.05, 0.005)	

	--[*] Создать/Изменить
	local name_ready = text["Создать"]
	if (type == "edit") then
		name_ready  =  text["Изменить"]
	end

	local btn_ready = jlib.vgui.Create("button", frame)
	btn_ready:Scale(0.3, 0.1)
	btn_ready:Dock(TOP)
	btn_ready:Margin(0.35, 0.05, 0.35, 0)
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
	playlist_sel:Scale(0.38, 0.17)
	playlist_sel:Dock(TOP)
	playlist_sel:Margin(0.311, 0.02, 0.311, 0)
	playlist_sel:SetData(data_list)
	playlist_sel:SetText(text["Выбранный плейлист"])

	--[*] Готово	
	local btn_ready = jlib.vgui.Create("button", pnl_playlist)
	btn_ready:Scale(0.3, 0.1)
	btn_ready:Dock(TOP)
	btn_ready:Margin(0.35, 0.005, 0.35, 0)
	btn_ready:SetText(lan()["Готово"])
	btn_ready.DoClick = function()
		Guitar_Hero.MySetting["setting"]["playlist_current"] = playlist_sel:GetValue()
		Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])
		Debug() SaveSound()
	end

	--[*] Ваши плейлисты
	if (size_playlist > 1) then
		local my_playlist = jlib.vgui.Create("scroll", pnl_playlist)
		my_playlist:Scale(0.8, 0.48)
		my_playlist:Dock(TOP)
		my_playlist:SetType("round")
		my_playlist:Margin(0.1, 0.04, 0.1, 0)
		my_playlist:SetVisible(true)

		for n, v in pairs(playlist) do
			if (n == "-") then continue end
			local slot = jlib.vgui.Create("panel", my_playlist)
			slot:Scale(0.8, 0.16)
			slot:Dock(TOP)
			slot:Margin(0.1, 0.005, 0.1, 0)
			slot:SetType("round")

			local name = jlib.vgui.Create("label", slot)
			name:Scale(0.4, 0.09)
			name:SetText(n)
			name:Dock(LEFT)
			name:Margin(0.02, 0, 0, 0)
		
			--[*] Удалить
			local pnl_del = jlib.vgui.Create("panel", slot)
			pnl_del:SetType("none")
			pnl_del:Scale(0, 1, 2)
			pnl_del:Dock(RIGHT)
			pnl_del:Margin(0.005, 0, 0.005, 0)

			local btn_delete = jlib.vgui.Create("button", pnl_del)
			btn_delete:Dock(FILL)
			btn_delete:Margin(0, 0.1, 0, 0.1)
			btn_delete:SetImage("close")
			btn_delete.DoClick = function()
				Guitar_Hero.MySetting["setting"]["playlist"][n] = nil
				Guitar_Hero.SaveSetting("setting", Guitar_Hero.MySetting["setting"])
				Debug() jlib.vgui.PlaySound("jlib/ui/main/save.mp3", val, true)				
			end	

			--[*] Изменить
			local pnl_edit = jlib.vgui.Create("panel", slot)
			pnl_edit:SetType("none")
			pnl_edit:Scale(0, 1, 2)
			pnl_edit:Dock(RIGHT)
			pnl_edit:Margin(0.005, 0, 0.005, 0)

			local btn_edit = jlib.vgui.Create("button", pnl_edit)
			btn_edit:Dock(FILL)
			btn_edit:Margin(0, 0.1, 0, 0.1)
			btn_edit:SetImage("edit")
			btn_edit.DoClick = function()
				ui_menu:SetVisible(false)
				UI_CreatePlaylist(my_setting, text, playlist, "edit", n)
			end
		end

		--[*] Затычка
		local slot_minus = jlib.vgui.Create("panel", my_playlist)
		slot_minus:Scale(0.8, 0.05)
		slot_minus:Dock(TOP)
		slot_minus:Margin(0.1, 0.005, 0.1, 0)
		slot_minus:SetType("none")		
	end


	--[*] Создать плейлист
	local btn_create = jlib.vgui.Create("button", pnl_playlist)
	btn_create:SetText(text["Создать новый"])	
	btn_create:Scale(0.3, 0.1)
	btn_create:Dock(TOP)
	btn_create:Margin(0.35, 0.005, 0.35, 0)		
	btn_create.DoClick = function()
		ui_menu:SetVisible(false)
		UI_CreatePlaylist(my_setting, text, playlist, "create", nil)
		jlib.vgui.PlaySound("zero_guitar/picnic.mp3", nil, false)
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Окно подтверждения :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
local function UI_Submit(parent, music, text, my_setting)
	parent:SetVisible(false)

	local d_name = "" local d_author = "" local complexity = 1 local d_music = Guitar_Hero.DataMusic[music] or nil
	if (d_music) then d_name = d_music.name d_author = d_music.author d_complexity = d_music.complexity	end

	--[*] Меню
	local frame = jlib.vgui.Create("frame")
	frame:Scale(0.3, 0.35)
	frame:ScaleHead(1, 0.15)
	frame:SetText(d_name)
	frame:Center()
	frame:MakePopup()
	local onremove = frame.OnRemove
	frame.OnRemove = function(self)
		onremove(self)
		if (IsValid(parent)) then 
			parent:SetVisible(true)
		end
	end

	--[*] Описание музыки
	local author = jlib.vgui.Create("label", frame)
	author:Scale(1, 0.1)
	author:Dock(TOP)
	author:Margin(0, 0.17, 0, 0)
	author:SetText(d_author or "")
	author:SetContentAlignment(5)

	local time = tostring(math.Round(SoundDuration("zero_guitar/music/" .. music))) or ""
	
	local duration = jlib.vgui.Create("label", frame)
	duration:Scale(1, 0.1)
	duration:Dock(TOP)
	duration:Margin(0, 0.005, 0, 0)
	duration:SetText(time .. " " .. text["секунд"])
	duration:SetContentAlignment(5)

	local panel_star = jlib.vgui.Create("panel", frame)
	panel_star:Scale(0.58, 0.11)
	panel_star:Dock(TOP)
	panel_star:Margin(0.18, 0.003, 0.18, 0)
	panel_star:SetType("none")

	local complexity = math.min(5, d_complexity or 1)
	local amout = math.max(1, complexity)
	local w_size = 1/5
	for i = 1, 5 do
		local pnl_star = jlib.vgui.Create("panel", panel_star)
		pnl_star:SetType("none")
		pnl_star:Dock(LEFT)
		pnl_star:Margin(0.005, 0, 0.02, 0)
		pnl_star:Scale(w_size, 1, 1)

		local star = jlib.vgui.Create("button", pnl_star)
		star:Scale(1, 0.5)
		star:Dock(FILL)
		star:Margin(0, 0.08, 0, 0)
		star:SetImage("star")
		star:SetMouseInputEnabled(false)
		star:SetCursor("arrow")		
		if (i <= amout) then star:SetStatus(true) end
	end	

	--[*] Ну, пошла Родная... (или нет?)
	local btn_play = jlib.vgui.Create("button", frame)
	btn_play:SetText(text["Играть"])
	btn_play:Scale(0.3, 0.1)
	btn_play:Dock(TOP)
	btn_play:Margin(0.35, 0.05, 0.35, 0)
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
	ui_welcome:Scale(0.38, 0.55)
	ui_welcome:SetText(text["Добро пожаловать"])
	ui_welcome:Center()
	ui_welcome:MakePopup()

	--[*] Окно с настройками
	local pnl_setting = jlib.vgui.Create("scroll", ui_welcome)
	pnl_setting:Scale(0.99, 0.8)
	pnl_setting:SetVisible(true)
	pnl_setting:Dock(FILL)
	pnl_setting:Margin(0, 0.07, 0, 0)
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
	ui_menu:Scale(0.38, 0.55)
	ui_menu:Center()
	ui_menu:MakePopup()

	--[*] Окно с музыкой
	local pnl_main = jlib.vgui.Create("scroll", ui_menu)
	pnl_main:Scale(0.99, 0.8)
	pnl_main:SetVisible(true)
	pnl_main:SetType("none")
	pnl_main:Dock(FILL)
	pnl_main:Margin(0, 0.005, 0, 0)
	pnl_main.chname = "sound"

	--[*] Окно с настройками
	local pnl_setting = jlib.vgui.Create("scroll", ui_menu)
	pnl_setting:Scale(0.99, 0.8)
	pnl_setting:SetType("none")
	pnl_setting:Dock(FILL)
	pnl_setting:Margin(0, 0.005, 0, 0.005)
	pnl_setting:SetVisible(false)
	pnl_setting.chname = "setting"

	--[*] Окно с биндами
	local pnl_binds = jlib.vgui.Create("scroll", ui_menu)
	pnl_binds:Scale(0.99, 0.8)
	pnl_binds:SetType("none")
	pnl_binds:Dock(FILL)
	pnl_binds:Margin(0, 0.005, 0, 0.005)
	pnl_binds:SetVisible(false)
	pnl_binds.chname = "cube"

	--[*] Окно с плейлистами
	local pnl_playlist = jlib.vgui.Create("scroll", ui_menu)
	pnl_playlist:Scale(0.99, 0.8)
	pnl_playlist:SetType("none")
	pnl_playlist:Dock(FILL)
	pnl_playlist:Margin(0, 0.005, 0, 0.005)	
	pnl_playlist:SetVisible(false)	
	pnl_playlist.chname = "star"		

	--[*] Выбор окна
	local page = jlib.vgui.Create("chapter", ui_menu)
	page:Scale(0.245, 0.08)
	page:Dock(TOP)
	page:Margin(0.38, 0.008, 0.38, 0.005)
	page:SetForm("i")
	page:SetPosition("h")
	page:SetType("none")
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
		pnl_mus:Scale(0.9, 0.1)
		pnl_mus:Dock(TOP)
		pnl_mus:Margin(0.02, 0.005, 0.02, 0.005)
		pnl_mus:SetType("round")

		local ava = jlib.vgui.Create("image", pnl_mus)
		ava:SetType("base")
		ava:Scale(0, 1, 2)
		ava:Dock(LEFT)
		ava:Margin(0.015, 0, 0, 0)

		for _, icons in pairs(all_ava) do
			if (jlib.sub(music, 1, jlib.len(music)-4) == jlib.sub(icons, 1, jlib.len(icons)-4)) then
				ava:SetImage("materials/zero_guitar/music/" .. icons)
			end
		end

		local name = jlib.vgui.Create("label", pnl_mus)
		name:Scale(0.815, 1)
		name:Dock(LEFT)
		name:Margin(0.01, 0, 0, 0)
		name:SetText(jlib.sub(music, 1, jlib.len(music)-4))

		local pnl_str = jlib.vgui.Create("panel", pnl_mus)
		pnl_str:SetType("none")
		pnl_str:Scale(0.2, 1)
		pnl_str:Dock(RIGHT)
		pnl_str:Margin(0, 0, -0.05, 0)

		local btn_started = jlib.vgui.Create("button", pnl_str)
		btn_started:Dock(FILL)
		btn_started:Margin(0, 0.12, 0, 0.12)
		btn_started:SetText(text["Начать"])
		btn_started.DoClick = function()
			UI_Submit(ui_menu, music, text, my_setting)
		end
	end

	--[*] Затычка
	local pnl_end = jlib.vgui.Create("panel", pnl_main)
	pnl_end:Scale(0.9, 0.01)
	pnl_end:Dock(TOP)
	pnl_end:Margin(0.02, 0.005, 0.02, 0.005)
	pnl_end:SetType("none")	

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