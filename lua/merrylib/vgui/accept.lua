local PANEL = {}

-- ["heart"], ["lamp"], ["question"], ["exclamation"], ["reward"], ["star"] *

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false

    self.mat = "question"
    self:SetSize(400, 300)

    self.func = nil

    self.string = vgui.Create("MerryUI.Label", self)
    self.string:SetText("Вы точно хотите совершить это действие?")
    self.string:SetType("p1")
    self.string:Dock(TOP)
    self.string:DockMargin(25, 60, 25, 0)
    self.string:SetSize(250, 150)
    self.string:SetWrap(true)
    self.string:SetContentAlignment(5)
 
    self.btnaccept = vgui.Create("MerryUI.Button", self)
    self.btnaccept:SetText("Хочу")
    self.btnaccept:SetSize(105, 95)
    self.btnaccept:Dock(LEFT)
    self.btnaccept:DockMargin(95, 15, 0, 10)
    self.btnaccept.DoClick = function()
    	self:Remove()
        if (self.func != nil) then
            self.func()
        end
    end
    self.btnreject = vgui.Create("MerryUI.Button", self)
    self.btnreject:SetText("Нет")
    self.btnreject:SetSize(95, 95)
    self.btnreject:Dock(LEFT)
    self.btnreject:DockMargin(10, 15, 0, 10)
    self.btnreject.DoClick = function()
        self:Remove()
    end
end

function PANEL:SetFunc(func)
    self.func = func
end

function PANEL:SetText(text)
    self.string:SetText(text)
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]
    
	draw.RoundedBox(32, 0, 0, w, h, theme["p_line"])
	draw.RoundedBox(32, 3, 3, w-6, h-6, theme["p_body"])

    surface.SetMaterial(Merry.Mat[self.mat].mat)
    surface.SetDrawColor(theme["color_icon"])
    surface.DrawTexturedRect(155, 5, 90, 90)
end

vgui.Register("MerryUI.Accept", PANEL, "Panel")