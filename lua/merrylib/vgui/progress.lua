local PANEL = {}

function PANEL:Init()
    self.value = 0
    self.progress = 0
    self.max = 0
    self.text = ""

    self:SetSize(190, 95)
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]
    
    local w_pr = math.Round((w*self:GetProgress())/100)
    draw.RoundedBox(0, 0, 0+35, w, h-60, theme["btn_line_hover"])
    draw.RoundedBox(0, 3, 3+35, w-6, h-6-60, theme["checkbox"])
    draw.RoundedBox(0, 3, 3+35, w_pr-6, h-6-60, theme["progress"])
    
    if (self:GetMax()>=100000) then
        draw.DrawText(self:GetValue(), "Merry.p1", 140, 40, theme["head"], TEXT_ALIGN_CENTER)
    else
        draw.DrawText(self:GetValue() .. "/" .. self:GetMax(), "Merry.p1", 140, 40, theme["head"], TEXT_ALIGN_CENTER)
    end

    draw.DrawText(self:GetText(), "Merry.p1", 143, 5, theme["title_p1"], TEXT_ALIGN_CENTER)
end

function PANEL:SetProgress(val)
    local result = (self:GetMax()/val)
    result = math.Round(100/result)
    self.progress = result
end

function PANEL:GetProgress()
    return self.progress
end

function PANEL:SetMax(val)
    self.max = val
end

function PANEL:GetMax()
    return self.max
end

function PANEL:SetText(val)
    self.text = val
end

function PANEL:GetText()
    return self.text
end

function PANEL:SetValue(val)
    if (val>self.max) then val = self.max end
    self.value = val
    self:SetProgress(val)
end

function PANEL:AddValue(val)
    self.value = self.value+val
    self:SetProgress(val)
end

function PANEL:GetValue()
    return self.value
end

vgui.Register("MerryUI.Progress", PANEL, "DPanel")