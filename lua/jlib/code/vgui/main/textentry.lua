--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end
local function lan() return jlib.cfg.lans[jlib.cfg.lan] or {} end
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
        txt = "t1-32"
    } 
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local l = lan()
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
    self.m_txtPlaceholder = l["text"] .. "..."
    self.pnlname = l["oops"] or "?"
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
    local c = clr()
    if (self.type == "base") then
        draw.RoundedBox(0, 0, 0, w, h, c["btn_line_h"])
        draw.RoundedBox(0, 1, 1, w-2, h-2, c["btn_h"])
    end

    if (self:GetValue() == "") or (self:GetValue() == nil) and (self.type == "base") then
        local text = self.m_txtPlaceholder
        surface.SetFont(jlib.vgui.GetFont(data_font, "txt"))
        local text_w, text_h = surface.GetTextSize(text)
        draw.DrawText(text, jlib.vgui.GetFont(data_font, "txt"), 3, h*0.5-(text_h*0.5), c["t_p1"], TEXT_ALIGN_LEFT)
    else
        surface.SetDrawColor(255, 255, 255, 0)
        surface.DrawRect(0, 0, w, h)
        self:SetTextColor(c["t_btn_h"])
        self:SetHighlightColor(c["t_mark"])
        self:SetCursorColor(c["t_btn_h"])
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