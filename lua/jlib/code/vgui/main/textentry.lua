--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
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
        txt = "t1-24"
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
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self:SetSize(240, 40)
    self:SetHistoryEnabled(false)
    self.History = {}
    self.HistoryPos = 0
    self:SetPaintBorderEnabled(false)
    self:SetPaintBackgroundEnabled(false)
    self:SetDrawBorder(true)
    self:SetPaintBackground(true)
    self:SetEnterAllowed(true)
    self:SetUpdateOnType(false)
    self:SetNumeric(false)
    self:SetAllowNonAsciiCharacters(true)
    self.m_bLoseFocusOnClickAway = false
    self:SetCursor("beam")
    self:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.type = "base"
    self.m_txtPlaceholder = lan()["text"] .. "..."
    self.pnlname = lan()["oops"] or "?"
    self.minmax = nil
end

function PANEL:SetType(arg)
    self.type = arg
end

function PANEL:GetType()
    return self.type
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

function PANEL:SetName(arg)
    self.pnlname = arg
end

function PANEL:GetName(arg)
    return self.pnlname
end

function PANEL:SetMinMax(min, max)
    self.minmax = {min = min, max = max}
end

function PANEL:GetMinMax(arg)
    return self.minmax
end

function PANEL:Paint( w, h )
    if (self.type == "base") then
        draw.RoundedBox(0, 0, 0, w, h, clr()["btn_line_h"])
        draw.RoundedBox(0, 1, 1, w-2, h-2, clr()["btn_h"])
    end

    if (self:GetValue() == "") or (self:GetValue() == nil) and (self.type == "base") then
        draw.DrawText(self.m_txtPlaceholder, jlib.vgui.GetFont(data_font, "txt"), 8, 8, clr()["t_p1"], TEXT_ALIGN_LEFT)
    else
        surface.SetDrawColor(255, 255, 255, 0)
        surface.DrawRect(0, 0, w, h)
        self:SetTextColor(clr()["t_btn_h"])
        self:SetHighlightColor(clr()["t_mark"])
        self:SetCursorColor(clr()["t_btn_h"])
        self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor())
    end
end

function PANEL:OnMousePressed( mcode )
    if (not self:IsEnabled()) then return end
    if ( mcode == MOUSE_LEFT ) then
        self:OnGetFocus()
    end
end

vgui.Register("jlib.textentry-main", PANEL, "DTextEntry")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 