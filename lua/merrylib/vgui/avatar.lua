local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false
    self.owner = nil
    self:SetSize(164, 164)
end

function PANEL:SetAvatar(ent)
	self.owner = ent

	self.avatar = vgui.Create("AvatarImage", self)
	self.avatar:SetSize(115, 115)
	self.avatar:SetPos(24, 24)
	self.avatar:SetPlayer(LocalPlayer(), 115)
end

function PANEL:GetOwner(ent)
	return self.owner
end

function PANEL:Paint(w, h)
	local theme = Merry.Themes[Merry.Theme]

	draw.RoundedBox(32, 0, 0, w, h,  theme["checkbox"])
	draw.RoundedBox(32, 3, 3, w-6, h-6,  theme["p_line"])
	draw.RoundedBox(0, 21, 21, 121, 121,  theme["p_body"])
end

vgui.Register("MerryUI.Avatar", PANEL, "Panel")