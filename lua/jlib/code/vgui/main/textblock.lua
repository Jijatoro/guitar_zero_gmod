--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end
local data_font = {
    ["main"] = {
        txt = "s5-24"
    },
    ["anime"] = {
        txt = "a3-24"
    },
    ["fantasy"] = {
        txt = "f1-24"
    },
    ["cyber"] = {
        txt = "c2-24"
    },    
    ["horror"] = {
        txt = "h4-24"
    },
    ["terminal"] = {
        txt = "t3-32"
    } 
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
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
    self:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self:SetEnabled(false)
    self:SetMultiline(true)
    self:SetVerticalScrollbarEnabled(true)
    self.sethide = false
    self:SetSize(400, 400)
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
    local c = clr()
    if (self:GetHide()) then
        draw.RoundedBox(0, 0, 0, w, h, c["btn_line_h"])
        draw.RoundedBox(0, 1, 1, w-2, h-2, c["btn_h"])
    end

    surface.SetDrawColor(255, 255, 255, 0)
    surface.DrawRect(0, 0, w, h)
    self:SetTextColor(c["t_btn_h"])
    self:SetHighlightColor(c["t_mark"])
    self:SetCursorColor(c["t_btn_h"])
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