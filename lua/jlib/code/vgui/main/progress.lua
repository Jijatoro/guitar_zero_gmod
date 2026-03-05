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
    local jv, clr = jv(), clr()
    self.truename = "progress"
    self.value = 0
    self.progress = 0
    self.max = 0
    self.text = ""
    self:SetSize(290, 75)

    self.panel = jlib.vgui.Create("panel", self)
    self.panel:Dock(FILL)
    self.panel:SetType("round")

    self.name = jlib.vgui.Create("label", self.panel)
    self.name:Dock(TOP)
    self.name:DockMargin(0, 3, 0, 0)
    self.name:SetText(self.text)
    self.name:SetContentAlignment(5)
    jv.SetFont(self.name, "p1", true)

    self.range = jlib.vgui.Create("panel", self.panel)
    self.range:Dock(TOP)
    self.range:DockMargin(10, 6, 10, 0)
    self.range.Paint = function(self, w, h)
        local border = jv.GetBorder("pnl")
        local round = jv.GetRound("base")
        local parent = self:GetParent():GetParent()
        local p_w, p_h = parent:GetSize()
        local p_w = p_w - 20
        local w_pr = math.Round((p_w*parent:GetProgress())/100)
        draw.RoundedBox(round, 0, 0, p_w, h, clr["btn_line_h"])
        draw.RoundedBox(round, border/2, border/2, p_w-border, h-border, clr["checkbox"])
        draw.RoundedBox(round, border/2, border/2, w_pr-border, h-border, clr["progress"])
    end

    self.count = jlib.vgui.Create("label", self.range)
    self.count:Dock(TOP)
    self.count:DockMargin(0, 1, 0, 0)
    self.count:SetText("")
    self.count:SetContentAlignment(5)
    j.SetFont(self.count, "p1", true)
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

local function UpdateCount(p)
    p.count:SetText(tostring(p:GetValue()) .. "/" .. tostring(p:GetMax()))
end

function PANEL:SetText(val)
    self.text = val
    self.name:SetText(val)
end

function PANEL:GetText()
    return self.text
end

function PANEL:SetMax(val)
    self.max = val
    UpdateCount(self)
end

function PANEL:GetMax()
    return self.max
end

function PANEL:SetProgress()
    if (self.max == 0) then self.progress = 0 return end
    if (self.value >= self.max) then self.progress = 100 else self.progress = math.Round((self.value/self.max)*100) end
end

function PANEL:GetProgress()
    return self.progress
end

function PANEL:SetValue(val)
    self.value = val
    self:SetProgress()
    UpdateCount(self)
end

function PANEL:GetValue()
    return self.value
end

function PANEL:Paint()
    return
end

vgui.Register("jlib.progress-main", PANEL, "DPanel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 