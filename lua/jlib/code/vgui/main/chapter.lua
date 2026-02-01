--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.hasText, self.hasTitle, self.wrapped = false, false, false
	self:SetSize(300, 55)
    self.pnltype = "base"
    self.panels = {}
    self.objects = {}
    self.position = "h" --[*] h/v (horizontal / vertical)
    self.form = "t" --[*] t/i (text / icon)
end

function PANEL:SetType(arg)
	self.pnltype = arg
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetPosition(arg)
	self.position = arg
end

function PANEL:GetPosition()
	return self.position
end

function PANEL:SetForm(arg)
	self.form = arg
end

function PANEL:GetForm()
	return self.form
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

local function AdjustSize(self)
	local size_w, size_h = self:GetSize()
	self:SetSize(size_w, 40*(#self.panels or 1)+17)
end

local function Done(self, id)
	for k, v in ipairs(self.objects) do
		local result = k == id
		v:SetStatus(result)
		if (result) then
			self.panels[k]:SetVisible(true)
		else
			self.panels[k]:SetVisible(false)
		end
	end
end

local function Generate(self)
    local dock local marg = {}
    if (self.position == "h") then dock = LEFT marg = {6, 7, 0, 6} else dock = TOP marg = {6, 5, 6, 0} AdjustSize(self) end
	for k, v in ipairs(self.panels) do
		local btn = jlib.vgui.Create("button", self)
		if (self.form == "t") then btn:SetText(v:GetName() or "?") else btn:SetText("") btn:SetImage(v:GetName() or "question") end
		btn:Dock(dock)
		btn:DockMargin(unpack(marg))
		btn.DoClick = function() Done(self, k) end
		if (k == 1) then btn:SetStatus(true) end
		self.objects[k] = btn
	end	 
end

function PANEL:SetData(...)
	local args = {...}
	if not (table.IsEmpty(args)) then
		self.panels = args
	end

    if not (table.IsEmpty(self.panels)) then
	    if not (table.IsEmpty(self.objects)) then
	    	for _, v in pairs(self.objects) do
	    		v:Remove()
	    	end
	    end    	
       	Generate(self)
    end	
end

vgui.Register("jlib.chapter-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 