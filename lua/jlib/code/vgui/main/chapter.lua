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

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.truename = "chapter"
	self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "none"
    self.panels = {}
    self.objects = {}
    self.position = "h" --[*] h/v (horizontal / vertical)
    self.form = "t" --[*] t/i (text / icon)
end

function PANEL:SetName(arg)
	self.truename = arg
end

function PANEL:GetName()
	return self.truename
end

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

function PANEL:PerformLayout()
    if not (self.dockmargin) then return end
    self:Margin()
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
	local jv, clr = jv(), clr()
	local border = jv.GetBorder("pnl")
	local round = jv.GetRound("base")
	if (self:GetType() == "base") then
		draw.RoundedBox(0, 0, 0, w, h, clr["line"])
		draw.RoundedBox(0, border/2, border/2, w-border, h-border, clr["body"])
	elseif (self:GetType() == "round") then
		draw.RoundedBox(round, 0, 0, w, h, clr["line"])
		draw.RoundedBox(round, border/2, border/2, w-border, h-border, clr["body"])
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
    local max = #self.panels
    local amount = 1/max
    if (self.position == "h") then dock = LEFT marg = {0.001, 0, 0.001, 0} else dock = TOP marg = {0.001, 0, 0.001, 0} AdjustSize(self) end
	for k, v in ipairs(self.panels) do
		local pnl_btn = jlib.vgui.Create("panel", self)
		pnl_btn:SetType("none")
		pnl_btn:Scale(amount, 1)
		pnl_btn:Dock(dock)
		pnl_btn:Margin(unpack(marg))

		local btn = jlib.vgui.Create("button", pnl_btn)
		if (self.form == "t") then btn:SetText(v.chname or "?") else btn:SetText("") btn:SetImage(v.chname or "question") end
		btn:Dock(FILL)
		btn:Margin(0.09, 0.09, 0.09, 0.09)
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
	    	for _, v in ipairs(self.objects) do
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