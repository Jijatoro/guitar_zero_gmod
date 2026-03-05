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
    local clr = clr()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.truename = "table"

    --[*] pages
    self.currentpage = false
    self.pagesize = false
    self.maxpage = false
    
    --[*] data management
    self.data = {}
    self.current_keys = {}
    --[*] example data:
    -- local data = {
    --     info = {
    --         name = {"name1", "name2", ""}, 
    --         tall = 0.2,
    --         wide = {0.3, 0.2, 0.5},
    --         margin = {0, 0, 0.05}
    --     }
    --     all = {
    --         [1] = {
    --             --[*] search data
    --             [1] = {
    --                 find = {}
    --                 create = function() 
    --                     return pnl
    --                 end
    --             }, ... [3]
    --         }, ... [n]
    --     }
    -- }

    self.head = jlib.vgui.Create("panel", self)
    self.head:SetType("base")
    self.head:Scale(1, 0.08)
    self.head:Dock(TOP)
    self.head:Margin(0, 0, 0.01, 0)

    self.body = jlib.vgui.Create("scroll", self)
    self.body:SetType("none")
    self.body:Scale(1, 0.9)
    self.body:Dock(FILL)
    self.body:Margin(0, 0, 0, 0)

    self:Margin(0.005, 0.005, 0.005, 0)
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

local function UpdateText(self)
    if not (self.text) then return end
    if (self.maxpage >= 100000) then 
        self.text:SetText(tostring(self.currentpage) .. "/" .. "X")
    else
        self.text:SetText(tostring(self.currentpage) .. "/" .. tostring(self.maxpage))
    end
end

function PANEL:FillContent()
    self.body:Restart()
    local data, keys = self.data, self.current_keys
    local current = self.currentpage
    local size = self.pagesize 

    --[*] Changing the keys for the current page.
    local use_keys = {}
    local amount = 0
    if (size) then
        local start_num = (current*size)-(size-1)
        if (current == 1) then start_num = 1 end
        local end_num = (start_num+size)-1
        for i = start_num, end_num do
            amount = amount + 1
            use_keys[amount] = i
        end
    else
        for i = 1, #data.all do
            amount = amount + 1
            use_keys[amount] = i
        end        
    end

    --[*] header content
    local head = self.head
    if not (head.readybtn) then
        for id, v in ipairs(data.info.name) do 
            local btn_head = jlib.vgui.Create("button", head)
            btn_head:SetDraw(false)
            btn_head:SetText(data.info.name[id])
            btn_head:Scale(data.info.wide[id], 1)
            btn_head:Dock(LEFT)
            btn_head:Margin(0, 0, 0, 0)
        end
        head.readybtn = true
    end

    --[*] Generating the elements that should be visible.
    local all_data = data.all
    for _, key in ipairs(use_keys) do
        if not (all_data[key]) then break end
        local pnl = jlib.vgui.Create("panel", self.body)
        pnl:SetType("none")
        pnl:Scale(1, data.info.tall)
        pnl:Dock(TOP)
        pnl:Margin(0, 0, 0.01, 0)

        for id, v in ipairs(all_data[key]) do
            local end_dock = 0
            if (id == #all_data[key]) then end_dock = 1 end
            local pnl_element = jlib.vgui.Create("panel", pnl)
            pnl_element:SetType("none")
            pnl_element:Scale(data.info.wide[id], 1)
            pnl_element:Dock(LEFT)
            pnl_element:Margin(data.info.margin[id], 0, end_dock, 0)

            local element = v.create(pnl_element)
            element:Dock(FILL)
        end
    end
end

function PANEL:CreateFooter()
    local jv = jv()
    local size = self.pagesize
    if not (size) then return end
    if (IsValid(self.footer)) then return end

    self.footer = jlib.vgui.Create("panel", self)
    self.footer:Scale(0.99, 0.08)
    self.footer:Dock(BOTTOM)
    self.footer:Margin(0, 0.005, 1, 0.015)
    self.footer:SetType("none")

    self.fpanel = jlib.vgui.Create("panel", self.footer)
    self.fpanel:Scale(0.2, 1)
    self.fpanel:SetType("round")
    self.fpanel:Dock(FILL)
    self.fpanel:Margin(0.4, 0, 0.4, 0)    

    self.btn_left = jlib.vgui.Create("button", self.fpanel)
    self.btn_left:Scale(0.2, 1, 2)
    self.btn_left:Dock(LEFT)
    self.btn_left:Margin(0, 0, 0, 0) 
    self.btn_left:SetImage("arrow_left")
    self.btn_left:SetSound("cancel")
    self.btn_left.DoClick = function()
        self:PageNext(false)
    end 

    self.text = jlib.vgui.Create("label", self.fpanel)
    self.text:Scale(0.43, 1)
    self.text:Dock(FILL)
    self.text:Margin(0.06, 0, 0.06, 0)
    jv.SetFont(self.text, "p3", true)
    self.text:SetContentAlignment(5)
    UpdateText(self)

    self.btn_right = jlib.vgui.Create("button", self.fpanel)
    self.btn_right:Scale(0.2, 1, 2)
    self.btn_right:Dock(RIGHT)
    self.btn_right:Margin(0, 0, 0, 0) 
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

function PANEL:SetData(data, size, restart)
    if not (IsValid(self)) then return end
    if not (data) or not (istable(data)) or (table.IsEmpty(data)) then return end
    self.data = data
    self.pagesize = size

    --[*] determining the page size
    if (size) then
        local arg1, arg2 = math.modf(#data.all/size) 
        if (arg2 > 0) then arg1 = arg1 + 1 end
        self.maxpage = arg1 
        if (self.maxpage == 0) then self.maxpage = 1 end 
    end
    
    --[*] reconfiguring the current page if it already exists
    if (self.currentpage) then
        if (self.currentpage > self.maxpage) then self.currentpage = 1 end
    else self.currentpage = 1 end   

    self:FillContent()
    self:CreateFooter()
    UpdateText(self)
end

function PANEL:GetData()
    return self.data
end

function PANEL:Paint(w, h)
    return false
end

vgui.Register("jlib.table-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 