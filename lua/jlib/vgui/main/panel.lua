--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local all_typs = {"base", "round"}

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
    self.pnltype = "base"
    self.pnlname = nil

    self.image = nil
    self.image_alpha = 255
    self.image_clr = Color(255, 255, 255)  
    
    self.currentpage = nil
    self.pagesize = nil
    self.maxpage = nil
    self.data = nil
    --[*] Structure |~| Cтруктура
        -- local my_data = {
        --  [1] = {
        --      data = {[1] = {"word", "key", "life"}},
        --      create = function(pnl)
        --      end
        --  },
        --  [2] = {
        --      data = {[1] = {"word", "key", "life"}},
        --      create = function(pnl)
        --      end        
        --  },
        -- }
    --[*]
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetName(arg)
    self.pnlname = arg
end

function PANEL:GetName(arg)
    return self.pnlname
end

function PANEL:SetImage(arg)
    if not (isstring(arg)) then return end
    if (string.StartWith(arg, "https")) then
        jlib.UrlImage(arg, function(mat)
            if (mat) then
                self.image = mat
                return
            else
                return
            end
        end)
    else
        self.image = arg
    end
end

function PANEL:GetImage()
    return self.image
end

function PANEL:SetColor(arg1, arg2)
    self.image_clr = arg1
    if (arg2) then self.image_alpha = arg2 end
end

function PANEL:GetColor()
    return self.image_clr
end

function PANEL:Paint(w, h)
    local circ, alpha = 0, 255
    local ad_pos, ad_size = 3, 6
    local img_p_x, img_p_y, img_w_y, img_h_y = 0, 0, 0, 0

    if (self:GetType() == "round") then circ = 32 end
    if not (table.KeyFromValue(all_typs, self:GetType())) then alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr()["line"], alpha))
    draw.RoundedBox(circ, ad_pos, ad_pos, w-ad_size, h-ad_size, ColorAlpha(clr()["body"], alpha))

    if (self:GetImage()) and (self:GetType() != "round") then
        surface.SetMaterial(Material(self:GetImage()))
        surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
        surface.DrawTexturedRect(img_p_x+ad_pos, img_p_y+ad_pos, w-img_w_y-ad_size, h-img_h_y-ad_size) 
    end
end

function PANEL:PageNext(bool)
    if not IsValid(self) then return end

    local current = self.currentpage
    local size = self.pagesize
    local max = self.maxpage

    if (bool) then
        if (current+1) <= (max) then
            self.currentpage = self.currentpage+1
            self:PageGenerate()
        end
    else
        if (current-1) > (0) then
            self.currentpage = self.currentpage-1
            self:PageGenerate()
        end
    end
end

function PANEL:PageGenerate()
    self:Clear()

    local current = self.currentpage
    local size = self.pagesize
    local max = self.maxpage
    local data = self.data

    local panel = jlib.vgui.Create("panel", self)
    panel:SetSize(180, 45)
    panel:Dock(BOTTOM)
    panel:DockMargin(190, 0, 190, 5)
    panel:SetType("round") 

    local btn_left = jlib.vgui.Create("button", panel)
    btn_left:Dock(LEFT)
    btn_left:DockMargin(0, 0, 0, 0) 
    btn_left:SetImage("arrow_left")
    btn_left:SetSound("cancel")
    btn_left.DoClick = function()
        self:PageNext(false)
    end 

    local text = jlib.vgui.Create("label", panel)
    text:Dock(LEFT)
    text:DockMargin(4, 0, 5, 0)
    if (max >= 100000) then 
        text:SetText(tostring(current) .. "/" .. "X")
    else
        text:SetText(tostring(current) .. "/" .. tostring(max))
    end
    text:SetFont("s1-16")
    text:SetSize(80, 45)
    text:SetContentAlignment(5)

    local btn_right = jlib.vgui.Create("button", panel)
    btn_right:Dock(LEFT)
    btn_right:DockMargin(0, 0, 0, 0) 
    btn_right:SetImage("arrow_right")
    btn_right:SetSound("cancel")
    btn_right.DoClick = function()
        self:PageNext(true)      
    end     

    local start
    if (current == 1) then start = 1 else start = (current-1)*size+1 end
    for i = start, (start+size)-1 do
        if (data[i]) then
            data[i].create(self)
        end
    end   
end

function PANEL:SetData(data, size)
    if not (data) or not (istable(data)) or (table.IsEmpty(data)) then return end
    self.data = data
    self.pagesize = size or nil

    if not (size) then
        self:Clear()
        for k, v in ipairs(self.data) do
            v.create(self)
        end
    else
        self.currentpage = 1
        self.maxpage = math.ceil(#data/size)
        if (self.maxpage == 0) then self.maxpage = 1 end
        self:PageGenerate()
    end
end

function PANEL:GetData()
    return self.data
end

vgui.Register("jlib.panel-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 