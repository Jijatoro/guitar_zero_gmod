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

    self.text = ""
    self.font = jlib.vgui.GetFont(data_font, "txt")
    self.object = nil
    self.object_p = nil
    self.status = false
end

function PANEL:Paint(w, h)
    if (self.object) and (self.object.Hovered) then
        draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])
        draw.SimpleText(self.text, self.font, w*0.5, h*0.5, clr()["t_p1"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:SetObject(arg, par)
    if not (arg) or not (IsValid(arg)) then return end
    self.object = arg
    self.status = true

    for i = 1, 10 do
        if (self.object:GetParent() == self:GetParent()) then
            self.object_p = self.object
            break
        else
            self.object_p = self.object:GetParent()
        end
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
    if not (self.object_p) then return end

    if (self.object.Hovered) and not (self.status) then
        self.status = true

        local abs_x, abs_y = self:LocalToScreen(0, 0)
        local parent = self:GetParent()
        local parent_x, parent_y = parent:ScreenToLocal(abs_x, abs_y)
        local wide = self:GetWide()
        local width_obj = self.object:GetWide()
        local objpos_x, objpos_y = self.object_p:GetPos()  
        local r_posx, r_posy = parent_x+objpos_x+(width_obj*0.4)-(wide*0.4), parent_y+objpos_y+60

        self:SetPos(r_posx, r_posy)
        return
    end

    if not (self.object.Hovered) and (self.status) then
        self.status = false
        self:SetPos(0, 0)
    end   
end

function PANEL:PerformLayout()
    local text = self.text
    if (text != "") or (text != nil) then
        surface.SetFont(self.font)
        local text_w, text_h = surface.GetTextSize(text)
        local w, h = self:GetSize()
        
        if (w < (text_w + 15)) then
            self:SetSize(text_w + 15, text_h + 15)
        end
    end
end

vgui.Register("jlib.tip-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 