local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false
    self.pnltype = "nodraw"

    self.value = false
	self.text = ""

    self.status = false
    self.value = "не выбрано"
    self.tblkey = {}
    self.key = 0

	self:SetSize(500, 120)

	self.selector = nil

	self.string = vgui.Create("MerryUI.Label", self)
	self.string:SetText("")
	self.string:SetType("p1")
	self.string:SetSize(410, 80)
	self.string:Dock(TOP)
	self.string:DockMargin(0, 0, 3, 0)
	self.string:SetContentAlignment(5)

	self.selector = vgui.Create("MerryUI.Selector", self)
	self.selector:SetKeyTbl(self.tblkey)
	self.selector:SetValue("не выбрано")
	self.selector:Dock(TOP)
	self.selector:DockMargin(145, 0, 145, 0)
	self.selector:SetParent(self)
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetValue(val)
	self.value = val
	timer.Simple(0.1, function()
		self.selector:SetValue(val)
		self.selector:SetText(val)
	end)
end

function PANEL:GetValue()
	return self.selector:GetValue()
end

function PANEL:SetKey(key)
    self.key = key
end

function PANEL:GetKey()
    return self.selector:GetKey()
end

function PANEL:SetKeyTbl(tblkey)
    timer.Simple(0.1, function()
    	self.selector:SetKeyTbl(tblkey)
    end)
end

function PANEL:GetKeyTbl()
    return self.selector:GetKeyTbl()
end

function PANEL:SetText(val)
	timer.Simple(0.1, function()
		self.string:SetText(val)
	end)
end

function PANEL:GetText()
	self.string:GetText()
end

function PANEL:SetPosX(data)
    self.selector.scr_posx = data
end

function PANEL:GetGetPosX()
    return self.selector:GetPosX()
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

vgui.Register("MerryUI.SelectorText", PANEL, "Panel")