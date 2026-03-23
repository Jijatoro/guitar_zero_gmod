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
local bool_typs = {["base"] = true, ["round"] = true}

--------------------------------------------------------------------------------------------------------------|>
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	local jv, clr, icon = jv(), clr(), icon()
	self.truename = "checkbox"
	self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "nodraw"
    self.value = false
	self.text = ""
	self.color = clr["red"]
    self.image = icon["close"]
    self.status = false
    self.IsDisable = false
    self:SetStatus(false)    
	
	--[*] text element
	self.string = jlib.vgui.Create("label", self)
	self.string:SetText(self:GetText())
	jv.SetFont(self.string, "p2", true)
	self.string:SetSize(100, 32)
	self.string:Dock(LEFT)
	self.string:DockMargin(0, 0, 0.005, 0)
	self.string:SetContentAlignment(1)

	--[*] the button itself with a check mark
	self.checkbox = jlib.vgui.Create("button", self)
	self.checkbox:SetText("")
	self.checkbox:Dock(FILL)
	self.checkbox:DockMargin(0, 0, 0, 0)
	self.checkbox.Paint = function(self, w, h)
		local border = jv.GetBorder("btn")
		local round = jv.GetRound("weak")
		local parent = self:GetParent()
	    if (self.Hovered) then 
	        draw.RoundedBox(round, 0, 0, w, h, clr["btn_line_h"])
	        draw.RoundedBox(round, border/2, border/2, w-border, h-border, parent.color)
	    else
	        draw.RoundedBox(round, 0, 0, w, h, clr["btn_line"])
	        draw.RoundedBox(round, border/2, border/2, w-border, h-border, parent.color)       
	    end
	    surface.SetMaterial(parent:GetImage())
	    surface.SetDrawColor(clr["btn_line"])
	    surface.DrawTexturedRect(border/2, border/2, w-border, h-border) 	
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
    jv["Scale"](self, data)
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
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
--[+] Setting the type for different appearances :--:--:--:--:--:--:--:--:--:--:--:}>                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Set by value (false/true) :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetValue(val)
	self.value = val
	self:SetStatus(val)
end

function PANEL:GetValue()
	return self:GetStatus()
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting the text :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetText(val)
	if not (val) or (val == "") then self.string:Remove() end
	self.text = val
	self.string:SetText(val)
end

function PANEL:GetText()
	return self.text
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the status :--:--:--:--:--:--:--:--:--:--:--:}>                                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetStatus()
    return self.status
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We get a picture (cross or check mark?) :--:--:--:--:--:--:--:--:--:--:--:}>                            |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:GetImage()
    return self.image
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Controlling the ability to press :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
--------------------------------------------------------------------------------------------------------------|>
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Technical setup (for manipulating positions in the button) :--:--:--:--:--:--:--:--:--:--:--:}>         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetStatus(val)
	local icon, clr = icon(), clr()
    self.status = val
    if (self.status) then 
        self.num1, self.num2 = 2, 2
        self.num3, self.num4 = 29, 29
        self.image = icon["accept"]
        self.color = clr["green"]
    else 
        self.num1, self.num2 = 5, 5
        self.num3, self.num4 = 25, 25
        self.image = icon["close"]
        self.color = clr["red"]
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint(w, h)
	local jv, clr = jv(), clr()
    local circ, alpha = 0, 255
    local border = jv.GetBorder("btn")
    local round = jv.GetRound("base")
    if (self:GetType() == "round") then circ = round end
    if not (bool_typs[self:GetType()]) then alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr["line"], alpha))
    draw.RoundedBox(circ, border/2, border/2, w-border, h-border, ColorAlpha(clr["body"], alpha))
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.checkbox-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 