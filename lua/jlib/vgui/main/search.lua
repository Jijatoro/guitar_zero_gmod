--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
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
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
	self.hasText, self.hasTitle, self.wrapped = false, false, false
	self:SetSize(267, 60)
    self.value = false

   	self.area = nil
   	self.area_data = nil
   	--[*] Structure |~| Cтруктура
	   	-- local my_data = {
	   	-- 	[1] = {
	   	-- 		find = {"word", "key", "life"},
	   	-- 	},
	   	-- 	[2] = {
	   	-- 		find = {"jack", "basil", "mari"},
	   	-- 	},
	   	-- }
   	--[*]
	
	self.text_entry = jlib.vgui.Create("textentry", self)
	self.text_entry:SetPlaceholderText(lan()["your-request"])
	self.text_entry:SetEnabled(true)
	self.text_entry:SetSize(200, 60)
	self.text_entry:Dock(LEFT)
	self.text_entry:DockMargin(10, 8, 1, 8)
	self.text_entry.OnEnter = function()
	    self:Find()
	end

	self.button = jlib.vgui.Create("button", self)
	self.button:SetText("")
	self.button:SetImage("search")
	self.button:SetDraw(true)
	self.button:SetSize(45, 60)
	self.button:Dock(LEFT)
	self.button:DockMargin(3, 8, 0, 8)
	self.button.DoClick = function()
		self:Find()
	end
end

function PANEL:GetValue()
	return self.text_entry:GetValue()
end

function PANEL:SetValue(val)
	self.text_entry:SetValue(val)
end

function PANEL:SetData(data)
	self.area = data
end

function PANEL:Sort(bool)
	local pnl = self.area
	local value = self:GetValue()
	local amount = 0
	local new_data = {} new_data.data = {}

	if not (bool) then
		pnl:SetData(self.area_data, pnl.pagesize or 1)
	else
		if not (table.IsEmpty(self.area_data)) then
			for _, v in pairs(self.area_data.data) do
				for _, d in pairs(v) do
					if (string.StartWith(tostring(d), value)) then
						amount = amount + 1
						new_data.data[amount] = v
						break
					end
				end
			end

			for k, v in pairs(self.area_data) do
				if (k == "data") then continue end
				new_data.k = v
			end
			pnl:SetData(new_data, pnl.pagesize or 1)
		end
	end
end

function PANEL:Find()
	if not (self.area) or not (self.area:IsValid()) then return end
	if not (self.area_data) then
		self.area_data = self.area:GetData()
	end
	local arg = self:GetValue()
	if not (arg) or (arg == "") then
		self:Sort(false)
	else
		self:Sort(true)
	end
end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
	draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["body"])
end

vgui.Register("jlib.search-main", PANEL, "Panel")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 