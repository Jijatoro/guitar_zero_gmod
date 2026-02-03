--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.owner = nil
    self.frame_clr = clr()["checkbox"]
    self:SetSize(64, 64)
end

function PANEL:SetColor(arg)
	self.frame_clr = arg
end

function PANEL:GetColor()
	return self.frame_clr
end

function PANEL:SetAvatar(ent)
	if (self.avatar) then self.avatar:Remove() end
	local w, h = self:GetSize()
	self.owner = ent
	self.avatar = vgui.Create("AvatarImage", self)
	self.avatar:SetSize(w-6, h-6)
	self.avatar:SetPos(3, 3)
	self.avatar:SetPlayer(ent, w)
end

function PANEL:GetOwner(ent)
	return self.owner
end

function PANEL:PerformLayout()
	if not (self.avatar) or not (IsValid(self.avatar)) then return end
	self:SetAvatar(self.owner)
end

function PANEL:Paint(w, h)
	local c = clr()
	draw.RoundedBox(0, 0, 0, w, h, self:GetColor())
	draw.RoundedBox(0, 3, 3, w-6, h-6, c["line"])
end

vgui.Register("jlib.avatar-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 