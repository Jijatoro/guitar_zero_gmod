local PANEL = {}

function PANEL:Init()
    local theme = Merry.Themes[Merry.Theme]

    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)

    self.value = 0
    self.text = ""    

    self:SetSize(400, 100)

    self.string = vgui.Create("MerryUI.Label", self)
    self.string:SetText(self:GetText())
    self.string:SetType("p1")
    self.string:SetSize(400, 50)
    self.string:Dock(TOP)
    self.string:DockMargin(50, 3, 50, 0)
    self.string:SetContentAlignment(5)  

    self.key = vgui.Create("DBinder", self)
    self.key:SetValue(self:GetValue())
    self.key:SetSize(200, 50)
    self.key:SetFont("Merry.head_l")
    self.key:Dock(BOTTOM)
    self.key:DockMargin(75, 0, 75, 3)  

    self.key.Paint = function(self, w, h)
        local theme = Merry.Themes[Merry.Theme]

        if (self.Hovered) then 
            self:SetTextColor(theme["title_btn"])
            draw.RoundedBox(32, 0, 0, w, h, theme["btn_line_hover"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn_hover"])
        else
            self:SetTextColor(theme["title_btn_hover"])
            draw.RoundedBox(32, 0, 0, w, h, theme["btn_line"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn"])
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
end

vgui.Register("MerryUI.Key", PANEL, "DPanel")