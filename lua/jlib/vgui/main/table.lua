--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        txt = "s1-16",
        btn = "s1-14"
    },
    ["anime"] = {
        txt = "a3-16",
        btn = "a2-14"
    },
    ["fantasy"] = {
        txt = "f6-16",
        btn = "s1-14"
    },
    ["cyber"] = {
        txt = "s1-16",
        btn = "c3-14"
    },    
    ["horror"] = {
        txt = "s1-16",
        btn = "h4-14"
    },
    ["terminal"] = {
        txt = "t5-16",
        btn = "t4-14"
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
--[+] Main functions |~| Основные функции :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "base"
    self.pnlname = nil
    self:SetSize(400, 600)
    
    self.currentpage = nil
    self.pagesize = nil
    self.maxpage = nil
    self.data = nil
    -- local my_data = {
    --     category = {"имя", "фамилия", "возраст"},
    --     size = {350, 150, 153},
    --     data = {
    --         [1] = {"Иван", "Абобова", 52},
    --         [2] = {"Артур", "Гуеев", 32},
    --     }
    -- }

    self.headwork = nil
    self.head = jlib.vgui.Create("panel", self)
    self.head:Dock(TOP)
    self.head:DockMargin(0, 0, 0, 0)
    self.head:SetSize(400, 40)

    self.body = jlib.vgui.Create("scroll", self)
    self.body:Dock(FILL)
    self.body:DockMargin(0, 0, 0, 0)
    self.body:SetSize(400, 400)
end

local function UpdateText(self)
    if not (self.text) then return end
    if (self.maxpage >= 100000) then 
        self.text:SetText(tostring(self.currentpage) .. "/" .. "X")
    else
        self.text:SetText(tostring(self.currentpage) .. "/" .. tostring(self.maxpage))
    end
end

function PANEL:FillContent()
    self.body:Clear()

    if not (self.headwork) then
        self.head:Clear()
        for id, v in ipairs(self.data.name) do
            local cat = jlib.vgui.Create("button", self.head)
            cat:Dock(LEFT)
            cat:DockMargin(0, 0, 0, 0)
            cat:SetText(v)
            cat:SetSize(self.data.size[id], 40)
            cat:SetDraw(false)
            cat.s_num = 0
            cat.DoClick = function()
                if (cat.s_num == 0) then cat.s_num = 1 cat:SetText(v .. " ▲") elseif (cat.s_num ==  1) then cat.s_num = 2 cat:SetText(v .. " ▼") else cat.s_num = 0 cat:SetText(v) end
                if (cat.s_num == 0) then
                    table.Shuffle(self.data.data)
                    self:FillContent()
                end                
                if (cat.s_num == 1) then
                    table.sort(self.data.data, function(a, b) return a[id]>b[id] end)
                    self:FillContent()
                end
                if (cat.s_num == 2) then
                    table.sort(self.data.data, function(a, b) return a[id]<b[id] end)
                    self:FillContent()
                end
            end
            if (id == 1) then
                cat:DockMargin(3, 0, 0, 0)
            end
        end
    end
    self.headwork = true    

    if not (self.pagesize) then
        for _, c in ipairs(self.data.data) do --[*] data data XD
            local panel = jlib.vgui.Create("panel", self.body)
            panel:Dock(TOP)
            panel:DockMargin(0, 0, 0, 0)
            panel:SetSize(400, 40)
            for id, v in ipairs(c) do
                local text = jlib.vgui.Create("textentry", panel)
                text:Dock(LEFT)
                text:DockMargin(0, 3, 0, 3)
                text:SetText(v) 
                text:SetSize(self.data.size[id], 40)
                text:SetType("base")
                text:SetEnabled(false)
                if (id == 1) then
                    text:DockMargin(3, 3, 0, 3)
                end
            end       
        end
    else
        local current = self.currentpage
        local size = self.pagesize
        local max = self.maxpage

        local start
        if (current == 1) then start = 1 else start = (current-1)*size+1 end
        for i = start, (start+size)-1 do
            if (self.data.data[i]) then
                local panel = jlib.vgui.Create("panel", self.body)
                panel:Dock(TOP)
                panel:DockMargin(0, 0, 0, 0)
                panel:SetSize(400, 40)
                for id, v in ipairs(self.data.data[i]) do
                    local text = jlib.vgui.Create("textentry", panel)
                    text:Dock(LEFT)
                    text:DockMargin(0, 3, 0, 3)
                    text:SetText(v) 
                    text:SetSize(self.data.size[id], 40)
                    text:SetType("base")
                    text:SetEnabled(false)
                    if (id == 1) then
                        text:DockMargin(3, 3, 0, 3)
                    end
                end 
            end
        end
    end
end

function PANEL:CreateFooter()
    self.footer = jlib.vgui.Create("panel", self)
    self.footer:Dock(BOTTOM)
    self.footer:DockMargin(0, 3, 0, 5)
    self.footer:SetSize(400, 45)
    self.footer:SetType("none")

    self.fpanel = jlib.vgui.Create("panel", self.footer)
    self.fpanel:SetSize(180, 45)
    self.fpanel:SetType("round")
    self.fpanel.PerformLayout = function()
        self.fpanel:CenterHorizontal(0.5)
        self.fpanel:CenterVertical(0.5)
    end     

    self.btn_left = jlib.vgui.Create("button", self.fpanel)
    self.btn_left:Dock(LEFT)
    self.btn_left:DockMargin(0, 0, 0, 0) 
    self.btn_left:SetImage("arrow_left")
    self.btn_left:SetSound("cancel")
    self.btn_left.DoClick = function()
        self:PageNext(false)
    end 

    self.text = jlib.vgui.Create("label", self.fpanel)
    self.text:Dock(LEFT)
    self.text:DockMargin(4, 0, 5, 0)
    self.text:SetFont(jlib.vgui.GetFont(data_font, "txt"))
    self.text:SetSize(80, 45)
    self.text:SetContentAlignment(5)
    UpdateText(self)

    self.btn_right = jlib.vgui.Create("button", self.fpanel)
    self.btn_right:Dock(LEFT)
    self.btn_right:DockMargin(0, 0, 0, 0) 
    self.btn_right:SetImage("arrow_right")
    self.btn_right:SetSound("cancel")
    self.btn_right.DoClick = function()
        self:PageNext(true)      
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
            self:FillContent()
        end
    else
        if (current-1) > (0) then
            self.currentpage = self.currentpage-1
            self:FillContent()
        end
    end

    UpdateText(self)
end

function PANEL:SetData(data, size)
    if not (data) or not (istable(data)) or (table.IsEmpty(data)) then return end
    self.data = data
    self.pagesize = size or nil
    self.headwork = false

    if not (size) then
        self:FillContent()
    else
        self.currentpage = 1
        self.maxpage = math.ceil(#data.data/size)
        if (self.maxpage == 0) then self.maxpage = 1 end
        if not (self.footer) then self:CreateFooter() end
        self:FillContent()
        UpdateText(self)
    end
end

function PANEL:GetData()
    return self.data
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

function PANEL:Paint(w, h)
    if (self:GetType() == "base") then
        draw.RoundedBox(0, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(0, 3, 3, w-6, h-6, clr()["body"])
    elseif (self:GetType() == "round") then
        draw.RoundedBox(32, 0, 0, w, h, clr()["line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, clr()["body"])
    end 
end

vgui.Register("jlib.table-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 