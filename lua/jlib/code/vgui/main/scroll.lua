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
AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.truename = "scroll"
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.body_scroll = jlib.vgui.Create("dscroll", self)
    self.body_scroll:Dock(FILL)
    self.body_scroll:SetName("dscroll")
    self:DockPadding(0, 3, 0, 3)
end

function PANEL:Restart()
    self.body_scroll:Remove()
    self.body_scroll = jlib.vgui.Create("dscroll", self)
    self.body_scroll:Dock(FILL)
    self.body_scroll:SetName("dscroll")
    self:DockPadding(0, 3, 0, 3)
end

function PANEL:Paint(w, h)
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("pnl")
    local round = jv.GetRound("weak")
    local circ = 0
    local img_p_x, img_p_y, img_w_y, img_h_y = 0, 0, 0, 0

    if (self:GetType() == "round") then circ = round end
    if not (bool_typs[self:GetType()]) then self.color_alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr["line"], self.color_alpha))
    draw.RoundedBox(circ, border/2, border/2, w-border, h-border, ColorAlpha(clr["body"], self.color_alpha))
end


vgui.Register("jlib.scroll-main", PANEL, "jlib.panel-main")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 