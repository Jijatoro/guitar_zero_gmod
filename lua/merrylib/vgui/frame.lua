local PANEL = {}

function PANEL:Init()
	--self:SetCursor( "sizeall" )
	self.head_text = "Главное меню"
	self.text_x = 0
	self.s_hide = true

	self.head = vgui.Create("MerryUI.Panel", self)
	self.head:SetSize(0, 60)
	self.head:Dock(TOP)
	self.head:DockMargin(0, -28, 0, 0)
	self.head:DockPadding(0, 7, 0, 7)
	self.head:SetType("nodraw")

	self.btn = vgui.Create("MerryUI.ButtonIcon", self.head)
	self.btn:SetSize(47, 27)
	self.btn:SetImage(Merry.Mat["close"])
	self.btn:Dock(RIGHT)
	self.btn:DockMargin(0, 0, 15, 0)
	self.btn.DoClick = function()
		self:Close()
	end

	self.text = vgui.Create("MerryUI.Label", self.head)
	self.text:SetText(self:GetText())
	self.text:SetType("head")
	self.text:Dock(LEFT)
	self.text:DockMargin(145+self.text_x, 0, 0, 0)
	self.text:SetSize(700, 75)
	self.text:SetContentAlignment(5)

	self:SetDraggable(true)
	self:SetSizable(false)
	self:SetScreenLock(true)
	self:SetMinWidth( 50 )
	self:SetMinHeight( 50 )
	self:SetPaintBackgroundEnabled(false)
	self:SetPaintBorderEnabled(false)
	self.m_fCreateTime = SysTime()

	self.btnClose:Remove()
	self.btnMaxim:Remove()
	self.btnMinim:Remove()
	self.lblTitle:Remove()
end

function PANEL:ShowCloseButton(bool)
	self.btn:SetVisible(bool)
end

function PANEL:GetText()
	return self.head_text
end

function PANEL:SetText(str)
	self.head_text = str
	self.text:SetText(str)
end

function PANEL:GetHide()
	return self.s_hide
end

function PANEL:SetHide(bool)
	self.s_hide = bool

	if not (self:GetHide()) then
		self.head:SetVisible(false)
		self.text:SetVisible(false)
	end
end

function PANEL:SetTextPos(num)
	self.text_x = num
	self.text:DockMargin(145+self.text_x, 0, 0, 0)
end

function PANEL:Paint( w, h )
	local theme = Merry.Themes[Merry.Theme] 
	
	if (self:GetHide()) then
		draw.RoundedBox(32, 0, 0, w, h, theme["line"])
		draw.RoundedBox(32, 3, 3, w-6, h-6, theme["background"])

		surface.SetMaterial(Merry.Mat["bg"])
    	surface.SetDrawColor(Color(255, 255, 255))
    	surface.DrawTexturedRect(0, 30, w, h-30)

		draw.RoundedBox(0, 150, 30, w-300, h-30, theme["line"])
		draw.RoundedBox(0, 153, 30, w-306, h-33, theme["head"])

		draw.RoundedBox(32, 0+1, 0+1, (w-2), 60, theme["line"])
		draw.RoundedBox(32, 3+1, 3+1, (w-2)-6, 60-6, theme["head"])
	end
end

function PANEL:PerformLayout()
	return false
end

function PANEL:SetIcon()
	return false
end

vgui.Register("MerryUI.Frame", PANEL, "DFrame")