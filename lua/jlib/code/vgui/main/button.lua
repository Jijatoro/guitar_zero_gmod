--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| :--:--:--:--:--:--:--:--:--:--:--:}>                                                      |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        btn = "s5-24"
    },
    ["anime"] = {
        btn = "a1-24"
    },
    ["fantasy"] = {
        btn = "f3-24"
    },
    ["cyber"] = {
        btn = "c4-24"
    },    
    ["horror"] = {
        btn = "h5-24"
    },
    ["terminal"] = {
        btn = "t1-24"
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
    self:SetSize(45, 45)  
    self:SetText("")
    self:SetFont(jlib.vgui.GetFont(data_font, "btn"))
    self:SetTextColor(clr()["t_btn"])
    self.status = false
    self.draw = true
    self.image = nil
    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)
    self.IsDisable = false
    self.sound = "select"
    self.sound_h = "cursor"
    self.hover_s = false
end

function PANEL:Paint(w, h)
    local size_x, size_y = self:GetSize()
    local alpha = 255
    local clr_text = clr()["t_btn"]
    local clr_icon = clr()["icon"]
    local clr_btn, clr_line = clr()["btn"], clr()["line"]

    if not (self.draw) then alpha = 0 end
    if (self.Hovered) or (self:GetStatus()) then 
        clr_text = clr()["t_btn_h"]
        clr_icon = clr()["icon_a"]
        clr_btn, clr_line = clr()["btn_h"], clr()["btn_line_h"]
    end

    draw.RoundedBox(32, 0, 0, w, h, ColorAlpha(clr_line, alpha))
    draw.RoundedBox(32, 3, 3, w-6, h-6, ColorAlpha(clr_btn, alpha))    
    self:SetTextColor(clr_text)

    if (self:GetImage()) then
        surface.SetMaterial(icon()[self:GetImage()])
        surface.SetDrawColor(clr_icon)
        surface.DrawTexturedRect(w*0.13, h*0.13, size_x-10, size_y-10)  
    end      
end

function PANEL:SetSound(val)
    self.sound = val
end

function PANEL:SetSoundH(val)
    self.sound_h = val
end

function PANEL:SetStatus(val)
    self.status = val
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:SetImage(arg)
    if not (icon()[arg]) then arg = "question" end
    self.image = arg
    self:SetText("")
end

function PANEL:GetImage()
    return self.image
end

function PANEL:SetDraw(val)
    self.draw = val
end

function PANEL:GetDraw()
    return self.draw
end

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

function PANEL:SetDelay(arg)
    self:Disable()
    timer.Simple(arg, function()
        if (IsValid(self)) then
            self:Enable()
        end
    end)
end

function PANEL:PerformLayout()
    local text = self:GetText()
    if (text != "") or (text != nil) then
        surface.SetFont(self:GetFont())
        local text_w, text_h = surface.GetTextSize(text)
        local w, h = self:GetSize()
        
        if (w < (text_w + 15)) then
            self:SetWide(text_w + 15)
        end

        if (h < (text_h + 15)) then
            self:SetHeight(text_h + 15)
        end
    end
end

function PANEL:Think()
    if (self.Hovered) and not (self.hover_s) then
        self.hover_s = true jlib.vgui.PlaySound(self.sound_h, nil, true) return 
    elseif not (self.Hovered) then self.hover_s = false end
end

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

vgui.Register("jlib.button-main", PANEL, "Button")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 