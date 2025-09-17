local PANEL = {}

function PANEL:Init()
    self:SetHistoryEnabled( false )
    self.History = {}
    self.HistoryPos = 0
    self:SetPaintBorderEnabled( false )
    self:SetPaintBackgroundEnabled( false )
    self:SetDrawBorder( true )
    self:SetPaintBackground( true )
    self:SetEnterAllowed( true )
    self:SetUpdateOnType( false )
    self:SetNumeric( false )
    self:SetAllowNonAsciiCharacters( true )
    self:SetTall( 20 )
    self.m_bLoseFocusOnClickAway = false
    self:SetCursor( "beam" )
    self:SetFont( "Merry.p1" )

    self:SetSize(240, 50)
    self.status = true

    self.m_txtPlaceholder = "Текст..."
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

function PANEL:Paint( w, h )
    local theme = Merry.Themes[Merry.Theme]
    
    if (self.status) then
        draw.RoundedBox(0, 0, 0, w, h, theme["btn_line_hover"])
        draw.RoundedBox(0, 3, 3, w-6, h-6, theme["btn_hover"])
    end

    if (self:GetValue() == "") or (self:GetValue() == nil) then
        draw.DrawText(self.m_txtPlaceholder, "Merry.p1", 8, 10, theme["title_btn_hover"], TEXT_ALIGN_LEFT)
    else
        self:DrawTextEntryText(theme["title_p1"], theme["btn_hover"], Color(255, 255, 255))
    end
end

function PANEL:OnMousePressed( mcode )
    if (not self:IsEnabled()) then return end
    if ( mcode == MOUSE_LEFT ) then
        self:OnGetFocus()
    end
end

vgui.Register("MerryUI.TextEntry", PANEL, "DTextEntry")