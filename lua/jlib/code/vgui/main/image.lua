--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
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

function PANEL:Paint(w, h)
    local c = clr()
    local circ, alpha = 0, 255
    local clr_line = c["line"]
    local ad_pos, ad_size = 6, 12
    if (self.Hovered) and not (self.IsDisable) then clr_line = c["btn_line_h"] end
    if not (self:GetDraw()) then alpha = 0 end
    if (self:GetType() == "round") then circ = 32 ad_pos, ad_size = 18, 36 end

    draw.RoundedBox(circ, 3, 3, w-6, h-6, ColorAlpha(clr_line, alpha))

    if (self:GetImage()) then
        surface.SetMaterial(Material(self:GetImage()))
        surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
        surface.DrawTexturedRect(ad_pos, ad_pos, w-ad_size, h-ad_size) 
    end
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
    if not (isstring(arg)) then return end
    if (string.StartWith(arg, "https")) then
        jlib.UrlImage(arg, function(mat)
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