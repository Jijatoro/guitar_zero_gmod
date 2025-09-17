local PANEL = {}

AccessorFunc( PANEL, "m_fDefaultValue", "DefaultValue" )

function PANEL:Init()

    self.TextArea = self:Add( "MerryUI.Label" )
    self.TextArea:Dock( RIGHT )
    self.TextArea:SetWide(50)

    self.Slider = self:Add( "MerryUI.Slider", self )
    self.Slider:SetLockY( 0.5 )
    self.Slider.TranslateValues = function( slider, x, y ) return self:TranslateSliderValues( x, y ) end
    self.Slider:SetTrapInside( true )
    self.Slider:Dock( FILL )
    self.Slider:SetHeight( 14 )
    self.Slider.ResetToDefaultValue = function( s )
        self:ResetToDefaultValue()
    end

    self.Slider.Paint = function(self, w, h )
        local theme = Merry.Themes[Merry.Theme]
        draw.RoundedBox(10, 0, 0, w, h, theme["slider_border"]) 
        draw.RoundedBox(10, 2, 2, w-4, h-4, theme["slider"])
    end

    self.Label = vgui.Create ( "DLabel", self )
    self.Label:Dock( LEFT )
    self.Label:SetMouseInputEnabled( true )

    self.Scratch = self.Label:Add( "MerryUI.Scratch" )
    self.Scratch:SetImageVisible( true )
    self.Scratch:Dock( FILL )
    self.Scratch.OnValueChanged = function() self:ValueChanged( self.Scratch:GetFloatValue() ) end

    self:SetTall( 32 )

    self:SetMin( 0 )
    self:SetMax( 1 )
    self:SetDecimals( 2 )
    self:SetText( "" )
    self:SetValue( 0.5 )

    self.Wang = self.Scratch

end

function PANEL:SetMinMax( min, max )
    self.Scratch:SetMin( tonumber( min ) )
    self.Scratch:SetMax( tonumber( max ) )
    self:UpdateNotches()
    self:ValueChanged( self:GetValue() ) -- Update slider positon for the new range
end

function PANEL:ApplySchemeSettings()

    self.Label:ApplySchemeSettings()

    -- Copy the color of the label to the slider notches and the text entry
    local col = self.Label:GetTextStyleColor()
    if ( self.Label:GetTextColor() ) then col = self.Label:GetTextColor() end
    local theme = Merry.Themes[Merry.Theme]
    self.TextArea:SetTextColor(theme["title_h1"])

    local color = table.Copy( col )
    color.a = 100 -- Fade it out a bit so it looks right
    self.Slider:SetNotchColor( color )

end

function PANEL:SetDark( b )
    self.Label:SetDark( b )
    self:ApplySchemeSettings()
end

function PANEL:GetMin()
    return self.Scratch:GetMin()
end

function PANEL:GetMax()
    return self.Scratch:GetMax()
end

function PANEL:GetRange()
    return self:GetMax() - self:GetMin()
end

function PANEL:ResetToDefaultValue()
    if ( !self:GetDefaultValue() ) then return end
    self:SetValue( self:GetDefaultValue() )
end

function PANEL:SetMin( min )

    if ( !min ) then min = 0 end

    self.Scratch:SetMin( tonumber( min ) )
    self:UpdateNotches()
    self:ValueChanged( self:GetValue() ) -- Update slider positon for the new range

end

function PANEL:SetMax( max )

    if ( !max ) then max = 0 end

    self.Scratch:SetMax( tonumber( max ) )
    self:UpdateNotches()
    self:ValueChanged( self:GetValue() ) -- Update slider positon for the new range

end

function PANEL:SetValue( val )
    local result = math.floor(val)
    self.Scratch:SetValue(result) -- This will also call ValueChanged
    self.Scratch:SetFloatValue(result)
    self:ValueChanged(self:GetValue()) -- In most cases this will cause double execution of OnValueChanged
    self.TextArea:SetText(result)
end

function PANEL:GetValue()
    return self.Scratch:GetFloatValue()
end

function PANEL:SetDecimals( d )
    self.Scratch:SetDecimals( d )
    self:UpdateNotches()
    self:ValueChanged( self:GetValue() ) -- Update the text
end

function PANEL:GetDecimals()
    return self.Scratch:GetDecimals()
end

--
-- Are we currently changing the value?
--
function PANEL:IsEditing()
    return self.Scratch:IsEditing() || self.TextArea:IsEditing() || self.Slider:IsEditing()
end

function PANEL:IsHovered()
    return self.Scratch:IsHovered() || self.TextArea:IsHovered() || self.Slider:IsHovered() || vgui.GetHoveredPanel() == self
end

function PANEL:PerformLayout()
    self.Label:SetWide( self:GetWide() / 2.4 )
end

function PANEL:SetConVar( cvar )
    self.Scratch:SetConVar( cvar )
    self.TextArea:SetConVar( cvar )
end

function PANEL:SetText( text )
    self.Label:SetText( text )
end

function PANEL:GetText()
    return self.Label:GetText()
end

function PANEL:ValueChanged( val )
    val = math.Round(val)

    self.TextArea:SetText(val)

    self.Slider:SetSlideX( self.Scratch:GetFraction() )

    self:OnValueChanged( val )
    self:SetCookie( "slider_val", val )

end

function PANEL:LoadCookies()

    self:SetValue( self:GetCookie( "slider_val" ) )

end

function PANEL:OnValueChanged( val )

    -- For override

end

function PANEL:TranslateSliderValues( x, y )

    self:SetValue( self.Scratch:GetMin() + ( x * self.Scratch:GetRange() ) )

    return self.Scratch:GetFraction(), y

end

function PANEL:GetTextArea()

    return self.TextArea

end

function PANEL:UpdateNotches()

    local range = self:GetRange()
    self.Slider:SetNotches( nil )

    if ( range < self:GetWide() / 4 ) then
        return self.Slider:SetNotches( range )
    else
        self.Slider:SetNotches( self:GetWide() / 4 )
    end

end

function PANEL:SetEnabled( b )
    self.TextArea:SetEnabled( b )
    self.Slider:SetEnabled( b )
    self.Scratch:SetEnabled( b )
    self.Label:SetEnabled( b )
    FindMetaTable( "Panel" ).SetEnabled( self, b ) -- There has to be a better way!
end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

    local ctrl = vgui.Create( ClassName )
    ctrl:SetWide( 200 )
    ctrl:SetMin( 1 )
    ctrl:SetMax( 10 )
    ctrl:SetText( "Example Slider!" )
    ctrl:SetDecimals( 0 )

    PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "DNumSlider", "Menu Option Line", table.Copy( PANEL ), "Panel" )

-- No example for this fella
PANEL.GenerateExample = nil

function PANEL:PostMessage( name, _, val )

    if ( name == "SetInteger" ) then
        if ( val == "1" ) then
            self:SetDecimals( 0 )
        else
            self:SetDecimals( 2 )
        end
    end

    if ( name == "SetLower" ) then
        self:SetMin( tonumber( val ) )
    end

    if ( name == "SetHigher" ) then
        self:SetMax( tonumber( val ) )
    end

    if ( name == "SetValue" ) then
        self:SetValue( tonumber( val ) )
    end

end

function PANEL:PerformLayout()

    self.Scratch:SetVisible( false )
    self.Label:SetVisible( false )

    self.Slider:StretchToParent( 0, 0, 0, 0 )
    self.Slider:SetSlideX( self.Scratch:GetFraction() )

end

function PANEL:SetActionFunction( func )

    self.OnValueChanged = function( pnl, val ) func( pnl, "SliderMoved", val, 0 ) end

end

vgui.Register("MerryUI.SliderNum", PANEL, "Panel")