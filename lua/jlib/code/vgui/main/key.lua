--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-24",
        bind = "s5-16"
    },
    ["anime"] = {
        txt = "a3-24",
        bind = "s5-16"
    },
    ["fantasy"] = {
        txt = "f1-24",
        bind = "s5-16"
    },
    ["cyber"] = {
        txt = "c2-24",
        bind = "s5-16"
    },    
    ["horror"] = {
        txt = "h4-32",
        bind = "s5-16"
    },
    ["terminal"] = {
        txt = "t3-24",
        bind = "s5-16"
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
    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self.value = 0
    self.text = ""
    self.pnltype = "nodraw"    

    self.string = jlib.vgui.Create("label", self)
    self.string:SetText(self:GetText())
    self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.string:SetSize(100, 32)
    self.string:Dock(LEFT)
    self.string:DockMargin(10, 3, 10, 0)
    self.string:SetContentAlignment(1)
    self.string.PerformLayout = function(self)
        surface.SetFont(self:GetFont())
        local text_w, text_h = surface.GetTextSize(self:GetText())
        self:SetSize(text_w+5, 32)
    end  

    self.key = vgui.Create("DBinder", self)
    self.key:SetValue(self:GetValue())
    self.key:SetSize(170, 32)
    self.key:SetFont(jlib.vgui.GetFont(data_font, "bind"))
    self.key:SetTooltip(nil)
    self.key:Dock(LEFT)
    self.key:DockMargin(0, 5, 0, 5)  
    self.key.Paint = function(self, w, h)
        if (self.Hovered) then 
            self:SetTextColor(clr()["t_btn_h"])
            draw.RoundedBox(32, 0, 0, w, h, clr()["btn_line_h"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["btn_h"])
        else
            self:SetTextColor(clr()["t_btn_h"])
            draw.RoundedBox(32, 0, 0, w, h, clr()["btn_line"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["btn"])
        end
    end

    self:SetSize(315, 50)
    self.key:SetTip(lan()["tip-for-bind"], true)
end

function PANEL:SetType(type)
    self.pnltype = type
end

function PANEL:GetType()
    return self.pnltype
end

function PANEL:SetText(val)
    self.text = val
    self.string:SetText(val)
end

function PANEL:GetText()
    return self.text
end

function PANEL:SetValue(val)
    self.value = val
    self.key:SetValue(val)
end

function PANEL:GetValue()
    return self.key:GetValue()
end

function PANEL:Paint(w, h)
    if (self:GetType() == "base") then
        draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["body"])
    elseif (self:GetType() == "round") then
        draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])
    else end     
end

vgui.Register("jlib.key-main", PANEL, "DPanel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 