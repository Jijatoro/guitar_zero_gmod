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
    self.truename = "dbinder"
    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)  
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

function PANEL:Paint(w, h)
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("btn")
    local round = jv.GetRound("base")
    if (self.Hovered) then 
        self:SetTextColor(clr["t_btn_h"])
        draw.RoundedBox(round, 0, 0, w, h, clr["btn_line_h"])
        draw.RoundedBox(round, border/2, border/2, w-border, h-border, clr["btn_h"])
    else
        self:SetTextColor(clr["t_btn_h"])
        draw.RoundedBox(round, 0, 0, w, h, clr["btn_line"])
        draw.RoundedBox(round, border/2, border/2, w-border, h-border, clr["btn"])
    end    
end

vgui.Register("jlib.dbinder-main", PANEL, "DBinder")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 