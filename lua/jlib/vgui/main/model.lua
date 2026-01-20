--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-18",
        value = "s1-12"
    },
    ["anime"] = {
        txt = "a9-18",
        value = "s1-12"
    },
    ["fantasy"] = {
        txt = "f1-18",
        value = "s1-12"
    },
    ["cyber"] = {
        txt = "c5-18",
        value = "s1-12"
    },    
    ["horror"] = {
        txt = "b3-18",
        value = "s1-12"
    },
    ["terminal"] = {
        txt = "t6-18",
        value = "s1-12"
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

local function isMouse(key, panel)
    if (key == MOUSE_LEFT) then
        if (panel.DoClick) then
            panel.DoClick()
        end
    end
end

local all_form = {
--[[
    fov = nil, -- растояние модели (далеко/близко)
    campos = nil, -- позиция камеры (x, y, точка куда смотрят глаза модели)
    lookat = nil -- позиция модели (x, y, точка куда смотрят глаза модели), z - (ниже, если надо выше)
--]]
    ["pm-face"] = {fov = 58, сampos = Vector(30, 0, 60), lookat = Vector(10, 0, 60)},
    ["pm-face-little"] = {fov = 56, сampos = Vector(25, 0, 35), lookat = Vector(10, 0, 35)},
    ["pm-face-big"] = {fov = 86, сampos = Vector(25, 0, 68), lookat = Vector(10, 0, 68)},
    ["pm-face-fat"] = {fov = 100, сampos = Vector(30, 0, 50), lookat = Vector(10, 0, 50)},
    ["pm"] = {fov = 80, сampos = Vector(52, 0, 35), lookat = Vector(0, 0, 35)},
    ["pm-little"] = {fov = 65, сampos = Vector(52, 0, 26), lookat = Vector(0, 0, 26)},
    ["pm-big"] = {fov = 95, сampos = Vector(52, 0, 40), lookat = Vector(0, 0, 40)}, 
    ["pm-fat"] = {fov = 100, сampos = Vector(60, 0, 35), lookat = Vector(10, 0, 35)},   
    ["model"] = {fov = 70, сampos = Vector(52, 0, 2), lookat = Vector(0, 0, 2)},
    ["model-little"] = {fov = 30, сampos = Vector(52, 0, 2), lookat = Vector(0, 0, 2)},
    ["model-very-little"] = {fov = 10, сampos = Vector(52, 0, 3), lookat = Vector(0, 0, 3)},
    ["model-big"] = {fov = 80, сampos = Vector(52, 0, 25), lookat = Vector(0, 0, 25)}
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "round"
    self.pnlname = nil
    self.pnlstatus = false
    self.form = nil
    self.text = nil
    self.value = nil
    self.customtext = nil
    self:SetSize(100, 100)
    self:SetMouseInputEnabled(true)
    self.DoClick = nil

    self.model = "models/Gibs/HGIBS.mdl"
    self.fov = nil
    self.сampos = nil
    self.lookat = nil
    self.lookang = nil
    self.color = nil
    self.animated = nil
    self.animspeed = nil 
    self.colorBG, self.colorBG_H = clr()["body"], clr()["btn_h"]

    self.dmodel = vgui.Create("DModelPanel", self)
    self.dmodel:Dock(FILL)
    self.dmodel:DockMargin(16, 3, 16, 3)
    self.dmodel.LayoutEntity = function() return end
    self:SetForm("model")
    self.oldfunc = self.dmodel.OnMouseReleased
    self.dmodel.OnMouseReleased = function(pnl, key)
        self.oldfunc(pnl, key)
        isMouse(key, self)
    end
end

function PANEL:SetModel(arg)
    if not (arg) then return end
    self.model = arg
    self.dmodel:SetModel(arg)
end

function PANEL:GetModel()
    return self.model
end

function PANEL:SetForm(arg)
    if not (all_form[arg]) then return end
    self.form = arg
    self.dmodel:SetFOV(all_form[arg].fov)
    self.dmodel:SetCamPos(all_form[arg].сampos)
    self.dmodel:SetLookAt(all_form[arg].lookat)
end

function PANEL:GetForm()
    return self.form
end

function PANEL:SetText(arg)
    self.text = arg
    self.footer = jlib.vgui.Create("panel", self)
    self.footer:Dock(BOTTOM)
    self.footer:DockMargin(0, 0, 0, 0)
    self.footer:SetType("base")
    self.footer:SetSize(400, 30)
    self.footer.Paint = function(self, w, h)
        local parent = self:GetParent()
        if (parent:GetType() == "base") then
            if (parent.dmodel.Hovered) or (parent:GetStatus()) then
                draw.RoundedBox(0, 0, 0, w, h, clr()["btn_line_h"])
                draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["btn_h"])
            else
                draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
                draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["body"])
            end
        elseif (parent:GetType() == "round") then
            if (parent.dmodel.Hovered) or (parent:GetStatus()) then
                draw.RoundedBoxEx(16, 0, 0, w, h, clr()["btn_line_h"], false, false, true, true)
                draw.RoundedBoxEx(16, 3, 3, w-6, h-6, clr()["btn_h"], false, false, true, true)
            else
                draw.RoundedBoxEx(16, 0, 0, w, h, clr()["line"], false, false, true, true)
                draw.RoundedBoxEx(16, 3, 3, w-6, h-6, clr()["body"], false, false, true, true)
            end
        end
    end
    self.label = jlib.vgui.Create("label", self.footer)
    self.label:SetText(arg)
    self.label:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.label:Dock(FILL)
    self.label:DockMargin(3, 3, 3, 3)
    self.label:SetContentAlignment(5) 
    self.dmodel:DockMargin(16, 3, 16, 0)
end 

function PANEL:GetText()
    return self.text
end

function PANEL:SetValue(arg)
    self.value = arg
end

function PANEL:GetValue()
    return self.value
end

function PANEL:SetCustomText(arg, x, y)
    self.customtext = arg
    if not (self.pnl_value) then
        local size_x, size_y = self:GetSize()
        local pos_x, pos_y = x, y
        if not (pos_x) then pos_x = 0 end
        if not (pos_y) then pos_y = 0 end

        surface.SetFont(jlib.vgui.GetFont(data_font, "value"))
        local len_panel = surface.GetTextSize(arg) + 15

        self.pnl_csttext = jlib.vgui.Create("panel", self)
        self.pnl_csttext:SetSize(len_panel, 25)
        self.pnl_csttext:SetPos(size_x+pos_x, size_y+pos_y)
        self.pnl_csttext:SetType("round")
        self.pnl_csttext.Paint = function(self, w, h)
            local parent = self:GetParent()
            if (parent.dmodel.Hovered) or (parent:GetStatus()) then
                draw.RoundedBox(16, 0, 0, w, h, clr()["btn_line_h"])
                draw.RoundedBox(16, 1, 1, w-2, h-2, clr()["btn"])
            else
                draw.RoundedBox(16, 0, 0, w, h, clr()["line"])
                draw.RoundedBox(16, 1, 1, w-2, h-2, clr()["body"])
            end
        end

        self.txt_cst = jlib.vgui.Create("label", self.pnl_csttext)
        self.txt_cst:SetText(arg)
        self.txt_cst:SetFont(jlib.vgui.GetFont(data_font, "value"))
        self.txt_cst:Dock(FILL)
        self.txt_cst:DockMargin(3, 3, 3, 3)
        self.txt_cst:SetContentAlignment(5)
    end
end

function PANEL:GetCustomText()
    return self.customtext
end

function PANEL:OnMouseReleased(key)
    isMouse(key, self)
end

function PANEL:SetFOV(arg)
    self.fov = arg
    self.dmodel:SetFOV(arg)
end

function PANEL:GetFOV()
    return self.fov
end

function PANEL:SetCamPos(arg)
    self.campos = arg
    self.dmodel:SetCamPos(arg)
end

function PANEL:GetCamPo()
    return self.campos
end

function PANEL:SetLookAng(arg)
    self.lookang = arg
    self.dmodel:SetLookAng(arg)
end

function PANEL:GetLookAng()
    return self.lookang
end

function PANEL:SetLookAt(arg)
    self.lookat = arg
    self.dmodel:SetLookAt(arg)
end

function PANEL:GetLookAt()
    return self.lookat
end

function PANEL:SetColor(arg)
    self.color = arg
    self.dmodel:SetColor(arg)
end

function PANEL:GetColor()
    return self.color
end

function PANEL:SetColorBG(arg1, arg2)
    self.colorBG = arg1
    self.colorBG_H = arg2
end

function PANEL:GetColorBG()
    return self.colorBG, self.colorBG_H
end

function PANEL:SetAnimated(arg)
    self.animated = arg
    self.dmodel:SetAnimated(arg)
end

function PANEL:GetAnimated()
    return self.animated
end

function PANEL:SetAnimSpeed(arg)
    self.animspeed = arg
    self.dmodel:SetAnimSpeed(arg)
end

function PANEL:GetAnimSpeed()
    return self.animspeed
end

function PANEL:Enable(arg)
    self.isenable = true
    self.dmodel:SetMouseInputEnabled(true)
end

function PANEL:Disable()
    self.isenable = false
    self.dmodel:SetMouseInputEnabled(false)
end

function PANEL:RunAnimation(arg)
    self.dmodel:RunAnimation(arg)
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetName(arg)
    self.pnlname = arg
end

function PANEL:GetName(arg)
    return self.pnlname
end

function PANEL:SetStatus(arg)
    self.pnlstatus = arg
end

function PANEL:GetStatus()
    return self.pnlstatus
end

function PANEL:Paint(w, h)
    if (self:GetType() == "base") then
        if (self.dmodel.Hovered) or (self:GetStatus()) then
            draw.RoundedBox(0, 0, 0, w, h, clr()["btn_line_h"])
            draw.RoundedBox(0, 3, 3, w-6, h-6, self.colorBG_H)
        else
            draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
            draw.RoundedBox(0, 3, 3, w-6, h-6, cself.colorBG)
        end
    elseif (self:GetType() == "round") then
        if (self.dmodel.Hovered) or (self:GetStatus()) then
            draw.RoundedBox(16, 0, 0, w, h, clr()["btn_line_h"])
            draw.RoundedBox(16, 3, 3, w-6, h-6, self.colorBG_H)
        else
            draw.RoundedBox(16, 0, 0, w, h, clr()["line"])
            draw.RoundedBox(16, 3, 3, w-6, h-6, self.colorBG)
        end
    end
end

vgui.Register("jlib.model-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 