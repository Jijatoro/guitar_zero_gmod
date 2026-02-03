--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function icon() return jlib.cfg.icons[jlib.cfg.icon]  or {} end
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end
local all_typs = {"base", "round"}
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
        txt = "c2-24"
    },    
    ["horror"] = {
        txt = "h4-24"
    },
    ["terminal"] = {
        txt = "s1-24"
    } 
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.hasText, self.hasTitle, self.wrapped = false, false, false
	self:SetSize(400, 45)
    self.pnltype = "nodraw"
    self.value = false
	self.text = ""
	self.color = clr()["red"]
    self.image = icon()["close"]
    self.status = false
    self.IsDisable = false
    self:SetStatus(false)    
	
	self.string = jlib.vgui.Create("label", self)
	self.string:SetText(self:GetText())
	self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
	self.string:SetSize(100, 32)
	self.string:Dock(LEFT)
	self.string:DockMargin(10, 8, 10, 8)
	self.string:SetContentAlignment(1)
	self.string.PerformLayout = function(self)
	    surface.SetFont(self:GetFont())
	    local text_w, text_h = surface.GetTextSize(self:GetText())
	    self:SetSize(text_w+5, 32)
	end

	self.checkbox = jlib.vgui.Create("button", self)
	self.checkbox:SetSize(35, 35)
	self.checkbox:SetText("")
	self.checkbox:Dock(LEFT)
	self.checkbox:DockMargin(0, 5, 0, 5)
	self.checkbox.Paint = function(self, w, h)
		local parent = self:GetParent()
	    if (self.Hovered) then 
	        draw.RoundedBox(8, 0, 0, w, h, clr()["btn_line_h"])
	        draw.RoundedBox(8, 3, 3, w-6, h-6, parent.color)
	    else
	        draw.RoundedBox(8, 0, 0, w, h, clr()["btn_line"])
	        draw.RoundedBox(8, 3, 3, w-6, h-6, parent.color)       
	    end
	    surface.SetMaterial(parent:GetImage())
	    surface.SetDrawColor(clr()["btn_line"])
	    surface.DrawTexturedRect(3, 3, w-6, h-6) 	
 	end
 	self.checkbox.DoClick  = function(self)
 		local parent = self:GetParent()
 		if (parent.IsDisable) then return end
	    if (parent:GetStatus()) then
	        parent:SetStatus(false)
	    else
	        parent:SetStatus(true)
	    end
	end
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetValue(val)
	self.value = val
	self:SetStatus(val)
end

function PANEL:GetValue()
	return self:GetStatus()
end

function PANEL:SetText(val)
	if not (val) or (val == "") then self.string:Remove() end
	self.text = val
	self.string:SetText(val)
end

function PANEL:GetText()
	return self.text
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:GetImage()
    return self.image
end

function PANEL:Disable()
	self.checkbox.IsDisable = true
	self.checkbox:SetCursor("no")
	self.checkbox:SetAlpha(120)
end

function PANEL:Enable()
	self.checkbox.IsDisable = false
	self.checkbox:SetCursor("hand")
	self.checkbox:SetAlpha(255)
end

function PANEL:SetStatus(val)
	local ic, c = icon(), clr()
    self.status = val
    if (self.status) then 
        self.num1, self.num2 = 2, 2
        self.num3, self.num4 = 29, 29
        self.image = ic["accept"]
        self.color = c["green"]
    else 
        self.num1, self.num2 = 5, 5
        self.num3, self.num4 = 25, 25
        self.image = ic["close"]
        self.color = c["red"]
    end
end

function PANEL:Paint(w, h)
	local c = clr()
    local circ, alpha = 0, 255
    if (self:GetType() == "round") then circ = 32 end
    if not (table.KeyFromValue(all_typs, self:GetType())) then alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(c["line"], alpha))
    draw.RoundedBox(circ, 3, 3, w-6, h-6, ColorAlpha(c["body"], alpha))
end

vgui.Register("jlib.checkbox-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 