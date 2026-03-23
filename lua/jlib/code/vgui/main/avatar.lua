--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function j() return jlib end
local function c() return j()["cfg"] end
local function jv() return j()["vgui"] end
local function clr() return c()["themes"][c()["theme"]]  or {} end
local function icon() return c()["icons"][c()["icon"]] end
local function lan() return c()["lans"][c()["lan"]] or {} end

--------------------------------------------------------------------------------------------------------------|>
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.truename = "avatar"
	self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.owner = nil
    self.frame_clr = clr()["checkbox"]
    self:SetSize(64, 64)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] True element name (custom) :--:--:--:--:--:--:--:--:--:--:--:}>                                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetName(arg)
	self.truename = arg
end

function PANEL:GetName()
	return self.truename
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Scaling in percentages (custom) :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Scale(...)
    local jv = jv()
    local data = {...}
    jv["Scale"](self, data)
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
    jv["Margin"](self, data)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Fires on every resize :--:--:--:--:--:--:--:--:--:--:--:}>                                              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:PerformLayout()
	--[*] adapt the sizes
    if not (self.dockmargin) then return end
    self:Margin()

    --[*] additional image processing
	if not (self.avatar) or not (IsValid(self.avatar)) then return end
	self:SetAvatar(self.owner)    
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Changing the border color :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetColor(arg)
	self.frame_clr = arg
end

function PANEL:GetColor()
	return self.frame_clr
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Avatar settings (local player) :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetAvatar(ent)
	if (self.avatar) then self.avatar:Remove() end
	local jv = jv()
	local border = jv.GetBorder("pnl")	
	local w, h = self:GetSize()
	self.owner = ent
	self.avatar = vgui.Create("AvatarImage", self)
	self.avatar:SetSize(w-border, h-border)
	self.avatar:SetPos(border/2, border/2)
	self.avatar:SetPlayer(ent, w)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the avatar owner :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetOwner(ent)
	return self.owner
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint(w, h)
	local jv, clr = jv(), clr()
	local border = jv.GetBorder("pnl")
	draw.RoundedBox(0, 0, 0, w, h, self:GetColor())
	draw.RoundedBox(0, border/2, border/2, w-border, h-border, clr["line"])
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.avatar-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 