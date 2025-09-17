local PANEL = {}

function PANEL:Init()
    local theme = Merry.Themes[Merry.Theme]

    self:SetText("не выбрано")
    self:SetFont("Merry.p2_b")
    self:SetTextColor(theme["title_btn"])

    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)

    self.parent = nil
    self.status = false
    self.value = "не выбрано"
    self.tblkey = {}
    self.key = 0

    self.scr_posx = 0

    self:SetSize(200, 40)
end

function PANEL:Paint(w, h)
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

function PANEL:SetStatus(bool)
    self.status = bool
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:SetPosX(data)
    scr_posx = data
end

function PANEL:GetGetPosX()
    return scr_posx
end

function PANEL:SetValue(val)
    self.value = val
end

function PANEL:GetValue()
    return self.value
end

function PANEL:SetKey(key)
    self.key = key
end

function PANEL:GetKey()
    return self.key
end

function PANEL:SetKeyTbl(tblkey)
    self.tblkey = tblkey
end

function PANEL:GetKeyTbl()
    return self.tblkey
end

function PANEL:SetParent(parent)
    self.parent = parent
end

function PANEL:GetParent()
    return self.parent
end

function PANEL:DoClick()
    local parent = self:GetParent():GetParent()
    if (self:GetStatus()) then
        self:SetStatus(false)
        self.Scroll:Remove()
    else
        self:SetStatus(true)
        local w, h = self:GetParent():GetPos()

        self.Scroll = vgui.Create("MerryUI.Scroll", parent)
            self.Scroll:SetPos(w+self.scr_posx+178, h+120)
            self.Scroll:SetSize(155, 110)
            self.Scroll:SetType("base")

        for i= 1, #self:GetKeyTbl() do
            local btnkey = vgui.Create("MerryUI.Button", self.Scroll)
                btnkey:Dock(TOP)
                btnkey:DockMargin(0, 0, 0, 1)
                btnkey:SetSize(0, 25)
                btnkey:SetText(MerryUI.sub(self:GetKeyTbl()[i], 1, 18))
                btnkey:SetFont("Merry.p2_l")
                btnkey.DoClick = function()
                    self:SetStatus(false)
                    self.Scroll:Remove()
                    self:SetKey(i)
                    self:SetValue(self:GetKeyTbl()[i])
                    self:SetText(self:GetKeyTbl()[i])
                end
        end
    end
end

vgui.Register("MerryUI.Selector", PANEL, "Button")