local PANEL = {}

function PANEL:Init()
    self.image = Merry.Mat["question"]
    self.num1 = 8
    self.num2 = 15
    self:SetText("")
    self.status = false

    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]
    
    if (self.Hovered) or (self:GetStatus()) then 
        draw.RoundedBox(32, 0, 0, w, h, theme["btn_line_hover"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn_hover"])
        surface.SetMaterial(self:GetImage())
        surface.SetDrawColor(theme["color_icon_active"])
        surface.DrawTexturedRect(self.num1, self.num1, w-self.num2, h-self.num2)          
    else
        draw.RoundedBox(32, 0, 0, w, h, theme["btn_line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn"])  
        surface.SetMaterial(self:GetImage())
        surface.SetDrawColor(theme["color_icon"])
        surface.DrawTexturedRect(self.num1, self.num1, w-self.num2, h-self.num2)              
    end
end

function PANEL:SetImage(src)
    if not (Merry.Mat[src]) or (Merry.Mat[src] == nil) then self.image = Merry.Mat["question"].mat end
    self.image = src.mat
    self.num1 = src.num1
    self.num2 = src.num2
end

function PANEL:GetImage()
    return self.image
end

function PANEL:SetStatus(val)
    self.status = val
end

function PANEL:GetStatus()
    return self.status
end

vgui.Register("MerryUI.ButtonIcon", PANEL, "Button")