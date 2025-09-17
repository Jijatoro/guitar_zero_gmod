local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false
    self.pnltype = "nodraw"

    self.value = 0
	self.min = 0
	self.max = 100
	self.text = ""

	self:SetSize(450, 100)
	self.string = vgui.Create("MerryUI.Label", self)
	self.string:SetText(self:GetText())
	self.string:SetType("p1")
	self.string:SetSize(400, 40)
	self.string:Dock(TOP)
	self.string:DockMargin(50, 3, 50, 0)
	self.string:SetContentAlignment(5)  

	self.slider = vgui.Create("MerryUI.SliderNum", self)
	self.slider:SetValue(self:GetValue())
	self.slider:SetMin(self:GetMin())
	self.slider:SetMax(self:GetMax())
	self.slider:SetDecimals(0)
	self.slider:SetSize(400, 35)
	self.slider:Dock(BOTTOM)
	self.slider:DockMargin(65, 0, 55, 5)
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetValue(val)
	self.value = val
	self.slider:SetValue(val)
end

function PANEL:GetValue()
	return self.slider:GetValue()
end

function PANEL:SetMin(val)
	self.min = val
	self.slider:SetMin(val)
end

function PANEL:GetMin()
	return self.slider:GetMin()
end

function PANEL:SetMax(val)
	self.max = val
	self.slider:SetMax(val)
end

function PANEL:GetMax()
	return self.slider:GetMax()
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

vgui.Register("MerryUI.SliderText", PANEL, "Panel")