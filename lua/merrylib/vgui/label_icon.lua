local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false
    self.pnltype = "base"

   	self.icon = Merry.Mat["question"]
	self.text = ""

	self:SetSize(500, 40)

	self.string = vgui.Create("MerryUI.Label", self)
	self.string:SetText(self:GetText())
	self.string:SetType("p1")
	self.string:SetSize(410, 40)
	self.string:Dock(LEFT)
	self.string:DockMargin(35, 1, 10, 0)
	self.string:SetContentAlignment(1)
end

function PANEL:SetIcon(val)
	self.icon = val
end

function PANEL:GetIcon()
	return self.icon
end

function PANEL:SetText(val)
	self.text = val
	self.string:SetText(val)
end

function PANEL:GetText()
	return self.string:GetText(val)
end

function PANEL:Paint(w, h)
	local theme = Merry.Themes[Merry.Theme]
	
	surface.SetMaterial(self:GetIcon().mat)
    surface.SetDrawColor(theme["color_icon"])
    surface.DrawTexturedRect(4, 6, 32, 32) 
end

vgui.Register("MerryUI.LabelIcon", PANEL, "Panel")