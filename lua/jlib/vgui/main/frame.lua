--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-32"
    },
    ["anime"] = {
        txt = "a3-32"
    },
    ["fantasy"] = {
        txt = "f6-32"
    },
    ["cyber"] = {
        txt = "c1-24"
    },    
    ["horror"] = {
        txt = "h2-48"
    },
    ["terminal"] = {
        txt = "t10-24"
    } 
}

local function icon()
    return jlib.cfg.icons[jlib.cfg.icon]  or {}
end

local function clr()
    return jlib.cfg.themes[jlib.cfg.theme]  or {}
end

local function lan()
    return jlib.cfg.lans[jlib.cfg.lan] or {}
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.head_text = lan()["main-menu"]
	self.text_x = 0
	self.s_hide = true
	self:SetDraggable(true)
	self:SetSizable(false)
	self:SetScreenLock(true)
	self:SetMinWidth( 50 )
	self:SetMinHeight( 50 )
	self:SetPaintBackgroundEnabled(false)
	self:SetPaintBorderEnabled(false)
	self.m_fCreateTime = SysTime()

    self.image = nil
    self.image_alpha = 255
    self.image_clr = Color(255, 255, 255)	

	self.btnClose:Remove()
	self.btnMaxim:Remove()
	self.btnMinim:Remove()
	self.lblTitle:Remove()

	self.head = jlib.vgui.Create("panel", self)
	self.head:SetSize(0, 60)
	self.head:Dock(TOP)
	self.head:DockMargin(0, -28, 0, 0)
	self.head:DockPadding(0, 7, 0, 7)
	self.head:SetType("nodraw")
	local size_x, size_y = self.head:GetSize()

	self.btn = jlib.vgui.Create("button", self.head)
	self.btn:SetSize(45, 45)
	self.btn:SetImage("close")
	self.btn:Dock(RIGHT)
	self.btn:DockMargin(0, 0, 5, 0)
	self.btn:SetSound("close")
	self.btn.DoClick = function()
		self:Close()
	end

	self.text = jlib.vgui.Create("label", self.head)
	self.text:SetText(self:GetText())
	self.text:SetFont(jlib.vgui.GetFont(data_font, "txt"))
	self.text:Dock(FILL)
	self.text:DockMargin(0, 0, -60, 0)
	self.text:SetContentAlignment(5)

	self:Alpha()
end

function PANEL:ShowCloseButton(bool)
	self.btn:SetVisible(bool)

	if not (bool) then
		self.text:DockMargin(0, 0, -25, 0)
	end
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

function PANEL:SetImage(arg)
    if not (isstring(arg)) then return end
    if (string.StartWith(arg, "https")) then
        jlib.UrlImage(arg, function(mat)
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

function PANEL:SetColor(arg1, arg2)
    self.image_clr = arg1
    if (arg2) then self.image_alpha = arg2 end
end

function PANEL:GetColor()
    return self.image_clr
end










local function mask(self, w, h)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawRect(0, 0, 100, 100)	
end

local function image(self, w, h)
    surface.SetMaterial(Material(self:GetImage()))
    surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
    surface.DrawTexturedRect(0, 0, 100, 100) 	
end

function PANEL:Paint(w, h)
	local alpha = 255
	local size_head = 60
	local ad_pos, ad_size = 3, 6
	local img_p_x, img_p_y, img_w_y, img_h_y = 0, 0, 0, 0
	img_h_y = math.ceil(size_head/2)
	img_p_y = img_h_y
	if not (self:GetHide()) then alpha = 0 end

	--[*] Body (BG)
	draw.RoundedBoxEx(32, 0, 0, w, h, ColorAlpha(clr()["line"], alpha), true, true, false, false)
	draw.RoundedBoxEx(32, ad_pos, ad_pos, w-ad_size, h-ad_size, ColorAlpha(clr()["bg"], alpha), true, true, false, false)

	--[*] BG Image
    if (self:GetImage()) then
        surface.SetMaterial(Material(self:GetImage()))
        surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
        surface.DrawTexturedRect(img_p_x+ad_pos, img_p_y+ad_pos, w-img_w_y-ad_size, h-img_h_y-ad_size) 
    end	

    --[*] Head
    draw.RoundedBox(32, 0+1, 0+1, (w-2), size_head, ColorAlpha(clr()["line"]), alpha)
	draw.RoundedBox(32, ad_pos+1, ad_pos+1, (w-2)-ad_size, size_head-ad_size, ColorAlpha(clr()["head"]), alpha)
end

function PANEL:PerformLayout()
	return false
end

function PANEL:SetIcon()
	return false
end

vgui.Register("jlib.frame-main", PANEL, "DFrame")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 