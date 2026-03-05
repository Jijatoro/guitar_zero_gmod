--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local function j() return jlib end
local function c() return j()["cfg"] end
local function jv() return j()["vgui"] end
local function icon() return c()["icons"][c()["icon"]]  or {} end
local function clr() return c()["themes"][c()["theme"]]  or {} end
local function lan() return c()["lans"][c()["lan"]] or {} end

--------------------------------------------------------------------------------------------------------------|>
--[+] Changing the music volume for zone-music :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
--------------------------------------------------------------------------------------------------------------|>
local function ZmusicEdit(val)
	if (zMusic) then
		local ps = zMusic["pstatus"]
		if (ps) and (ps["canedit_volume"]) and (IsValid(ps["currentmusic"])) then
			ps["currentmusic"]:SetVolume(val)
			return 
		else
			jlib.vgui.PlaySound("cursor", val, true)
			return
		end
	else
		jlib.vgui.PlaySound("cursor", val, true)
	end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] The menu of loans and asset rights :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
local function OpenCredit(parent)
	local frame = jlib.vgui.Create("frame")
	frame:Scale(0.3, 0.6)
	frame:SetColorAlpha(255)
	frame:MakePopup()
	frame:SetText(lan()["asset-credits-rights"])
	frame:Center()
	frame.OnRemove = function() parent:SetVisible(true) end 

	local textblock = jlib.vgui.Create("textblock", frame)
	textblock:SetValue(jlib.cfg.asset_credits_rights)
	textblock:Dock(FILL)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Settings menu (c-menu) :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
--------------------------------------------------------------------------------------------------------------|>
local menu_data = {}
menu_data[1] = {key = "lan", func = function(par) local sel = jlib.vgui.Create("selector", par) sel:Scale(0.4, 0.13) sel:Dock(TOP) sel:Margin(0.3, 0.02, 0.3, 0) sel:SetText(lan()["language"]) local all_lan = {} for k, _ in pairs(jlib.cfg.lans) do table.insert(all_lan, k) end sel:SetData(all_lan) return sel end}
menu_data[2] = {key = "theme", func = function(par) local sel = jlib.vgui.Create("selector", par) sel:Scale(0.4, 0.13) sel:Dock(TOP) sel:Margin(0.3, 0.02, 0.3, 0) sel:SetText(lan()["theme"]) sel:SetData(jlib.cfg.theme_ChangeList) return sel end}
menu_data[3] = {key = "sound_ui", func = function(par) local sw = jlib.vgui.Create("switch", par) sw:Scale(0.5, 0.13) sw:Dock(TOP) sw:Margin(0.25, 0.02, 0.25, 0) sw:SetText(lan()["sound_ui"]) return sw end}
menu_data[4] = {key = "sound_ui_volume", func = function(par) local sl = jlib.vgui.Create("slider", par) sl:Scale(0.83, 0.09) sl:Dock(TOP) sl:Margin(0.09, 0.02, 0.09, 0) sl:SetText(lan()["sound_ui_volume"]) sl:SetDecimals(2) sl:SetMax(1) sl.OnValueChanged = function(self, val) self:SetValue(math.Round(val, 2)) jlib.vgui.PlaySound("cursor", val, true) jlib.cfg.sound_ui_volume = math.Round(val, 2) end sl:SetType("round") return sl end}
menu_data[5] = {key = "music_volume", func = function(par) local sl = jlib.vgui.Create("slider", par) sl:Scale(0.83, 0.09) sl:Dock(TOP) sl:Margin(0.09, 0.02, 0.09, 0) sl:SetText(lan()["music_volume"]) sl:SetDecimals(2) sl:SetMax(5) sl.OnValueChanged = function(self, val) self:SetValue(math.Round(val, 2)) ZmusicEdit(val) end sl:SetType("round") return sl end}

function jlib.SettingsMenu()
	local jv = jv()
	
	local frame = jlib.vgui.Create("frame")
	frame:Scale(0.33, 0.54)
	frame:MakePopup()
	frame:SetText(jlib.cfg.lans[jlib.cfg.lan]["settings"])
	frame:Center()

	local btn_credits = jlib.vgui.Create("button", frame)
	btn_credits:SetText(lan()["asset-credits-rights"])
	btn_credits:SetDraw(false)
	btn_credits:Scale(0.8, 0.08)
	btn_credits:Dock(TOP)
	btn_credits:Margin(0.1, 0.01, 0.1, 0)
	btn_credits.DoClick = function()
		frame:SetVisible(false)
		OpenCredit(frame)
	end

	local all = {}
	for k, v in pairs(menu_data) do
		all[v.key] = v.func(frame)
		all[v.key]:SetValue(jlib.cfg[v.key])
	end

	local ready = jlib.vgui.Create("button", frame)
	ready:SetText(lan()["ready"])
	ready:Scale(0.3, 0.08)
	ready:Dock(TOP)
	ready:Margin(0.35, 0.03, 0.35, 0)
	ready:SetSound("save")
	ready.DoClick = function()
		local data = {}
		for k, v in pairs(all) do
			data[k] = v:GetValue()
		end
		jlib.SaveData(data)
		LocalPlayer():ConCommand("spawnmenu_reload")
		frame:Remove()
	end
end

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 