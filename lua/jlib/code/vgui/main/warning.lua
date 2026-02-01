--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-18"
    },
    ["anime"] = {
        txt = "a3-18"
    },
    ["fantasy"] = {
        txt = "f1-24"
    },
    ["cyber"] = {
        txt = "c2-18"
    },    
    ["horror"] = {
        txt = "h4-18"
    },
    ["terminal"] = {
        txt = "t3-18"
    } 
}

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
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false

    self.text = ""
    self.textbtn = lan()["ok"]
    self.mat = "exclamation"
    self:SetSize(400, 260)

    self.string = jlib.vgui.Create("label", self)
    self.string:SetText(self:GetText())
    self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.string:Dock(TOP)
    self.string:DockMargin(15, 110, 15, 5)
    self.string:SetSize(400, 60)
    self.string:SetWrap(true)
    self.string:SetAutoStretchVertical(true)
    self.string:SetContentAlignment(5)
 
    self.btnclose = jlib.vgui.Create("button", self)
    self.btnclose:SetText(self:GetTextBtn())
    self.btnclose:SetSize(80, 60)
    self.btnclose:Dock(TOP)
    self.btnclose:DockMargin(145, 5, 145, 0)
    self.btnclose.DoClick = function()
    	self:Remove()
    end

    self:Alpha()
    timer.Simple(0.4, function()
        jlib.vgui.PlaySound("errror", nil, true)
    end)
end

function PANEL:Paint(w, h)
	draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
	draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])

    surface.SetMaterial(icon()[self:GetMat()])
    surface.SetDrawColor(clr()["icon_a"])
    surface.DrawTexturedRect(w*0.35, 5, 120, 120)
end

function PANEL:SetText(src)
	self.text = src
	self.string:SetText(self.text)
end

function PANEL:GetText()
	return self.text
end

function PANEL:SetTextBtn(src)
	self.textbtn = src
end

function PANEL:GetTextBtn()
	return self.textbtn
end

function PANEL:SetMat(val)
	self.mat = val
end

function PANEL:GetMat()
	return self.mat
end



vgui.Register("jlib.warning-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 