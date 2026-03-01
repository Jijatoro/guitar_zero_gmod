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
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local jv = jv()
    self.truename = "textblock"
    self:SetHistoryEnabled(false)
    self.History = {}
    self.HistoryPos = 0
    self:SetPaintBorderEnabled(false)
    self:SetPaintBackgroundEnabled(false)
    self:SetDrawBorder( true )
    self:SetPaintBackground( true )
    self:SetEnterAllowed(true)
    self:SetUpdateOnType(false)
    self:SetNumeric(false)
    self:SetAllowNonAsciiCharacters(true)
    self:SetTall( 20 )
    self.m_bLoseFocusOnClickAway = false
    self:SetCursor("beam")
    jv.SetFont(self, "btn1", true)
    self:SetEnabled(false)
    self:SetMultiline(true)
    self:SetVerticalScrollbarEnabled(true)
    self.sethide = false
    self:SetSize(400, 400)
end

function PANEL:SetName(arg)
    self.truename = arg
end

function PANEL:GetName()
    return self.truename
end

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

function PANEL:PerformLayout()
    if not (self.dockmargin) then return end
    self:Margin()
end

function PANEL:GetTextColor()
    return self.m_colText
end

function PANEL:GetPlaceholderColor()
    return self.m_colPlaceholder
end

function PANEL:GetHighlightColor()
    return self.m_colHighlight
end

function PANEL:GetCursorColor()
    return self.m_colCursor
end

function PANEL:SetHide(val)
    self.sethide = val
end

function PANEL:GetHide()
    return self.sethide
end

function PANEL:SetDraw(val)
    self.sethide = val
end

function PANEL:SetType(val)
    self.sethide = val
end

function PANEL:Paint( w, h )
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("btn")
    if (self:GetHide()) then
        draw.RoundedBox(0, 0, 0, w, h, clr["btn_line_h"])
        draw.RoundedBox(0, border/2, border/2, w-border, h-border, clr["btn_h"])
    end

    surface.SetDrawColor(255, 255, 255, 0)
    surface.DrawRect(0, 0, w, h)
    self:SetTextColor(clr["t_btn_h"])
    self:SetHighlightColor(clr["t_mark"])
    self:SetCursorColor(clr["t_btn_h"])
    self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor())
end

function PANEL:OnMousePressed(mcode)
    if (not self:IsEnabled()) then return end
    if ( mcode == MOUSE_LEFT ) then
        self:OnGetFocus()
    end
end

vgui.Register("jlib.textblock-main", PANEL, "DTextEntry")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 