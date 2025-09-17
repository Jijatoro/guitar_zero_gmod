local PANEL = {}

function PANEL:Init()
	--self:SetCursor( "sizeall" )

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

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetValue(value)
	self.pnlvalue = value
end

function PANEL:GetValue()
	return self.pnlvalue
end

function PANEL:Paint(w, h)
	local theme = Merry.Themes[Merry.Theme] 
	
	if (self:GetType() == "base") then
		draw.RoundedBox(0, 0, 0, w, h, theme["p_line"])
		draw.RoundedBox(0, 3, 3, w-6, h-6, theme["p_body"])
	elseif (self:GetType() == "round") then
		draw.RoundedBox(32, 0, 0, w, h, theme["p_line"])
		draw.RoundedBox(32, 3, 3, w-6, h-6, theme["p_body"])
	elseif (self:GetType() == "image") then
		if (self:GetValue() != nil) then
    		surface.SetMaterial(Material(self:GetValue(), "noclamp smooth"))
    		surface.SetDrawColor(theme["color_icon"])
    		surface.DrawTexturedRect(0, 0, w, h)
    	end		
	else end 
end

function PANEL:PerformLayout()
	return false
end

function PANEL:SetIcon()
	return false
end

vgui.Register("MerryUI.FrameSimple", PANEL, "DFrame")