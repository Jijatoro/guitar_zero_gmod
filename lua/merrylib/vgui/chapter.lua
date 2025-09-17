local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false

    self.pnltype = "base"
    self.elements = {}
    self.action = nil
    self.btntbl = {}
    self.btn_active = nil
    self.form = 1

    self:DockPadding(5, 5, 5, 5)
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetForm(val)
	self.form = val
end

function PANEL:GetForm()
	return self.form
end

function PANEL:Paint(w, h)
	local theme = Merry.Themes[Merry.Theme]
	
	if (self:GetType() == "base") then
		draw.RoundedBox(0, 0, 0, w, h, theme["p_line"])
		draw.RoundedBox(0, 3, 3, w-6, h-6, theme["p_body"])
	elseif (self:GetType() == "round") then
		draw.RoundedBox(32, 0, 0, w, h, theme["p_line"])
		draw.RoundedBox(32, 3, 3, w-6, h-6, theme["p_body"])
	else end 
end

function PANEL:SetAction(val)
	self.action = val
	self.btn_active = self:GetElements()[1].text

	local side
	local dock_primary
	local dock
	if (self:GetForm() == 1) then
		side = LEFT
		dock_primary = {[1]=self:GetElements()[1].left, [2]=0, [3]=3, [4]=0}
		dock = {[1]=0, [2]=0, [3]=3, [4]=0}
	elseif (self:GetForm() == 2) then
		side = TOP
		dock_primary = {[1]=0, [2]=self:GetElements()[1].left, [3]=0, [4]=1}
		dock = {[1]=0, [2]=0, [3]=0, [4]=1}
	end

	if (val == "panel") then
		for i = 1, #self:GetElements() do
			local btn = vgui.Create("MerryUI.ButtonIcon", self)
				btn:Dock(side)
				if (i == 1) then
					btn:DockMargin(dock_primary[1], dock_primary[2], dock_primary[3], dock_primary[4])
				else
					btn:DockMargin(dock[1], dock[2], dock[3], dock[4])
				end
				btn:SetSize(47, 47)
				btn:SetImage(self:GetElements()[i].mat)
				btn.DoClick = function()
					for i = 1, #self:GetElements() do 
						self:GetElements()[i].panel:SetVisible(false)
						self.btntbl[i]:SetStatus(false)
					end

					btn:SetStatus(true)
					self:GetElements()[i].panel:SetVisible(true)
					self.btn_active = self:GetElements()[i].text
				end

				if (i == 1) then btn:SetStatus(true) end

				table.Add(self.btntbl, {[i] = btn})
		end
	elseif (val == "text") then
		for i = 1, #self:GetElements() do
			local btn = vgui.Create("MerryUI.Button", self)
				btn:Dock(side)
				if (i == 1) then
					btn:DockMargin(dock_primary[1], dock_primary[2], dock_primary[3], dock_primary[4])
				else
					btn:DockMargin(dock[1], dock[2], dock[3], dock[4])
				end
				btn:SetText(self:GetElements()[i].text)
				btn:SetFont("Merry.btnMin")
				btn:SetSize(self:GetElements()[i].size, 30)
				btn:SetDraw(false)
				btn.DoClick = function()
					for i = 1, #self:GetElements() do 
						self:GetElements()[i].panel:SetVisible(false)
						self.btntbl[i]:SetStatus(false)
					end

					btn:SetStatus(true)
					self:GetElements()[i].panel:SetVisible(true)
					self.btn_active = self:GetElements()[i].text
				end

				if (i == 1) then btn:SetStatus(true) end

				table.Add(self.btntbl, {[i] = btn})
		end		
	end
end

function PANEL:GetAction()
	return self.action
end

function PANEL:SetElements(val)
	self.elements = val
end

function PANEL:GetElements()
	return self.elements
end

vgui.Register("MerryUI.Chapter", PANEL, "Panel")