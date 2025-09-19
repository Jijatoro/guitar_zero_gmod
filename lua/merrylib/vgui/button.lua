local PANEL = {}

function PANEL:Init()
    local theme = Merry.Themes[Merry.Theme]
    
    self:SetText("")
    self:SetFont("Merry.btn")
    self:SetTextColor(theme["title_btn"])
    self.status = false
    self.draw = true

    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)

    self:SetSize(210, 50)    
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]

    if (self.draw) then
        if (self.Hovered) or (self:GetStatus()) then 
            self:SetTextColor(theme["title_btn_hover"])
            draw.RoundedBox(32, 0, 0, w, h, theme["btn_line_hover"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn_hover"])
        else
            self:SetTextColor(theme["title_btn"])
            draw.RoundedBox(32, 0, 0, w, h, theme["btn_line"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn"])
        end
    else
        if (self.Hovered) or (self:GetStatus()) then 
            self:SetTextColor(theme["title_btn_hover"])
        else
            self:SetTextColor(theme["title_btn"])
        end
    end
end

function PANEL:SetStatus(val)
    self.status = val
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:GetImage()
    return false
end

function PANEL:SetDraw(val)
    self.draw = val
end

function PANEL:GetDraw()
    return self.draw
end


vgui.Register("MerryUI.Button", PANEL, "Button")