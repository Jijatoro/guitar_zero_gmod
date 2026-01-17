--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
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
--[+] Settings menu (c-menu) |~| Меню настроек (c-menu) :--:--:--:--:--:--:--:--:--:--:--:}>                  |>
--------------------------------------------------------------------------------------------------------------|>
local menu_data = {
    ["lan"] = function(par) local sel = jlib.vgui.Create("selector", par) sel:Dock(TOP) sel:DockMargin(150, 15, 150, 0) sel:SetText(lan()["language"]) sel:SetData(jlib.cfg.lan_all) return sel end, 
    ["theme"] = function(par) local sel = jlib.vgui.Create("selector", par) sel:Dock(TOP) sel:DockMargin(150, 30, 150, 0) sel:SetText(lan()["theme"]) sel:SetData(jlib.cfg.theme_ChangeList) return sel end,
    ["sound_ui"] = function(par) local sw = jlib.vgui.Create("switch", par) sw:Dock(TOP) sw:DockMargin(150, 15, 150, 0) sw:SetText(lan()["sound_ui"]) return sw end,
    ["sound_ui_volume"] = function(par) local sl = jlib.vgui.Create("slider", par) sl:Dock(TOP) sl:DockMargin(60, 15, 60, 0) sl:SetText(lan()["sound_ui_volume"]) sl:SetDecimals(1) sl.OnValueChanged = function(self, val) self:SetValue(math.Round(val, 2)) jlib.vgui.PlaySound("cursor", val, true) end sl:SetType("round") return sl end
}

function jlib.SettingsMenu()
	local frame = jlib.vgui.Create("frame")
	frame:SetSize(500, 550)
	frame:MakePopup()
	frame:SetText(jlib.cfg.lans[jlib.cfg.lan]["settings"])
	frame:Center()

	local all = {}
	for k, v in pairs(menu_data) do
		all[k] = v(frame)
		all[k]:SetValue(jlib.cfg[k])
	end

	local ready = jlib.vgui.Create("button", frame)
	ready:SetText(lan()["ready"])
	ready:Dock(TOP)
	ready:DockMargin(150, 35, 150, 0)
	ready.DoClick = function()
		local data = {}
		for k, v in pairs(all) do
			data[k] = v:GetValue()
		end
		jlib.SaveData("lib-setting", data)
		frame:Remove()
	end
end

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 