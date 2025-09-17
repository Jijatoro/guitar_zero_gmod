local PANEL = {}

-- ["heart"], ["lamp"], ["question"], ["exclamation"], ["reward"], ["star"] *

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false

    self.text = ""
    self.textbtn = "ОК"
    self.mat = "exclamation"
    self:SetSize(400, 300)

    self.string = vgui.Create("MerryUI.Label", self)
    self.string:SetText(self:GetText())
    self.string:SetType("p1")
    self.string:Dock(TOP)
    self.string:DockMargin(25, 60, 25, 0)
    self.string:SetSize(250, 200)
    self.string:SetWrap(true)
    self.string:SetContentAlignment(5)
 
    self.btnclose = vgui.Create("MerryUI.Button", self)
    self.btnclose:SetText(self:GetTextBtn())
    self.btnclose:SetSize(80, 60)
    self.btnclose:Dock(BOTTOM)
    self.btnclose:DockMargin(65, 35, 65, 8)
    self.btnclose.DoClick = function()
    	self:Remove()
    end
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]
    
	draw.RoundedBox(32, 0, 0, w, h, theme["p_line"])
	draw.RoundedBox(32, 3, 3, w-6, h-6, theme["p_body"])

    surface.SetMaterial(Merry.Mat[self:GetMat()].mat)
    surface.SetDrawColor(theme["color_icon"])
    surface.DrawTexturedRect(155, 5, 90, 90)
end

function PANEL:SetText(src)
	self.text = src
	self.string:SetText(self.text)
end

function PANEL:GetText()
	return self.text
end

function PANEL:SetTextBtn(src)
	self.textbtn = src
end

function PANEL:GetTextBtn()
	return self.textbtn
end

function PANEL:SetMat(val)
	self.mat = val
end

function PANEL:GetMat()
	return self.mat
end

vgui.Register("MerryUI.Warning", PANEL, "Panel")