--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}

AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

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
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "base"
    self.pnlvalue = nil
    self.pnlname = nil

    self.sbar = self:GetVBar()
    self.sbar.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, ColorAlpha(clr()["scroll_bg"], 250))
    end
    self.sbar.btnGrip.Paint = function(self, w, h)
        draw.RoundedBox(64, 0, 0, w, h, clr()["scroll_grip"])
    end

    self:Adjust()
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetName(arg)
    self.pnlname = arg
end

function PANEL:GetName(arg)
    return self.pnlname
end

function PANEL:Paint(w, h)
    if (self:GetType() == "base") then
        draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["body"])
    elseif (self:GetType() == "round") then
        draw.RoundedBox(8, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(8, 3, 3, w-6, h-6, clr()["body"])
    end 
end

function PANEL:Adjust()
    self.sbar:SetSize(6, 6)
    self.sbar:DockMargin(0, 0, 0, 0)

    self.sbar.PerformLayout = function()
        local Wide = self.sbar:GetWide()
        local BtnHeight = 0
        if ( self.sbar:GetHideButtons() ) then BtnHeight = 0 end
        local Scroll = self.sbar:GetScroll() / self.sbar.CanvasSize
        local BarSize = math.max( self.sbar:BarScale() * ( self.sbar:GetTall() - ( BtnHeight * 2 ) ), 10 )
        local Track = self.sbar:GetTall() - ( BtnHeight * 2 ) - BarSize
        Track = Track + 1

        Scroll = Scroll * Track

        self.sbar.btnGrip:SetPos( 0, Scroll)
        self.sbar.btnGrip:SetSize( Wide, BarSize )

        self.sbar.btnUp:SetSize(0, 0)
        self.sbar.btnDown:SetSize(0, 0)
    end

    self.sbar.OnCursorMoved = function(lx, ly)
        if ( !self.sbar.Enabled ) then return end
        if ( !self.sbar.Dragging ) then return end

        local x, y = self.sbar:ScreenToLocal( 0, gui.MouseY() )

        y = y - 0
        y = y - self.sbar.HoldPos

        local BtnHeight = self.sbar:GetWide()
        if ( self.sbar:GetHideButtons() ) then BtnHeight = 0 end

        local TrackSize = self.sbar:GetTall() - BtnHeight * 2 - self.sbar.btnGrip:GetTall()

        y = y / TrackSize

        self.sbar:SetScroll( y * self.sbar.CanvasSize )
    end

end

vgui.Register("jlib.scroll-main", PANEL, "DScrollPanel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 