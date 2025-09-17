local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false
    self.pnltype = "nodraw"

    self.value = false
	self.text = ""

	self:SetSize(500, 40)

    	self.string = vgui.Create("MerryUI.Label", self)
    	self.string:SetText(self:GetText())
    	self.string:SetType("p1")
    	self.string:SetSize(410, 40)
    	self.string:Dock(LEFT)
    	self.string:DockMargin(0, 0, 10, 0)
    	self.string:SetContentAlignment(1)

		self.checkbox = vgui.Create("MerryUI.CheckBox", self)
		self.checkbox:Dock(LEFT)
		self.checkbox:DockMargin(0, 3, 9, 0)
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetValue(val)
	self.value = val
	self.checkbox:SetStatus(val)
end

function PANEL:GetValue()
	return self.checkbox:GetStatus()
end

function PANEL:SetText(val)
	self.text = val
	self.string:SetText(val)
end

function PANEL:GetText()
	return self.text
end

function PANEL:Paint(w, h)
	local theme = Merry.Themes[Merry.Theme]
	
	if (self:GetType() == "base") then
		draw.RoundedBox(0, 0, 0, w, h, theme["p_line"])
		draw.RoundedBox(0, 3, 3, w-6, h-6, theme["p_body"])
	elseif (self:GetType() == "round") then
		draw.RoundedBox(32, 0, 0, w, h, theme["p_line"])
		draw.RoundedBox(32, 3, 3, w-6, h-6, theme["p_body"])
	else end 
end

vgui.Register("MerryUI.CheckBoxText", PANEL, "Panel")