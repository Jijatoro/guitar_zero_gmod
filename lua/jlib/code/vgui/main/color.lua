--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end
local data_font = {
    ["main"] = {
        txt = "s1-18"
    },
    ["anime"] = {
        txt = "a3-18"
    },
    ["fantasy"] = {
        txt = "f1-18"
    },
    ["cyber"] = {
        txt = "c2-18"
    },    
    ["horror"] = {
        txt = "h4-18"
    },
    ["terminal"] = {
        txt = "s1-18"
    } 
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "base"
    self.pnlname = nil
    self.value = Color(255, 255, 255)
    self:SetSize(250, 200)

    self.panel = jlib.vgui.Create("panel", self)
    self.panel:SetSize(180, 35)
    self.panel:Dock(TOP)

    self.string = jlib.vgui.Create("label", self.panel)
    self.string:SetText("")
    self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.string:SetTextColor(clr()["t_btn"])
    self.string:SetSize(180, 35)
    self.string:SetIsToggle(true)
    self.string:Dock(FILL)
    self.string:DockMargin(3, 0, 3, 0)
    self.string:SetContentAlignment(5)

    self.color_picker = vgui.Create("DRGBPicker", self)
    self.color_picker:Dock(LEFT)
    self.color_picker:DockMargin(3, 0, 0, 3)
    self.color_picker:SetSize(45, 190)

    self.color_cube = vgui.Create("DColorCube", self)
    self.color_cube:Dock(RIGHT)
    self.color_cube:DockMargin(0, 0, 3, 3)
    self.color_cube:SetSize(195, 155) 

    self.color_picker.OnChange = function(picker)
        self.color_cube:SetColor(picker:GetRGB())
    end

    self.color_cube.OnUserChanged = function(cube)
        self.value = cube:GetRGB()
        self.string:SetTextColor(self.value)
    end    
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetValue(val)
    if not (IsColor(val)) then return end
    self.value = val
    self.color_picker:SetRGB(val)
    self.color_cube:SetColor(val)
    self.string:SetTextColor(val)
end

function PANEL:GetValue()
    return self.value
end

function PANEL:SetName(arg)
    self.pnlname = arg
end

function PANEL:GetName(arg)
    return self.pnlname
end

function PANEL:SetText(val)
    self.string:SetText(tostring(val))
end

function PANEL:GetText()
    return self.string:GetText()
end

function PANEL:Paint(w, h)
    local c = clr()
    if (self:GetType() == "base") then
        draw.RoundedBox(0, 0, 0, w, h, c["line"])
        draw.RoundedBox(0, 3, 3, w-6, h-6, c["body"])
    elseif (self:GetType() == "round") then
        draw.RoundedBox(32, 0, 0, w, h, c["line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, c["body"])
    end 
end

vgui.Register("jlib.color-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 