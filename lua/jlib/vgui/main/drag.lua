--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}

local function icon()
    return jlib.cfg.icons[jlib.cfg.icon]  or {}
end

local function clr()
    return jlib.cfg.themes[jlib.cfg.theme]  or {}
end

local function lan()
    return jlib.cfg.lans[jlib.cfg.lan] or {}
end

local function Render(target, drag)
    local size_x, size_y = target:GetSize()
    local pos_x, pos_y = target:LocalToScreen(0, 0)
    jlib.vgui.drag_size = {[1] = size_x, [2] = size_y, [3] = pos_x, [4] = pos_y}
    
    drag:SetSize(size_x, size_y)
    jlib.vgui.drag_ready = true
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnlname = nil
    self:SetSize(0, 0)
    self:Dock(NODOCK)
    self:SetZPos(9999)
    self:SetDrawOnTop(true)
    self:SetAlpha(200)
    self.status = false
    self.data = nil
    self.func = nil
    self.old_mousepres = nil
    self.old_remove = nil
    self:SetMouseInputEnabled(true)
    self:SetVisible(false)
end

function PANEL:SetName(arg)
    self.pnlname = arg
end

function PANEL:GetName(arg)
    return self.pnlname
end

function PANEL:SetFunc(arg)
    self.func = arg
end

function PANEL:SetData(data)
    if not (data) then return end
    local panel = self
    self.data = data
    self.status = false
    self.old_remove = self.data.OnRemove
    self.old_mousepres = self.data.OnMousePressed
    self.old_mouserele = self.data.OnMouseReleased

    data.OnRemove = function()
        if (panel.old_remove) then panel.old_remove(data) end
        panel:Remove()
    end

    data.OnMousePressed = function(pnl, key)
        if (panel.old_mousepres) then panel.old_mousepres(pnl, key) end
        if (key == MOUSE_LEFT) and not (panel.status) then
            if not (jlib.vgui.drag_image) then Render(data, panel) end
            self.status = true
            panel:SetVisible(true)
        end
    end 
end

function PANEL:Paint(w, h)
    if (jlib.vgui.drag_image) then
        surface.SetMaterial(Material("data/" .. jlib.vgui.drag_image), "noclamp smooth")
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end
end

function PANEL:Think()
    if (self.status) then
        local pos_x, pos_y = input.GetCursorPos()
        local data = jlib.vgui.drag_size
        self:SetPos(pos_x-(data[1]*0.5), pos_y-(data[2]*0.5))

        if not (input.IsMouseDown(MOUSE_LEFT)) then
            self.status = false
            jlib.vgui.drag_image = nil
            self:SetVisible(false)
            if (self.func) then
                self.func(input.GetCursorPos())
            end
        end
    end
end

vgui.Register("jlib.drag-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 