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
    local jv = jv()
    self.truename = "tip"
    self.hasText, self.hasTitle, self.wrapped = false, false, false

    self:SetSize(0, 0)
    self:Dock(NODOCK)
    self:SetZPos(9999)
    self:SetDrawOnTop(true)

    self.text = ""
    self.font = false
    self.object = nil
    self.old_remove = nil
    self.status = false
    self.toppos = false
    jv.SetFont(self, "p2", true)
end

function PANEL:SetName(arg)
    self.truename = arg
end

function PANEL:GetName()
    return self.truename
end

function PANEL:SetFont(arg)
    self.font = arg
end

function PANEL:GetFont()
    return self.font
end

function PANEL:Paint(w, h)
    if (self.object) and (self.object.Hovered) then
        local jv, clr = jv(), clr()
        local border = jv.GetBorder("pnl")
        local round = jv.GetRound("base")
        surface.SetFont(self.font)
        local wide, tall = surface.GetTextSize(self.text)
        draw.RoundedBox(round, 0, 0, w, h, clr["line"])
        draw.RoundedBox(round, border/2, border/2, w-border, h-border, clr["body"])
        draw.SimpleText(self.text, self.font, w*0.5, h*0.5-(tall*0.1), clr["t_p1"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:SetObject(arg, pos_top)
    if not (arg) or not (IsValid(arg)) then return end
    if (pos_top) then self.toppos = true end
    local panel = self
    self.object = arg
    self.status = true

    self.old_remove = self.object.OnRemove
    arg.OnRemove = function()
        if (panel.old_remove) then self.old_remove(arg) end
        panel:Remove()
    end    
end

function PANEL:SetText(arg)
    self.text = arg
    if (self.text != "") or (self.text != nil) then
        surface.SetFont(self.font)
        local text_w, text_h = surface.GetTextSize(self.text)
        local w, h = self:GetSize()
        
        if (w < (text_w + 15)) then
            self:SetSize(text_w + 15, text_h + 15)

            local x, y = self:GetPos()
            local wide = self:GetWide()
            self:SetPos(x-(wide/2), y)
        end
    end
end

function PANEL:Think()
    if not (self.object) then return end

    if (self.object.Hovered) and not (self.status) then
        self.status = true
        local mouse_x, mouse_y = self.object:LocalToScreen(0, 0)
        local wide, tall = self:GetSize()
        local wideobj, tallobj = self.object:GetSize()
        local newpos_x = mouse_x+(wideobj*0.5)-(wide*0.5)
        local newpos_y = mouse_y+tallobj+15
        if (self.toppos) then newpos_y = mouse_y-tall-15 end

        self:SetPos(newpos_x, newpos_y)
        return
    end

    if not (self.object.Hovered) and (self.status) then
        self.status = false
        self:SetPos(0, 0)
    end   
end

-- function PANEL:PerformLayout()
--     local text = self.text
--     if (text != "") or (text != nil) then
--         surface.SetFont(self.font)
--         local text_w, text_h = surface.GetTextSize(text)
--         local w, h = self:GetSize()
        
--         if (w < (text_w + 15)) then
--             self:SetSize(text_w + 15, text_h + 15)
--         end
--     end
-- end

vgui.Register("jlib.tip-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 