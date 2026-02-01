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
        txt = "t1-32"
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
    self:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self:SetTextColor(clr()["t_p1"])
end

vgui.Register("jlib.label-main", PANEL, "DLabel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 