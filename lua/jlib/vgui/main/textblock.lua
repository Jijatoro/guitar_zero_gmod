--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-24"
    },
    ["anime"] = {
        txt = "s1-24"
    },
    ["fantasy"] = {
        txt = "s1-24"
    },
    ["cyber"] = {
        txt = "s1-24"
    },    
    ["horror"] = {
        txt = "s1-24"
    },
    ["terminal"] = {
        txt = "t5-24"
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

function PANEL:Paint( w, h )
    if (self:GetHide()) then
        draw.RoundedBox(0, 0, 0, w, h, clr()["btn_line_h"])
        draw.RoundedBox(0, 1, 1, w-2, h-2, clr()["btn_h"])
    end

    surface.SetDrawColor(255, 255, 255, 0)
    surface.DrawRect(0, 0, w, h)
    self:SetTextColor(clr()["t_btn_h"])
    self:SetHighlightColor(clr()["t_mark"])
    self:SetCursorColor(clr()["t_btn_h"])
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