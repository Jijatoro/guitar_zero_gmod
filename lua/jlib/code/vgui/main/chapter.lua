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
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
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
    if (data) and not (table.IsEmpty(data)) then self.dockmargin = data end
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
function PANEL:SetType(arg)
	self.pnltype = arg
end

function PANEL:GetType()
	return self.pnltype
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Set the direction for elements (top (h), right (v)) :--:--:--:--:--:--:--:--:--:--:--:}>                |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetPosition(arg)
	self.position = arg
end

function PANEL:GetPosition()
	return self.position
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting the shape for a button (icon (i) or text (t)) :--:--:--:--:--:--:--:--:--:--:--:}>              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetForm(arg)
	self.form = arg
end

function PANEL:GetForm()
	return self.form
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Adapting the size of the button container :--:--:--:--:--:--:--:--:--:--:--:}>                          |>
--------------------------------------------------------------------------------------------------------------|>
local function AdjustSize(self)
	local size_w, size_h = self:GetSize()
	self:SetSize(size_w, 40*(#self.panels or 1)+17)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Some button was pressed :--:--:--:--:--:--:--:--:--:--:--:}>                                            |>
--------------------------------------------------------------------------------------------------------------|>
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Let's create buttons :--:--:--:--:--:--:--:--:--:--:--:}>                                               |>
--------------------------------------------------------------------------------------------------------------|>
local function Generate(self)
    local dock local marg = {}
    local max = #self.panels
    local amount = 1/max

    --[*] managing the position
    if (self.position == "h") then 
    	dock = LEFT 
    	marg = {0.001, 0, 0.001, 0} 
    else 
    	dock = TOP 
    	marg = {0.001, 0, 0.001, 0} 
    	AdjustSize(self) 
    end
	
	--[*] button generation
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting data for buttons :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.chapter-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 