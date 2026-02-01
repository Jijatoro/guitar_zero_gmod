--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-24"
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
        txt = "t3-24"
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
    self.name:SetFont(jlib.vgui.GetFont(data_font, "txt"))

    self.range = jlib.vgui.Create("panel", self.panel)
    self.range:Dock(TOP)
    self.range:DockMargin(10, 6, 10, 0)
    self.range.Paint = function(self, w, h)
        local parent = self:GetParent():GetParent()
        local p_w, p_h = parent:GetSize()
        local p_w = p_w - 20
        local w_pr = math.Round((p_w*parent:GetProgress())/100)
        draw.RoundedBox(32, 0, 0, p_w, h, clr()["btn_line_h"])
        draw.RoundedBox(32, 3, 3, p_w-6, h-6, clr()["checkbox"])
        draw.RoundedBox(32, 3, 3, w_pr-6, h-6, clr()["progress"])
    end

    self.count = jlib.vgui.Create("label", self.range)
    self.count:Dock(TOP)
    self.count:DockMargin(0, 1, 0, 0)
    self.count:SetText("")
    self.count:SetContentAlignment(5)
    self.count:SetFont(jlib.vgui.GetFont(data_font, "txt"))
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