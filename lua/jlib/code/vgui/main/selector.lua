--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local all_typs = {"base", "round"}
local data_font = {
    ["main"] = {
        txt = "s1-18",
        btn = "s5-14"
    },
    ["anime"] = {
        txt = "a3-18",
        btn = "s5-14"
    },
    ["fantasy"] = {
        txt = "f1-18",
        btn = "s5-14"
    },
    ["cyber"] = {
        txt = "c2-18",
        btn = "s5-14"
    },    
    ["horror"] = {
        txt = "h4-18",
        btn = "s5-14"
    },
    ["terminal"] = {
        txt = "s1-18",
        btn = "s5-14"
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
    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self.pnltype = "round"

    self.pnlname = lan()["oops"] or "?"
    self.status = false
    self.value = lan()["not-selected"]
    self.data = {}
    self.key = 0
    self:SetSize(250, 90)

    self.string = jlib.vgui.Create("label", self)
    self.string:SetText("")
    self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.string:SetTextColor(clr()["t_btn"])
    self.string:SetSize(180, 35)
    self.string:SetIsToggle(true)
    self.string:Dock(TOP)
    self.string:DockMargin(3, 3, 3, 0)
    self.string:SetContentAlignment(5)

    self.selector = jlib.vgui.Create("button", self)
    self.selector:SetText(lan()["not-selected"])
    self.selector:Dock(TOP)
    self.selector:DockMargin(25, 1, 25, 0)
    self.selector.DoClick = function()
        self:Spawn()
    end
end

function PANEL:SetValue(val)
    self.value = val
    self.selector:SetText(val)
end

function PANEL:GetValue()
    return self.value
end

function PANEL:SetKey(key)
    self.key = key
end

function PANEL:GetKey()
    return self.key
end

function PANEL:SetData(tbl)
    self.data = tbl
end

function PANEL:GetData()
    return self.data
end

function PANEL:SetText(val)
    self.string:SetText(tostring(val))
end

function PANEL:GetText()
    return self.string:GetText()
end

function PANEL:SetStatus(bool)
    self.status = bool
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:SetType(type)
    self.pnltype = type
end

function PANEL:GetType()
    return self.pnltype
end

function PANEL:Spawn()
    if (self:GetStatus()) then
        self:SetStatus(false)
        self.Scroll:Remove()
    else
        self:SetStatus(true)
        local abs_x, abs_y = self:LocalToScreen(0, 0)
        local parent = self:GetParent()
        local parent_x, parent_y = parent:ScreenToLocal(abs_x, abs_y)
        local width = self:GetWide()
        local s_height = 130
        local scroll_x = parent_x
        local scroll_y = parent_y + self:GetTall() + 1        

        self.Scroll = jlib.vgui.Create("scroll", self:GetParent())
            self.Scroll:SetPos(scroll_x, scroll_y)
            self.Scroll:SetSize(width, s_height)
            self.Scroll:SetZPos(999)
            self.Scroll:SetType("round")

        for i= 1, #self:GetData() do
            local btnkey = jlib.vgui.Create("button", self.Scroll)
                btnkey:Dock(TOP)
                btnkey:DockMargin(6, 0, 6, 1)
                btnkey:SetSize(0, 25)
                btnkey:SetText(jlib.sub(self:GetData()[i], 1, 18))
                btnkey:SetFont(jlib.vgui.GetFont(data_font, "btn"))
                btnkey.DoClick = function()
                    self:SetStatus(false)
                    self.Scroll:Remove()
                    self:SetKey(i)
                    self:SetValue(self:GetData()[i])
                end
        end
    end
end

function PANEL:Disable()
    self.selector.IsDisable = true
    self.selector:SetCursor("no")
    self.selector:SetAlpha(120)
end

function PANEL:Enable()
    self.selector.IsDisable = false
    self.selector:SetCursor("hand")
    self.selector:SetAlpha(255)
end

function PANEL:SetName(arg)
    self.pnlname = arg
end

function PANEL:GetName(arg)
    return self.pnlname
end

function PANEL:OnRemove()
    if (self.Scroll) and (IsValid(self.Scroll)) then
        self.Scroll:Remove()
    end
end

function PANEL:Paint(w, h)
    local circ, alpha = 0, 255
    if (self:GetType() == "round") then circ = 32 end
    if not (table.KeyFromValue(all_typs, self:GetType())) then alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr()["line"], alpha))
    draw.RoundedBox(circ, 3, 3, w-6, h-6, ColorAlpha(clr()["body"], alpha))
end

vgui.Register("jlib.selector-main", PANEL, "PANEL")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 