local PANEL = {}

function PANEL:Init()
    self.image = Merry.Mat["close"].mat
    self:SetText("")

    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)

    local theme = Merry.Themes[Merry.Theme]
    self.color = theme["checkbox"]
    self.status = false
    self.num1 = 5
    self.num2 = 5
    self.num3 = 25
    self.num4 = 25
    self:SetStatus(false)

    self:SetSize(35, 35)  
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]
    
    if (self.Hovered) then 
        draw.RoundedBox(8, 0, 0, w, h, theme["btn_line_hover"])
        draw.RoundedBox(8, 3, 3, w-6, h-6, self.color)
    else
        draw.RoundedBox(8, 0, 0, w, h, theme["btn_line"])
        draw.RoundedBox(8, 3, 3, w-6, h-6, self.color)       
    end

    surface.SetMaterial(self:GetImage())
    surface.SetDrawColor(theme["color_icon"])
    surface.DrawTexturedRect(self.num1, self.num2, self.num3, self.num4)
end

function PANEL:SetStatus(val)
    self.status = val
    if (self.status) then 
        self.num1 = 2
        self.num2 = 2
        self.num3 = 29
        self.num4 = 29
        self.image = Merry.Mat["accept"].mat
    else 
        self.num1 = 5
        self.num2 = 5
        self.num3 = 25
        self.num4 = 25
        self.image = Merry.Mat["close"].mat
    end
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:GetImage()
    return self.image
end

function PANEL:DoClick()
    if (self:GetStatus()) then
        self:SetStatus(false)
    else
        self:SetStatus(true)
    end
end

vgui.Register("MerryUI.CheckBox", PANEL, "Button")