local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false

    self.value = false
	self:SetSize(385, 60)

	self.text_entry = vgui.Create("MerryUI.TextEntry", self)
	self.text_entry:SetPlaceholderText("Ваш запрос...")
	self.text_entry:SetEnabled(true)
	self.text_entry:SetSize(210, 25)
	self.text_entry:Dock(LEFT)
	self.text_entry:DockMargin(10, 8, 1, 8)

	self.button = vgui.Create("MerryUI.Button", self)
	self.button:SetText("Поиск")
	self.button:SetDraw(true)
	self.button:SetSize(150, 25)
	self.button:Dock(RIGHT)
	self.button:DockMargin(1, 8, 10, 8)
end

function PANEL:GetValue()
	return self.text_entry:GetValue()
end

function PANEL:SetValue(val)
	self.text_entry:SetValue(val)
end

function PANEL:Paint(w, h)
	local theme = Merry.Themes[Merry.Theme]
	
	draw.RoundedBox(0, 0, 0, w, h, theme["p_line"])
	draw.RoundedBox(0, 3, 3, w-6, h-6, theme["p_body"])
end

vgui.Register("MerryUI.Searh", PANEL, "Panel")