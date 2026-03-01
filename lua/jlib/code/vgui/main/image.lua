--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function j() return jlib end
local function c() return j()["cfg"] end
local function jv() return j()["vgui"] end
local function clr() return c()["themes"][c()["theme"]]  or {} end
local function icon() return c()["icons"][c()["icon"]] end
local function lan() return c()["lans"][c()["lan"]] or {} end

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.truename = "image"
    self:SetSize(45, 45)  
    self:SetText("")
    self.pnltype = "base"
    self.draw = true

    self.image = nil
    self.image_alpha = 255
    self.image_clr = Color(255, 255, 255)

    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)
    self.IsDisable = true
    self:SetCursor("arrow")
end

function PANEL:SetName(arg)
    self.truename = arg
end

function PANEL:GetName()
    return self.truename
end

function PANEL:Paint(w, h)
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("pnl")
    local round = jv.GetRound("weak")
    local circ, alpha = 0, 255
    local clr_line = clr["line"]
    local ad_pos, ad_size = 6, 12
    if (self.Hovered) and not (self.IsDisable) then clr_line = clr["btn_line_h"] end
    if not (self:GetDraw()) then alpha = 0 end
    if (self:GetType() == "round") then circ = round end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr_line, alpha))
    if (self:GetImage()) then
        surface.SetMaterial(Material(self:GetImage()))
        surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
        surface.DrawTexturedRect(border/2, border/2, w-border, h-border) 
    end
end

function PANEL:Scale(...)
    local jv = jv()
    local data = {...}
    jv["Scale"](self, data)
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
    jv["Margin"](self, data)
end

function PANEL:PerformLayout()
    if not (self.dockmargin) then return end
    self:Margin()
end

function PANEL:SetType(type)
    self.pnltype = type
end

function PANEL:GetType()
    return self.pnltype
end

function PANEL:SetDraw(val)
    self.draw = val
end

function PANEL:GetDraw()
    return self.draw
end

function PANEL:SetImage(arg)
    local jv = jv()
    if not (isstring(arg)) then return end
    if (string.StartWith(arg, "https")) then
        jv.UrlImage(arg, function(mat)
            if (mat) then
                self.image = mat
                return
            else
                return
            end
        end)
    else
        self.image = arg
    end
end

function PANEL:GetImage()
    return self.image
end

function PANEL:SetColor(arg1, arg2)
    self.image_clr = arg1
    if (arg2) then self.image_alpha = arg2 end
end

function PANEL:GetColor()
    return self.image_clr
end

function PANEL:Disable()
    self.IsDisable = true
    self:SetCursor("arrow")
end

function PANEL:Enable()
    self.IsDisable = false
    self:SetCursor("hand")
    self:SetAlpha(255)
end

vgui.Register("jlib.image-main", PANEL, "Button")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 