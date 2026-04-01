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
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local jv, clr = jv(), clr()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.isenable = true
    self.pnltype = "round"
    self.truename = "slider"

    self.mainbody = jlib.vgui.Create("panel", self)
    self.mainbody:Dock(BOTTOM)
    self.mainbody:Margin(0.01, 0, 0.01, 0.01)
    self.mainbody:SetType("none")
    self.mainbody:Scale(1, 0.7)    

    --[*] data entry window
    self.pnl_textarea = jlib.vgui.Create("panel", self.mainbody)
    self.pnl_textarea:Dock(RIGHT)
    self.pnl_textarea:Margin(0.005, 0, 0.005, 0)
    self.pnl_textarea:SetType("none")
    self.pnl_textarea:Scale(0.13, 0.8)

    self.TextArea:Remove()
    self.TextArea = jlib.vgui.Create("textentry", self.pnl_textarea)
    self.TextArea:Dock(FILL)
    self.TextArea:Margin(0, 0.05, 0, 0)
    self.TextArea:SetType("none")
    self.TextArea:SetNumeric(true)
    self.TextArea:SetEnabled(false)
    self.TextArea.OnChange = function(textarea, val) self:SetValue(self.TextArea:GetText()) end

    --[*] slider
    self.Slider:Remove()
    self.Slider = vgui.Create("DSlider", self.mainbody)
    --[*] the slider itself
    function self.Slider:Scale(...) 
        local data = {...}
        jv["Scale"](self, data)
    end

    function self.Slider:Margin(...)
        local data = {...}
        jv["Margin"](self, data)
    end

    self.Slider:SetLockY(0.5)
    self.Slider.TranslateValues = function(slider, x, y) return self:TranslateSliderValues(x, y) end
    self.Slider:SetTrapInside(true)
    self.Slider:Dock(FILL)
    self.Slider:Margin(0.01, 0, 0.01, 0)
    local perf = self.Slider.PerformLayout
    self.Slider.PerformLayout = function(body, w, h)
        perf(body, w, h)
        if not (body.dockmargin) then return end
        body:Margin()              
    end    
    self.Slider.ResetToDefaultValue = function(s) self:ResetToDefaultValue() end
    self.Slider.Paint = function(slider, w, h)
        local min, max = self:GetMin(), self:GetMax()
        local val = self:GetValue()
        local progress = ((val-min)/(max-min))*w
        draw.RoundedBox(0, 0, h*0.48, w, 2, clr["slider"])
        draw.RoundedBox(0, 0, h*0.48, progress, 2, clr["slider_b"]) 
    end

    --[*] the slider we use to drag the mouse
    function self.Slider.Knob:Scale(...) 
        local data = {...}
        jv["Scale"](self, data)
    end

    function self.Slider.Knob:Margin(...)
        local data = {...}
        if (data) and not (table.IsEmpty(data)) then self.dockmargin = data end
        jv["Margin"](self, data)
    end

    local knob_playout = self.Slider.Knob.PerformLayout
    function self.Slider.Knob:PerformLayout()
        local s_x, s_y = self:GetSize()
        knob_playout(self, s_x, s_y)
        if not (self) then return end
        self:Margin()
    end    

    self.Slider.Knob:Scale(0.02, 0.6)
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

    --[*] main text (what does the slider change?)
    self.Label:Remove()
    self.Label = jlib.vgui.Create("label", self)
    self.Label:Dock(TOP)
    self.Label:SetContentAlignment(5)
    self.Label:Margin(0.01, 0.1, 0, 0)
    self.Label:Scale(1, 0.3)
    self.Label:SetMouseInputEnabled(true)
    jv.SetFont(self.Label, "p2", true)

    --[*] the rest
    self.Scratch:Remove()
    self.Scratch = self.Label:Add("DNumberScratch")
    self.Scratch:SetImageVisible(false)
    self.Scratch:Dock(LEFT)
    self.Scratch.OnValueChanged = function() self:ValueChanged(self.Scratch:GetFloatValue()) end  
    self.Scratch:SetVisible(false)

    self:SetMin(0)
    self:SetMax(1)
    self:SetDecimals(2)
    self:SetText("")
    self:SetValue(0)
    self:SetDecimals(0)
    self.Wang = self.Scratch
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
--[+] Scaling in percentages (custom) :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Scale(...)
    local jv = jv()
    local data = {...}
    jv.Scale(self, data)
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
    if (data) and not (table.IsEmpty(data)) then self.dockmargin = data end
    jv.Margin(self, data)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Fires on every resize :--:--:--:--:--:--:--:--:--:--:--:}>                                              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:PerformLayout()
    --[*] adapt the sizes
    if not (self.dockmargin) then return end
    self:Margin()
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting the type for different appearances :--:--:--:--:--:--:--:--:--:--:--:}>                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the ability to change data :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Enable(arg)
    self.isenable = arg
    self.Slider:SetVisible(arg)
    self.TextArea:SetVisible(arg)
    if (arg) then 
        self:SetAlpha(255) 
        self:SetCursor("arrow")
        for _, v in ipairs(self:GetChildren()) do
            v:SetCursor("arrow")
        end
    else 
        self:SetAlpha(150) 
        self:SetCursor("no") 
        for _, v in ipairs(self:GetChildren()) do
            v:SetCursor("no")
        end
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.slider-main", PANEL, "DNumSlider")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 