--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}

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
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false

    self.text = ""
    self.mat = "question"
    self:SetSize(500, 600)
    self:MakePopup()
    self:Center()

    self.panel = jlib.vgui.Create("panel", self)
    self.panel:SetSize(550, 420)
    self.panel:SetType("nodraw")
    self.panel:Dock(TOP)
    self.panel:DockMargin(25, 90, 25, 0)

    self.string = jlib.vgui.Create("textblock", self.panel)
    self.string:SetValue(self:GetText())
    self.string:Dock(FILL)
    self.string:SetSize(550, 440)
 
    self.btnclose = jlib.vgui.Create("button", self)
    self.btnclose:SetText(lan()["ok"])
    self.btnclose:SetSize(80, 60)
    self.btnclose:Dock(TOP)
    self.btnclose:DockMargin(210, 10, 210, 0)
    self.btnclose.DoClick = function()
    	self:Remove()
    end

    self:Alpha()
end

function PANEL:Paint(w, h)
	draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
	draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])

    surface.SetMaterial(icon()[self:GetMat()])
    surface.SetDrawColor(clr()["icon"])
    surface.DrawTexturedRect(w*0.4, 3, 90, 90)
end

function PANEL:SetText(src)
	self.text = src
	self.string:SetValue(self.text)
end

function PANEL:GetText()
	return self.text
end

function PANEL:SetMat(val)
	self.mat = val
end

function PANEL:GetMat()
	return self.mat
end

vgui.Register("jlib.hint-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 