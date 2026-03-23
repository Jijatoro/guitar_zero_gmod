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
local all_typs = {"base", "round"}
local bool_typs = {["base"] = true, ["round"] = true}
AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

--------------------------------------------------------------------------------------------------------------|>
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.truename = "dscroll"
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self:Adjust()
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
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint(w, h)
    --[*] we don't draw anything
    return false
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Adapting elements :--:--:--:--:--:--:--:--:--:--:--:}>                                                  |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Adjust()
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("pnl")

    --[*] slider panel
    self.sbar = self:GetVBar()

    local size_x, size_y = self:GetSize()
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
    self.sbar:SetWide(border)

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


    self.sbar.Paint = function(self, w, h)
        local round = jv.GetRound("weak")    
        draw.RoundedBox(round, 0, 0, w, h, ColorAlpha(clr["scroll_bg"], 250))
    end    

    --[*] slider
    self.sbar.btnGrip.Paint = function(self, w, h)
        local round = jv.GetRound("weak")
        draw.RoundedBox(round, 0, 0, w, h, clr["scroll_grip"])
    end

    table.insert(jv["current_scrolls"], self.sbar)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.dscroll-main", PANEL, "DScrollPanel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 