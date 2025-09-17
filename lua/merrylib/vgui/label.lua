local PANEL = {}

local label_type = {
    ["head"] = {font = "Merry.head", clr = "title_head"},
    ["h1"] = {font = "Merry.h1", clr = "title_h1"},
    ["p1"] = {font = "Merry.p1", clr = "title_p1"},
    ["p2"] = {font = "Merry.p2", clr = "title_p1"},
    ["btn"] = {font = "Merry.btn", clr = "title_btn"}
}

function PANEL:Init()
    self:SetFont(label_type["p1"].font)
    self:SetTextColor(label_type["p1"].clr)
end

function PANEL:SetType(type)
    local theme = Merry.Themes[Merry.Theme]
    
    if (label_type[type] == nil) then return end
    self:SetFont(label_type[type].font)
    self:SetTextColor(theme[label_type[type].clr])
end

vgui.Register("MerryUI.Label", PANEL, "DLabel")