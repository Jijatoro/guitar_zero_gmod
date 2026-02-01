--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local all_typs = {"base", "round"}
local data_font = {
    ["main"] = {
        txt = "s1-18"
    },
    ["anime"] = {
        txt = "a3-18"
    },
    ["fantasy"] = {
        txt = "f1-18"
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
    self:SetSize(270, 75)
    self.image = icon()["question"]
    self.status = false
    self.color = clr()["red"]
    self.num1 = 3 self.num2 = 10
    self.num3, self.num4 = 30
    self.point = 10
    self.value = false 
    self.text = ""
    self:SetStatus(false)
    self.pnltype = "round"

    self.string = jlib.vgui.Create("label", self)
    self.string:SetText(self:GetText())
    self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.string:SetSize(265, 28)
    self.string:Dock(TOP)
    self.string:DockMargin(0, 1, 0, 0)
    self.string:SetContentAlignment(5)    

    self.button = jlib.vgui.Create("button", self)
    self.button:SetText("")
    self.button:SetSize(75, 40) 
    self.button:SetMouseInputEnabled(true)
    self.button:SetKeyboardInputEnabled(true)
    self.button:SetIsToggle(true)
    self.button.Paint = function(self, w, h)
        local parent = self:GetParent()
        if (self.Hovered) then 
            draw.RoundedBox(32, 0, 0, w, h, clr()["btn_line_h"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, parent:GetColor())
        else
            draw.RoundedBox(32, 0, 0, w, h, clr()["btn_line"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, parent:GetColor())     
        end
        draw.RoundedBox(128, parent.point, 7, 25, 25, clr()["btn"])
        surface.SetMaterial(parent:GetImage())
        surface.SetDrawColor(clr()["btn_line"])
        surface.DrawTexturedRect(parent.num1, parent.num2, parent.num3, parent.num4)
    end
    self.button.DoClick = function()
        if (self:GetStatus()) then
            self:SetStatus(false)
        else
            self:SetStatus(true)
        end
    end
end

function PANEL:GetImage()
    return self.image
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:GetColor()
    return self.color
end

function PANEL:GetValue()
    return self.status
end

function PANEL:SetValue(val)
    self:SetStatus(val) 
end

function PANEL:SetText(val)
    self.text = val
    if not (val) or (val == "") then
        self.string:Remove()
    else
        self.string:SetText(val)
    end
end

function PANEL:GetText()
    return self.text
end

function PANEL:SetType(type)
    self.pnltype = type
end

function PANEL:GetType()
    return self.pnltype
end

function PANEL:SetStatus(val)
    self.status = val
    if (self.status) then 
        self.color = clr()["green"]
        self.num1 = 35 self.num2 = 3
        self.num3, self.num4  = 34, 34
        self.point = 10
        self.image = icon()["accept"]
    else 
        self.color = clr()["red"]
        self.num1 = 10 self.num2 = 9
        self.num3, self.num4  = 23, 23
        self.point = 39
        self.image = icon()["close"]
    end
end

function PANEL:Disable()
    self.button.IsDisable = true
    self.button:SetCursor("no")
    self.button:SetAlpha(120)
end

function PANEL:Enable()
    self.button.IsDisable = false
    self.button:SetCursor("hand")
    self.button:SetAlpha(255)
end

function PANEL:PerformLayout()
    self.button:CenterHorizontal(0.5)
    self.button:CenterVertical(0.65)
end

function PANEL:Paint(w, h)
    local circ, alpha = 0, 255
    if (self:GetType() == "round") then circ = 32 end
    if not (table.KeyFromValue(all_typs, self:GetType())) then alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr()["line"], alpha))
    draw.RoundedBox(circ, 3, 3, w-6, h-6, ColorAlpha(clr()["body"], alpha))
end

vgui.Register("jlib.switch-main", PANEL, "PANEL")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 