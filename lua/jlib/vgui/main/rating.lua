--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-24"
    },
    ["anime"] = {
        txt = "a9-24"
    },
    ["fantasy"] = {
        txt = "f1-24"
    },
    ["cyber"] = {
        txt = "c5-24"
    },    
    ["horror"] = {
        txt = "h9-32"
    },
    ["terminal"] = {
        txt = "t4-24"
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

local function Done(pnl, num)
	for i = 1, 5 do
		if (i<=num) then pnl.stars[i]:SetStatus(true) else pnl.stars[i]:SetStatus(false) end
	end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.hasText, self.hasTitle, self.wrapped = false, false, false
	self:SetSize(375, 120)
    self.pnltype = "base"
    self.value = nil
    self.stars = {}
	self.text = ""  
	
	self.string = jlib.vgui.Create("label", self)
	self.string:SetText(self:GetText())
	self.string:SetFont(jlib.vgui.GetFont(data_font, "txt"))
	self.string:SetSize(100, 52)
	self.string:Dock(TOP)
	self.string:DockMargin(10, 0, 10, 0)
	self.string:SetContentAlignment(5)

	self.body = jlib.vgui.Create("panel", self)
	self.body:SetSize(400, 75)
	self.body:Dock(FILL)
	self.body:DockMargin(0, 0, 0, 0)

	for i = 1, 5 do
		local star = jlib.vgui.Create("button", self.body)
		star:SetImage("star")
		star:SetDraw(true)
		star:Dock(LEFT)
		star:DockMargin(7, 5, 5, 5)
		star:SetSize(65, 65)
		star.DoClick = function() self:SetValue(i) end
		self.stars[i] = star
	end
end

function PANEL:SetValue(val)
	if (val <= 0) then return end
	self.value = math.min(val, 5)
	Done(self, self.value)
end

function PANEL:GetValue()
	return self.value
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetText(val)
	self.text = val
	self.string:SetText(val)
end

function PANEL:GetText()
	return self.text
end

function PANEL:Paint(w, h)
	if (self:GetType() == "base") then
		draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
		draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["body"])
	elseif (self:GetType() == "round") then
		draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
		draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])
	else end 
end

vgui.Register("jlib.rating-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 