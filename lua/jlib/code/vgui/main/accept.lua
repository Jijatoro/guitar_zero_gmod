--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function icon() return jlib.cfg.icons[jlib.cfg.icon]  or {} end
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end
local function lan() return jlib.cfg.lans[jlib.cfg.lan] or {} end
local data_font = {
    ["main"] = {
        txt = "s1-24"
    },
    ["anime"] = {
        txt = "a3-24"
    },
    ["fantasy"] = {
        txt = "f1-24"
    },
    ["cyber"] = {
        txt = "c2-32"
    },    
    ["horror"] = {
        txt = "h4-32"
    },
    ["terminal"] = {
        txt = "t3-24"
    } 
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local l = lan()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.func = nil
    self:SetSize(400, 300)
    
    self.string = jlib.vgui.Create("label", self)
    self.string:SetText(l["accept-notify"])
    self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.string:Dock(TOP)
    self.string:DockMargin(25, 60, 25, 0)
    self.string:SetSize(250, 150)
    self.string:SetWrap(true)
    self.string:SetContentAlignment(5)
 
    self.btnaccept = jlib.vgui.Create("button", self)
    self.btnaccept:SetText(l["yes"])
    self.btnaccept:SetSize(95, 95)
    self.btnaccept:Dock(LEFT)
    self.btnaccept:DockMargin(95, 15, 0, 10)
    self.btnaccept.DoClick = function()
    	self:Remove()
        if (self.func != nil) then
            self.func()
        end
    end
    
    self.btnreject = jlib.vgui.Create("button", self)
    self.btnreject:SetText(l["no"])
    self.btnreject:SetSize(95, 95)
    self.btnreject:Dock(LEFT)
    self.btnreject:DockMargin(10, 15, 0, 10)
    self.btnreject.DoClick = function()
        self:Remove()
    end
end

function PANEL:SetFunc(func)
    self.func = func
end

function PANEL:SetText(text)
    self.string:SetText(text)
end

function PANEL:Paint(w, h)
    local i, c = icon(), clr()
	draw.RoundedBox(32, 0, 0, w, h, c["line"])
	draw.RoundedBox(32, 3, 3, w-6, h-6, c["body"])
    surface.SetMaterial(i["question"])
    surface.SetDrawColor(c["icon"])
    surface.DrawTexturedRect(155, 5, 90, 90)
end

vgui.Register("jlib.accept-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 