--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
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
        txt = "t3-24"
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
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self:SetSize(580, 400)
    self.pnltype = "round"
    self.value = {}
    --[*] Structure |~| Cтруктура
        -- local my_data = {
        --  [1] = {
        --      src = "text",
        --      mat = "photo (path)"
        --  },
        --  [2] = {
        --      src = "text 2",
        --      mat = "photo (path)"
        --  },        
        -- }
    --[*]
    self.key = 1

    self.string = jlib.vgui.Create("label", self)
    self.string:SetText("")
    self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.string:Dock(TOP)
    self.string:DockMargin(15, 220, 0, 0)
    self.string:SetSize(550, 120)
    self.string:SetWrap(true)  

    self.panel = jlib.vgui.Create("panel", self)
    self.panel:SetType("nodraw")
    self.panel:SetSize(85, 40)

    self.btnleft = jlib.vgui.Create("button", self.panel)
    self.btnleft:SetImage("arrow_left")
    self.btnleft:SetSize(40, 35)
    self.btnleft:Dock(LEFT)
    self.btnleft:DockMargin(0, 0, 0, 0)
    self.btnleft.DoClick = function()
    	if not (table.IsEmpty(self:GetValue())) then
    		if (self:GetKey()>1) then
    			self:AddKey(-1)
    		end
    	end
    end

    self.btnright = jlib.vgui.Create("button", self.panel)
    self.btnright:SetImage("arrow_right")
    self.btnright:SetSize(40, 35)
    self.btnright:Dock(LEFT)
    self.btnright:DockMargin(3, 0, 0, 0)
    self.btnright.DoClick = function()
    	if not (table.IsEmpty(self:GetValue())) then
    		if (self:GetKey()<#self:GetValue()) then
    			self:AddKey(1)
    		end
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
	self.string:SetText(self:GetValue()[self:GetKey()].src)
end

function PANEL:GetValue()
	return self.value
end

function PANEL:SetData(val)
    self.value = val
    self.string:SetText(self:GetValue()[self:GetKey()].src)
end

function PANEL:GetData()
    return self.value
end

function PANEL:SetKey(val)
	self.key = val
	self.string:SetText(self:GetValue()[self:GetKey()].src)
end

function PANEL:AddKey(val)
	self.key = self.key+val
	self.string:SetText(self:GetValue()[self:GetKey()].src)
end

function PANEL:GetKey()
	return self.key
end

function PANEL:Paint(w, h)
	if (self:GetType() == "base") then
		draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
		draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["body"])
	elseif (self:GetType() == "round") then
		draw.RoundedBoxEx(32, 0, 0, w, h, clr()["line"], false, false, true, true)
		draw.RoundedBoxEx(32, 3, 3, w-6, h-6, clr()["body"], false, false, true, true)
	end

	draw.RoundedBox(0, 0, 2, w, h-54, clr()["line"])

    surface.SetMaterial(Material(self:GetValue()[self:GetKey()].mat))
    surface.SetDrawColor(Color(255, 255, 255))
    surface.DrawTexturedRect(3, 5, w-6, h-60)		

	draw.RoundedBox(0, 3, 215, w-6, h-270, ColorAlpha(clr()["t_bgclr"], 200))	
end

function PANEL:PerformLayout()
    self.panel:CenterHorizontal(0.5)
    self.panel:CenterVertical(0.93)
end

vgui.Register("jlib.gallery-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 