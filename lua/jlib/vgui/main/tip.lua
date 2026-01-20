--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-18",
    },
    ["anime"] = {
        txt = "a2-18",
    },
    ["fantasy"] = {
        txt = "f6-18",
    },
    ["cyber"] = {
        txt = "c3-18",
    },    
    ["horror"] = {
        txt = "h9-24",
    },
    ["terminal"] = {
        txt = "t6-18",
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
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false

    self:SetSize(0, 0)
    self:Dock(NODOCK)
    self:SetZPos(9999)
    self:SetDrawOnTop(true)

    self.text = ""
    self.font = jlib.vgui.GetFont(data_font, "txt")
    self.object = nil
    self.status = false
    self.toppos = false
end

function PANEL:Paint(w, h)
    if (self.object) and (self.object.Hovered) then
        draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])
        draw.SimpleText(self.text, self.font, w*0.5, h*0.5, clr()["t_p1"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:SetObject(arg, pos_top)
    if not (arg) or not (IsValid(arg)) then return end
    if (pos_top) then self.toppos = true end
    self.object = arg
    self.status = true
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