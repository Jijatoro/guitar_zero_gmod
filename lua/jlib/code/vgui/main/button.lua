--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| :--:--:--:--:--:--:--:--:--:--:--:}>                                                      |>
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
    local jv = jv()
    self.truename = "button"
    self:SetSize(45, 45)  
    self:SetText("")
    jv.SetFont(self, "btn1", true)
    self:SetTextColor(clr()["t_btn"])
    self.status = false
    self.draw = true
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)
    self.IsDisable = false
    self.sound = "select"
    self.sound_h = "cursor"
    self.hover_s = false
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
    jv.Scale(self, data)
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
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint(w, h)
    local jv, clr = jv(), clr()
    local alpha = 255
    local clr_text = clr["t_btn"]
    local clr_icon = clr["icon"]
    local clr_btn, clr_line = clr["btn"], clr["line"]
    local border = jv.GetBorder("btn")
    local round = jv.GetRound("base")

    if not (self.draw) then alpha = 0 end
    if (self.Hovered) or (self:GetStatus()) then 
        clr_text = clr["t_btn_h"]
        clr_icon = clr["icon_a"]
        clr_btn, clr_line = clr["btn_h"], clr["btn_line_h"]
    end

    draw.RoundedBox(round, 0, 0, w, h, ColorAlpha(clr_line, alpha))
    draw.RoundedBox(round, border/2, border/2, w-border, h-border, ColorAlpha(clr_btn, alpha))    
    self:SetTextColor(clr_text)

    if (self:GetImage()) then
        surface.SetMaterial(icon()[self:GetImage()])
        surface.SetDrawColor(clr_icon)
        surface.DrawTexturedRect(w*0.065, h*0.055, w-(w*0.1), h-(h*0.1))  
    end      
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Sound after click :--:--:--:--:--:--:--:--:--:--:--:}>                                                  |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetSound(val)
    self.sound = val
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Sound when aiming :--:--:--:--:--:--:--:--:--:--:--:}>                                                  |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetSoundH(val)
    self.sound_h = val
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Status control (whether the button is pressed or not) :--:--:--:--:--:--:--:--:--:--:--:}>              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetStatus(val)
    self.status = val
end

function PANEL:GetStatus()
    return self.status
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Changing text to an image (icons only) :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetImage(arg)
    if not (icon()[arg]) then arg = "question" end
    self.image = arg
    self:SetText("")
end

function PANEL:GetImage()
    return self.image
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Draws the button body. If false, only the text will be visible. :--:--:--:--:--:--:--:--:--:--:--:}>    |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetDraw(val)
    self.draw = val
end

function PANEL:GetDraw()
    return self.draw
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We control the ability to press the button :--:--:--:--:--:--:--:--:--:--:--:}>                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Disable()
    self.IsDisable = true
    self:SetCursor("no")
    self:SetAlpha(120)
end

function PANEL:Enable()
    self.IsDisable = false
    self:SetCursor("hand")
    self:SetAlpha(255)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting a delay after a click :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetDelay(arg)
    self:Disable()
    timer.Simple(arg, function()
        if (IsValid(self)) then
            self:Enable()
        end
    end)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Every tick is executed :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Think()
    local jv = jv()
    --[*] Making the sound when aiming a single time
    if (self.Hovered) and not (self.hover_s) then
        self.hover_s = true jv.PlaySound(self.sound_h, nil, true) return 
    elseif not (self.Hovered) then self.hover_s = false end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Hover button behavior duplicator for adding sound :--:--:--:--:--:--:--:--:--:--:--:}>                  |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnMouseReleased(mousecode)
    self:MouseCapture( false )
    
    if (self.IsDisable) then return end
    if ( !self:IsEnabled() ) then return end
    if ( !self.Depressed && dragndrop.m_DraggingMain != self ) then return end

    if ( self.Depressed ) then
        self.Depressed = nil
        self:OnReleased()
        self:InvalidateLayout( true )
    end

    if ( self:DragMouseRelease( mousecode ) ) then
        return
    end

    if ( self:IsSelectable() && mousecode == MOUSE_LEFT ) then
        local canvas = self:GetSelectionCanvas()
        if ( canvas ) then
            canvas:UnselectAll()
        end
    end

    if (!self.Hovered) then return end

    self.Depressed = true

    if (mousecode == MOUSE_RIGHT) then
        self:DoRightClick()
    end

    if (mousecode == MOUSE_LEFT) then
        self:DoClickInternal()
        self:DoClick()
        jlib.vgui.PlaySound(self.sound, nil, true)
    end

    if (mousecode == MOUSE_MIDDLE) then
        self:DoMiddleClick()
    end

    self.Depressed = nil
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.button-main", PANEL, "Button")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 