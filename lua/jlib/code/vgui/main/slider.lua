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
AccessorFunc(PANEL, "m_fDefaultValue", "DefaultValue")

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local jv, clr = jv(), clr()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "round"
    self.truename = "slider"

    self.TextArea:Remove()
    self.TextArea = jlib.vgui.Create("textentry", self)
    self.TextArea:Dock(RIGHT)
    self.TextArea:Margin(0.01, 0.06, 0, 0.06)
    self.TextArea:SetType("none")
    self.TextArea:Scale(0.13, 0.8)
    self.TextArea:SetNumeric(true)
    self.TextArea.OnChange = function(textarea, val) self:SetValue( self.TextArea:GetText() ) end

    self.Slider:Remove()
    self.Slider = vgui.Create("DSlider", self)
    self.Slider:SetLockY(0.5)
    self.Slider.TranslateValues = function(slider, x, y) return self:TranslateSliderValues( x, y ) end
    self.Slider:SetTrapInside(true)
    self.Slider:Dock(FILL)
    jv.Scale(self.Slider, {0.5, 0.8})
    local perf = self.Slider.PerformLayout
    self.Slider.PerformLayout = function(body, w, h)
        perf(body, w, h)
        if (body.dockmargin) then
            jv.Margin(body, {0.1, 0.06, 0.1, 0.06})
        end        
    end    
    self.Slider.ResetToDefaultValue = function(s)
        self:ResetToDefaultValue()
    end

    self.Slider.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, h*0.48, w, 2, clr["line"])
    end

    --[*] the slider we use to drag the mouse
    function self.Slider.Knob:Scale(...) 
        local data = {...}
        jv["Scale"](self, data)
    end

    function self.Slider.Knob:Margin(...)
        local data = {...}
        jv["Margin"](self, data)
    end

    local knob_playout = self.Slider.Knob.PerformLayout
    function self.Slider.Knob:PerformLayout()
        local s_x, s_y = self:GetSize()
        knob_playout(self, s_x, s_y)
        if not (self) then return end
        self:Margin()
    end    

    self.Slider.Knob:Scale(0.05, 0.5)
    self.Slider.Knob:Margin(0, 0, 0, 0)
    self.Slider.Knob:SetSize(8, 25)
    self.Slider.Knob.Paint = function(self, w, h)
        local round = jv.GetRound("weak")
        if (self.Hovered) then
            draw.RoundedBox(round, 0, 0, w, h, clr["btn_line_h"])
        else
            draw.RoundedBox(round, 0, 0, w, h, clr["btn_line"])
        end
    end

    self.Label:Remove()
    self.Label = jlib.vgui.Create("label", self)
    self.Label:Dock(LEFT)
    self.Label:Margin(0.05, 0.06, 0, 0.06)
    self.Label:Scale(0.35, 0.8)
    self.Label:SetMouseInputEnabled(true)
    jv.SetFont(self.Label, "p2", true)

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

function PANEL:SetName(arg)
    self.truename = arg
end

function PANEL:GetName()
    return self.truename
end

function PANEL:Scale(...)
    local jv = jv()
    local data = {...}
    jv.Scale(self, data)
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
    jv.Margin(self, data)
end

function PANEL:PerformLayout()
    if not (self.dockmargin) then return end
    self:Margin()
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:Paint(w, h)
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("pnl")
    local round = jv.GetRound("base")
    if (self:GetType() == "base") then
        draw.RoundedBox(0, 0, 0, w, h, clr["line"])
        draw.RoundedBox(0, border/2, border/2, w-border, h-border, clr["body"])
    elseif (self:GetType() == "round") then
        draw.RoundedBox(round, 0, 0, w, h, clr["line"])
        draw.RoundedBox(round, border/2, border/2, w-border, h-border, clr["body"])
    end 
end

vgui.Register("jlib.slider-main", PANEL, "DNumSlider")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 