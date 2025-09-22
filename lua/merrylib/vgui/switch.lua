local PANEL = {}

function PANEL:Init()
    local theme = Merry.Themes[Merry.Theme]

    self.image = Merry.Mat["question"].mat
    self.status = false
    self.color = theme["switch_rd"]
    self.num1 = 3
    self.num2 = 10
    self.num3 = 30
    self.num4 = 30
    self.point = 10
    self:SetText("")
    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)
    self:SetSize(75, 40)

    self:SetStatus(false)    
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]

    if (self.Hovered) then 
        draw.RoundedBox(32, 0, 0, w, h, theme["btn_line_hover"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, self:GetColor())
    else
        draw.RoundedBox(32, 0, 0, w, h, theme["btn_line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, self:GetColor())     
    end

    draw.RoundedBox(128, self.point, 7, 25, 25, theme["btn"])

    surface.SetMaterial(self:GetImage())
    surface.SetDrawColor(theme["color_icon"])
    surface.DrawTexturedRect(self.num1, self.num2, self.num3, self.num4)
end

function PANEL:GetImage()
    return self.image
end

function PANEL:SetStatus(val)
    local theme = Merry.Themes[Merry.Theme]
    
    self.status = val
    if (self.status) then 
        self.color = theme["switch_gr"]
        self.num1 = 35
        self.num2 = 3
        self.num3 = 34
        self.num4 = 34
        self.point = 10
        self.image = Merry.Mat["accept"].mat
    else 
        self.color = theme["switch_rd"]
        self.num1 = 10
        self.num2 = 9
        self.num3 = 23
        self.num4 = 23
        self.point = 39
        self.image = Merry.Mat["close"].mat
    end
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

function PANEL:DoClick()
    if (self:GetStatus()) then
        self:SetStatus(false)
    else
        self:SetStatus(true)
    end
end

vgui.Register("MerryUI.Switch", PANEL, "Button")