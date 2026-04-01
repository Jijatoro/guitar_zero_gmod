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
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local jv, clr = jv(), clr()
    self.truename = "key"
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self.value = 0
    self.text = ""
    self.pnltype = "none"    

    self.string = jlib.vgui.Create("label", self)
    self.string:SetText(self:GetText())
    jv.SetFont(self.string, "p1", true)
    self.string:Scale(0.5, 0.5)
    self.string:Dock(LEFT)
    self.string:Margin(0.005, 0, 0.005, 0)
    self.string:SetContentAlignment(4)  

    self.key = jlib.vgui.Create("dbinder", self)
    self.key:SetValue(self:GetValue())
    self.key:Scale(0.5, 0.9)
    jv.SetFont(self.key, "btn2", true)
    self.key:SetTooltip(nil)
    self.key:Dock(RIGHT)
    self.key:Margin(0, 0.1, 0, 0.1)  

    jv.SetTip(self.key, lan()["tip-for-bind"], true)
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
    jv["Scale"](self, data)
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
    if (data) and not (table.IsEmpty(data)) then self.dockmargin = data end
    jv["Margin"](self, data)
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
--[+] Management type (appearance) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetType(type)
    self.pnltype = type
end

function PANEL:GetType()
    return self.pnltype
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting the text (description of what the button is for) :--:--:--:--:--:--:--:--:--:--:--:}>           |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetText(val)
    self.text = val
    if (val == "") then self.string:Remove() self.key:Dock(FILL) self.key:Size(1, 1) return end 
    self.string:SetText(val)
end

function PANEL:GetText()
    return self.text
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Set value (key name) :--:--:--:--:--:--:--:--:--:--:--:}>                                               |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetValue(val)
    self.value = val
    self.key:SetValue(val)
end

function PANEL:GetValue()
    return self.key:GetValue()
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
    else end     
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.key-main", PANEL, "DPanel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 