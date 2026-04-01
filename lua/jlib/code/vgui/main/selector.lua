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

--------------------------------------------------------------------------------------------------------------|>
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local lan, jv, clr = lan(), jv(), clr()
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self.pnltype = "round"

    self.truename = "selector"
    self.status = false
    self.value = lan["not-selected"]
    self.data = {}
    self.key = 0
    self:SetSize(250, 90)

    --[*] Text (what does the user select?)
    self.string = jlib.vgui.Create("label", self)
    self.string:SetText("")
    jv.SetFont(self.string, "p2", true)
    self.string:SetTextColor(clr["t_btn"])
    self.string:Scale(1, 0.3)
    self.string:SetIsToggle(true)
    self.string:Dock(TOP)
    self.string:Margin(0, 0.05, 0, 0)
    self.string:SetContentAlignment(5)

    --[*] The main button for opening the selection list
    self.selector = jlib.vgui.Create("button", self)
    self.selector:SetText(lan["not-selected"])
    self.selector:Dock(TOP)
    self.selector:Margin(0.1, 0.05, 0.1, 0)
    self.selector:Scale(0.8, 0.5)
    self.selector.DoClick = function()
        self:Spawn()
    end
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
--[+] Set by value (false/true) :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetValue(val)
    self.value = val
    self.selector:SetText(val)
end

function PANEL:GetValue()
    return self.value
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Naming a key from a list of existing buttons :--:--:--:--:--:--:--:--:--:--:--:}>                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetKey(key)
    self.key = key
end

function PANEL:GetKey()
    return self.key
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Data Assignment (all selectable buttons in the list) :--:--:--:--:--:--:--:--:--:--:--:}>               |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetData(tbl)
    self.data = tbl
end

function PANEL:GetData()
    return self.data
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Text control (what does the user choose?) :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetText(val)
    self.string:SetText(tostring(val))
end

function PANEL:GetText()
    return self.string:GetText()
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the state (is the drop-down list open or not?) :--:--:--:--:--:--:--:--:--:--:--:}>            |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetStatus(bool)
    self.status = bool
end

function PANEL:GetStatus()
    return self.status
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
--[+] Managing the position of the opening list :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
--------------------------------------------------------------------------------------------------------------|>
local function spawnIt(self, scroll)
    if not (IsValid(self)) or not (IsValid(scroll)) then return end
    local abs_x, abs_y = self:LocalToScreen(0, 0)
    local parent = self:GetParent()
    local parent_x, parent_y = parent:ScreenToLocal(abs_x, abs_y)
    local width = self:GetWide()
    local s_height = self:GetTall()*1.74
    local scroll_x = parent_x
    local scroll_y = parent_y + self:GetTall() + 1  

    scroll:SetPos(scroll_x, scroll_y)
    scroll:SetSize(width, s_height)      
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Create an opening list :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Spawn()
    local jv = jv()
    if (self:GetStatus()) then
        self:SetStatus(false)
        jv["selector"]:Remove()
    else
        if (IsValid(jv["selector"])) then 
            local par = jv["selector"].trueparent
            if (IsValid(par)) then par:SetStatus(false) end
            jv["selector"]:Remove() 
        end

        self:SetStatus(true)
        local abs_x, abs_y = self:LocalToScreen(0, 0)
        local parent = self:GetParent()
        local parent_x, parent_y = parent:ScreenToLocal(abs_x, abs_y)
        local width = self:GetWide()
        local s_height = 130
        local scroll_x = parent_x
        local scroll_y = parent_y + self:GetTall() + 1        

        jv["selector"] = jlib.vgui.Create("scroll", self:GetParent())
        local scroll = jv["selector"]
        scroll.trueparent = self
        scroll:SetZPos(999)
        scroll:SetType("round")
        spawnIt(self, scroll)
        local layout = scroll.PerformLayout
        scroll.PerformLayout = function(body, w, h)
            spawnIt(self, scroll)
            layout(body, w, h)
        end        

        for i = 1, #self:GetData() do
            local pnl_btn = jlib.vgui.Create("panel", scroll)
            pnl_btn:SetType("none")
            pnl_btn:Dock(TOP)
            pnl_btn:Margin(0, 0.02, 0, 0)
            pnl_btn:Scale(0, 0.25)
                      
            local btnkey = jlib.vgui.Create("button", pnl_btn)
            btnkey:Dock(FILL)
            btnkey:Margin(0.044, 0, 0.044, 0)
            btnkey:SetText(jlib.sub(self:GetData()[i], 1, 18))
            jv.SetFont(btnkey, "btn2", true)
            btnkey.DoClick = function()
                self:SetStatus(false)
                scroll:Remove()
                self:SetKey(i)
                self:SetValue(self:GetData()[i])
            end
        end
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We control the ability to open the list with the main button :--:--:--:--:--:--:--:--:--:--:--:}>       |>
--------------------------------------------------------------------------------------------------------------|>
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Occurs before the element is completely deleted :--:--:--:--:--:--:--:--:--:--:--:}>                    |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnRemove()
    local jv = jv()
    --[*] delete the opened list if there is one
    if (IsValid(jv["selector"])) then
        jv["selector"]:Remove()
    end
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
vgui.Register("jlib.selector-main", PANEL, "PANEL")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 