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
	local jv = jv()
	self.truename = "frame"
	self.text = lan()["main-menu"]
	self.s_hide = true
	self:SetDraggable(true)
	self:SetSizable(false)
	self:SetScreenLock(true)
	self:SetMinWidth(50)
	self:SetMinHeight(50)
	self:SetPaintBackgroundEnabled(false)
	self:SetPaintBorderEnabled(false)
	self.m_fCreateTime = SysTime()
	self.color_alpha = 200

    self.image = false
    self.image_alpha = 255
    self.image_clr = Color(255, 255, 255)	

    for _, v in ipairs(self:GetChildren()) do v:Remove() end
    self:DockPadding(0, 0, 0, 0)

	self.head = jlib.vgui.Create("panel", self)
	self.head:Scale(0, 0.1)
	self.head:Dock(TOP)
	self.head:SetType("round")
	self.head:Margin(0, 0, 0, 0)
	self.head:SetColorAlpha(255)

	self.head_text = jlib.vgui.Create("label", self.head)
	self.head_text:SetText(self.text)
	self.head_text:Dock(FILL)
	self.head_text:Margin(0.085, 0, 0, 0)
	self.head_text:SetContentAlignment(5)
	jv.SetFont(self.head_text, "h1", true)

	self.btn = jlib.vgui.Create("button", self.head)
	self.btn:Scale(0.09, 0.7, 2)
	self.btn:SetImage("close")
	self.btn:Dock(RIGHT)
	self.btn:Margin(0, 0.15, 0.02, 0)
	self.btn:SetSound("close")
	self.btn.DoClick = function()
		self:Close()
	end	

	jv.Alpha(self)
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
    local arg = {...}
    local w, h = ScrW(), ScrH()
    local size_x, size_y = arg[1]*w, arg[2]*h
    self.cust_size = {arg[1], arg[2]}
    self:SetSize(size_x, size_y)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Fires on every resize :--:--:--:--:--:--:--:--:--:--:--:}>                                              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:PerformLayout()
	--[*] we do nothing
	return false
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Event before the element is completely removed :--:--:--:--:--:--:--:--:--:--:--:}>                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnRemove()
	hook.Run("jlib.CloseUI")
end

--------------------------------------------------------------------------------------------------------------|>
--[+] clearing the elements of adaptation :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:ScaleHead(w, h)
	if not (IsValid(self.head)) then return end
	self.head:Scale(w, h)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the visibility of the close button :--:--:--:--:--:--:--:--:--:--:--:}>                        |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:ShowCloseButton(bool)
	self.btn:SetVisible(bool)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Text control (heading) :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetText(str)
	self.text = str
	self.head_text:SetText(str)
end

function PANEL:GetText()
	return self.text
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing head visibility :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetHide(bool)
	self.s_hide = bool

	if not (self:GetHide()) then
		self.head:SetVisible(false)
	end
end

function PANEL:GetHide()
	return self.s_hide
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting a background image :--:--:--:--:--:--:--:--:--:--:--:}>                                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetImage(arg)
	local jv = jv()
    if not (isstring(arg)) then return end
    if (string.StartWith(arg, "https")) then
        jv.UrlImage(arg, function(mat)
            if (mat) then
                self.image = mat
                return
            else
                return
            end
        end)
    else
        self.image = arg
    end
end

function PANEL:GetImage()
    return self.image
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the close button icon :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetIcon()
	--[*] we do nothing
	return false
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the color of a background image :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetColor(arg1, arg2)
    self.image_clr = arg1
    if (arg2) then self.image_alpha = arg2 end
end

function PANEL:GetColor()
    return self.image_clr
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Controlling the transparency of the background image and body :--:--:--:--:--:--:--:--:--:--:--:}>      |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetColorAlpha(arg)
    self.color_alpha = arg
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint(w, h)
	local jv, clr = jv(), clr()
	local size_head = 60
	local border = jv.GetBorder("pnl")
	local round = jv.GetRound("base")
	local img_p_x, img_p_y, img_w_y, img_h_y = 0, 0, 0, 0
	img_h_y = math.ceil(size_head/2)
	img_p_y = img_h_y
	if not (self:GetHide()) then self.color_alpha = 0 end

	--[*] Body (BG)
	draw.RoundedBoxEx(round, 0, 0, w, h, ColorAlpha(clr["line"], self.color_alpha), true, true, false, false)
	draw.RoundedBoxEx(round, border/2, border/2, w-border, h-border, ColorAlpha(clr["bg"], self.color_alpha), true, true, false, false)

	--[*] BG Image
    if (self:GetImage()) then
        surface.SetMaterial(Material(self:GetImage()))
        surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
        surface.DrawTexturedRect(img_p_x+(border/2), img_p_y+(border/2), w-img_w_y-border, h-img_h_y-border) 
    end	
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Executed when the screen resolution changes :--:--:--:--:--:--:--:--:--:--:--:}>                        |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnScreenSizeChanged(old_w, old_h, new_w, new_h)
	--[*] adapting the element size to screen resolutions
	local arg = self.cust_size
	if not (arg) then return end
	self:SetSize(new_w*arg[1], new_h*arg[2])

	local pos_x, pos_y = self:GetPos()
	local new_x, new_y = new_w*(pos_x/old_w), new_h*(pos_y/old_h)
	self:SetPos(new_x, new_y)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.frame-main", PANEL, "DFrame")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 