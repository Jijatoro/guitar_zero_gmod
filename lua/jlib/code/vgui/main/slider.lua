--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-18"
    },
    ["anime"] = {
        txt = "a3-18"
    },
    ["fantasy"] = {
        txt = "f1-18"
    },
    ["cyber"] = {
        txt = "c2-18"
    },    
    ["horror"] = {
        txt = "h4-18"
    },
    ["terminal"] = {
        txt = "s1-18"
    } 
}

AccessorFunc( PANEL, "m_fDefaultValue", "DefaultValue" )

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
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "round"
    self.pnlname = nil

    self.TextArea:Remove()
    self.TextArea = jlib.vgui.Create("textentry", self)
    self.TextArea:Dock(RIGHT)
    self.TextArea:DockMargin(4, 4, 4, 4)
    self.TextArea:SetType("none")
    self.TextArea:SetWide(60)
    self.TextArea:SetNumeric(true)
    self.TextArea.OnChange = function(textarea, val) self:SetValue( self.TextArea:GetText() ) end

    self.Slider:Remove()
    self.Slider = vgui.Create("DSlider", self)
    self.Slider:SetLockY(0.5)
    self.Slider.TranslateValues = function(slider, x, y) return self:TranslateSliderValues( x, y ) end
    self.Slider:SetTrapInside( true )
    self.Slider:Dock(FILL)
    self.Slider:SetHeight(16)
    self.Slider.ResetToDefaultValue = function(s)
        self:ResetToDefaultValue()
    end
    self.Slider.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, h*0.48, w, 2, clr()["line"])
    end
     self.Slider.Knob:SetSize(8, 25)
    self.Slider.Knob.Paint = function(self, w, h)
        if (self.Hovered) then
            draw.RoundedBox(8, 0, 0, w, h, clr()["btn_line_h"])
        else
            draw.RoundedBox(8, 0, 0, w, h, clr()["btn_line"])
        end
    end

    self.Label:Remove()
    self.Label = jlib.vgui.Create("label", self)
    self.Label:Dock(LEFT)
    self.Label:DockMargin(10, 0, 0, 3)
    self.Label:SetMouseInputEnabled(true)
    self.Label:SetFont(jlib.vgui.GetFont(data_font, "txt"))

    self.Scratch:Remove()
    self.Scratch = self.Label:Add("DNumberScratch")
    self.Scratch:SetImageVisible(false)
    self.Scratch:Dock(LEFT)
    self.Scratch.OnValueChanged = function() self:ValueChanged(self.Scratch:GetFloatValue()) end  
    self.Scratch:SetVisible(false)

    self:SetTall(32)
    self:SetMin(0)
    self:SetMax(1)
    self:SetDecimals(2)
    self:SetText("")
    self:SetValue(0)
    self:SetSize(230, 40)
    self:SetDecimals(0)
    self.Wang = self.Scratch
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
        draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])
    end 
end

vgui.Register("jlib.slider-main", PANEL, "DNumSlider")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 