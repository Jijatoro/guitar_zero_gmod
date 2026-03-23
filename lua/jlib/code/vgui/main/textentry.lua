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
    local lan, jv, clr = lan(), jv(), clr()
    self.truename = "textentry"
    self:SetSize(240, 40)
    self:SetHistoryEnabled(false)
    self.History = {}
    self.HistoryPos = 0
    self:SetPaintBorderEnabled(false)
    self:SetPaintBackgroundEnabled(false)
    self:SetDrawBorder(true)
    self:SetPaintBackground(true)
    self:SetEnterAllowed(true)
    self:SetUpdateOnType(false)
    self:SetNumeric(false)
    self:SetAllowNonAsciiCharacters(true)
    self.m_bLoseFocusOnClickAway = false
    self:SetCursor("beam")
    jv.SetFont(self, "textentry", true)
    self.type = "base"
    self.m_txtPlaceholder = lan["text"] .. "..."
    self.minmax = false
    self.clrborder = clr["btn_line"]
    self.clrtext = clr["t_p1"]
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
    jv["Margin"](self, data)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Fires on every resize :--:--:--:--:--:--:--:--:--:--:--:}>                                              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:PerformLayout()
    if not (self.dockmargin) then return end
    self:Margin()
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting the type (body appearance) :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetType(arg)
    self.type = arg
end

function PANEL:GetType()
    return self.type
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the text color :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetTextColor()
    return self.m_colText
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Get the color of the ghost text (if any) :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetPlaceholderColor()
    return self.m_colPlaceholder
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the selection color :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetHighlightColor()
    return self.m_colHighlight
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the cursor color :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetCursorColor()
    return self.m_colCursor
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the maximum and minimum number of characters :--:--:--:--:--:--:--:--:--:--:--:}>              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetMinMax(min, max)
    self.minmax = {min = min, max = max}
end

function PANEL:GetMinMax(arg)
    return self.minmax
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Change text color on focus :--:--:--:--:--:--:--:--:--:--:--:}>                                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnGetFocus()
    local clr = clr()
    self.clrborder = clr["btn_line_h"]
    self.clrtext = clr["t_h1"]
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Change the text color when focus ends :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnLoseFocus()
    local clr = clr()
    self.clrborder = clr["btn_line"]
    self.clrtext = clr["t_p1"]
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint( w, h )
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("btn")
    local b_color = self.clrborder
    local text_color = self.clrtext
    
    if (self.type == "base") then
        draw.RoundedBox(0, 0, 0, w, h, b_color)
        draw.RoundedBox(0, border/2, border/2, w-border, h-border, clr["btn_h"])
    end

    if (self:GetValue() == "") or (self:GetValue() == nil) then
        if (self.type != "base") then return end
        local text = self.m_txtPlaceholder
        surface.SetFont(self:GetFont())
        local text_w, text_h = surface.GetTextSize(text)
        draw.DrawText(text, self:GetFont(), 3, h*0.5-(text_h*0.5), ColorAlpha(clr["t_p1"], 55), TEXT_ALIGN_LEFT)
    else
        surface.SetDrawColor(255, 255, 255, 0)
        surface.DrawRect(0, 0, w, h)
        self:SetTextColor(text_color)
        self:SetHighlightColor(clr["t_mark"])
        self:SetCursorColor(clr["t_btn_h"])
        self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor())
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Called when an element is clicked :--:--:--:--:--:--:--:--:--:--:--:}>                                  |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnMousePressed( mcode )
    if (not self:IsEnabled()) then return end
    if ( mcode == MOUSE_LEFT ) then
        self:OnGetFocus()
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.textentry-main", PANEL, "DTextEntry")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 