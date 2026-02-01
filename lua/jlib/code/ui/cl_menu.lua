--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local function icon()
    return jlib.cfg.icons[jlib.cfg.icon]  or {}
end

local function clr()
    return jlib.cfg.themes[jlib.cfg.theme]  or {}
end

local function lan()
    return jlib.cfg.lans[jlib.cfg.lan] or {}
end

--------------------------------------------------------------------------------------------------------------|>
--[+] The menu of loans and asset rights :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
local function OpenCredit(parent)
	local frame = jlib.vgui.Create("frame")
	frame:SetSize(670, 700)
	frame:SetColorAlpha(255)
	frame:MakePopup()
	frame:SetText(lan()["asset-credits-rights"])
	frame:Center()
	frame.OnRemove = function() parent:SetVisible(true) end 

	local textblock = jlib.vgui.Create("textblock", frame)
	textblock:SetValue(jlib.cfg.asset_credits_rights)
	textblock:Dock(FILL)
	textblock:DockMargin(0, 0, 0, 0)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Settings menu (c-menu) :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
--------------------------------------------------------------------------------------------------------------|>
local menu_data = {}
menu_data[1] = {key = "lan", func = function(par) local sel = jlib.vgui.Create("selector", par) sel:Dock(TOP) sel:DockMargin(150, 15, 150, 0) sel:SetText(lan()["language"]) sel:SetData(jlib.cfg.lan_all) return sel end}
menu_data[2] = {key = "theme", func = function(par) local sel = jlib.vgui.Create("selector", par) sel:Dock(TOP) sel:DockMargin(150, 15, 150, 0) sel:SetText(lan()["theme"]) sel:SetData(jlib.cfg.theme_ChangeList) return sel end}
menu_data[3] = {key = "sound_ui", func = function(par) local sw = jlib.vgui.Create("switch", par) sw:Dock(TOP) sw:DockMargin(150, 15, 150, 0) sw:SetText(lan()["sound_ui"]) return sw end}
menu_data[4] = {key = "sound_volume", func = function(par) local sl = jlib.vgui.Create("slider", par) sl:Dock(TOP) sl:DockMargin(60, 15, 60, 0) sl:SetText(lan()["sound_ui_volume"]) sl:SetDecimals(1) sl:SetMax(1) sl.OnValueChanged = function(self, val) self:SetValue(math.Round(val, 2)) jlib.vgui.PlaySound("cursor", val, true) end sl:SetType("round") return sl end}
menu_data[5] = {key = "music_volume", func = function(par) local sl = jlib.vgui.Create("slider", par) sl:Dock(TOP) sl:DockMargin(60, 15, 60, 0) sl:SetText(lan()["music_volume"]) sl:SetDecimals(1) sl:SetMax(5) sl.OnValueChanged = function(self, val) self:SetValue(math.Round(val, 2)) jlib.vgui.PlaySound("cursor", val, true) end sl:SetType("round") return sl end}

function jlib.SettingsMenu()
	local frame = jlib.vgui.Create("frame")
	frame:SetSize(500, 620)
	frame:MakePopup()
	frame:SetText(jlib.cfg.lans[jlib.cfg.lan]["settings"])
	frame:Center()

	local btn_credits = jlib.vgui.Create("button", frame)
	btn_credits:SetText(lan()["asset-credits-rights"])
	btn_credits:SetFont("s1-24")
	btn_credits:SetDraw(false)
	btn_credits:Dock(TOP)
	btn_credits:DockMargin(25, 10, 25, 0)
	btn_credits.DoClick = function()
		frame:SetVisible(false)
		OpenCredit(frame)
	end

	local all = {}
	for k, v in ipairs(menu_data) do
		all[v.key] = v.func(frame)
		all[v.key]:SetValue(jlib.cfg[v.key])
	end

	local ready = jlib.vgui.Create("button", frame)
	ready:SetText(lan()["ready"])
	ready:Dock(TOP)
	ready:DockMargin(150, 35, 150, 0)
	ready:SetSound("save")
	ready.DoClick = function()
		local data = {}
		for k, v in pairs(all) do
			data[k] = v:GetValue()
		end
		jlib.SaveData("lib-setting", data)
		LocalPlayer():ConCommand("spawnmenu_reload")
		frame:Remove()
	end
end

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 