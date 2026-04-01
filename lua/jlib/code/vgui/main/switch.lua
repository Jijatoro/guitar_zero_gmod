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
local bool_typs = {["base"] = true, ["round"] = true}
local circle = Material("jlib/img/circle.png", "noclamp smooth")

--------------------------------------------------------------------------------------------------------------|>
--[+] Creating a button for switch :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
local function CreateButton(pnl, mar, x, y, adjust)
    local jv, clr = jv(), clr()
    pnl.button = jlib.vgui.Create("button", pnl)
    pnl.button:SetText("")
    if (adjust) then pnl.button:Scale(x, y, adjust) else pnl.button:Scale(x, y) end
    pnl.button:Dock(TOP) 
    pnl.button:Margin(mar[1], mar[2], mar[3], mar[4])
    pnl.button:SetMouseInputEnabled(true)
    pnl.button:SetKeyboardInputEnabled(true)
    pnl.button:SetIsToggle(true)
    pnl.button.Paint = function(self, w, h)
        local border = jv.GetBorder("btn")
        local round = jv.GetRound("base")
        local parent = self:GetParent()
        if (self.Hovered) then 
            draw.RoundedBox(round, 0, 0, w, h, clr["btn_line_h"])
            draw.RoundedBox(round, border/2, border/2, w-border, h-border, parent:GetColor())
        else
            draw.RoundedBox(round, 0, 0, w, h, clr["btn_line"])
            draw.RoundedBox(round, border/2, border/2, w-border, h-border, parent:GetColor())     
        end
        --[*] circle
        surface.SetMaterial(circle)
        surface.SetDrawColor(clr["btn"])
        surface.DrawTexturedRect(w*parent.point, h*0.21, w*0.33, h*0.6)        
        --[*] sign
        surface.SetMaterial(parent:GetImage())
        surface.SetDrawColor(clr["btn_line"])
        surface.DrawTexturedRect(w*parent.num1, h*parent.num2, w*parent.num3, h*parent.num4)
    end
    pnl.button.DoClick = function()
        if (pnl:GetStatus()) then
            pnl:SetStatus(false)
        else
            pnl:SetStatus(true)
        end
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local jv, clr, icon = jv(), clr(), icon()
    self.truename = "switch"
    self:SetSize(270, 75)
    self.image = icon["question"]
    self.status = false
    self.color = clr["red"]
    self.num1 = 3 self.num2 = 10
    self.num3, self.num4 = 30
    self.point = 10
    self.value = false 
    self.text = ""
    self:SetStatus(false)
    self.pnltype = "round"

    self.string = jlib.vgui.Create("label", self)
    self.string:SetText(self:GetText())
    jv.SetFont(self.string, "p2", true)
    self.string:Scale(0.8, 0.3)
    self.string:Dock(TOP)
    self.string:Margin(0, 0.1, 0, 0)
    self.string:SetContentAlignment(5)

    CreateButton(self, {0.4, 0.05, 0, 0}, 0.2, 0.45)    
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
--[+] Value control (false/true) :--:--:--:--:--:--:--:--:--:--:--:}>                                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetValue(val)
    self:SetStatus(val) 
end

function PANEL:GetValue()
    return self.status
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Text control (what does pressing switch do?) :--:--:--:--:--:--:--:--:--:--:--:}>                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetText(val)
    self.text = val
    if not (val) or (val == "") then
        self.string:Remove()
        if (IsValid(self.button)) then self.button:Remove() end
        CreateButton(self, {0, 0, 0, 0}, 0, 1, 1)
    else
        self.string:SetText(val)
    end
end

function PANEL:GetText()
    return self.text
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Body type management (body appearance) :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetType(type)
    self.pnltype = type
end

function PANEL:GetType()
    return self.pnltype
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Manage status (on every click) :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetStatus(val)
    local icon, clr = icon(), clr()
    self.status = val
    if (self.status) then 
        self.color = clr["green"]
        self.num1 = 0.48 self.num2 = 0.2
        self.num3, self.num4 = 0.4, 0.6
        self.point = 0.13
        self.image = icon["accept"]
    else 
        self.color = clr["red"]
        self.num1 = 0.13 self.num2 = 0.2
        self.num3, self.num4 = 0.34, 0.6
        self.point = 0.56
        self.image = icon["close"]
    end
end

function PANEL:GetStatus()
    return self.status
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting an icon (cross or check mark) :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetImage()
    return self.image
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the background color :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetColor()
    return self.color
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the ability to click :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Disable()
    self.button.IsDisable = true
    self.button:SetCursor("no")
    self.button:SetAlpha(120)
end

function PANEL:Enable()
    self.button.IsDisable = false
    self.button:SetCursor("hand")
    self.button:SetAlpha(255)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint(w, h)
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("pnl")
    local round = jv.GetRound("base")
    local circ, alpha = 0, 255
    if (self:GetType() == "round") then circ = round end
    if not (bool_typs[self:GetType()]) then alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr["line"], alpha))
    draw.RoundedBox(circ, border/2, border/2, w-border, h-border, ColorAlpha(clr["body"], alpha))
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.switch-main", PANEL, "PANEL")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 