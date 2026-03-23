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
local bool_typs = {["base"] = true, ["round"] = true}

--------------------------------------------------------------------------------------------------------------|>
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.truename = "panel"
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "base"
    self.color_alpha = 200
    self.cust_size = {0, 0}

    self.image = false
    self.image_alpha = 255
    self.image_clr = Color(255, 255, 255)  
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
    local arg = {...}
    local parent = self:GetParent()
    if not (parent) then
        local w, h = ScrW(), ScrH()
        local size_x, size_y = arg[1]*w, arg[2]*h
        self.cust_size = {size_x, size_y}
        self:SetSize(w*size_x, h*size_y)
    else
        local jv = jv()
        jv["Scale"](self, arg)
    end
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
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
function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Setting a background image :--:--:--:--:--:--:--:--:--:--:--:}>                                         |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetImage(arg)
    local jv = jv()
    if not (isstring(arg)) then return end
    if (string.StartWith(arg, "https")) then
        jv.UrlImage(arg, function(mat)
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

--------------------------------------------------------------------------------------------------------------|>
--[+] Managing the color of a background image :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetColor(arg1, arg2)
    self.image_clr = arg1
    if (arg2) then self.image_alpha = arg2 end
end

function PANEL:GetColor()
    return self.image_clr
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Controlling the transparency of the background image and body :--:--:--:--:--:--:--:--:--:--:--:}>      |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetColorAlpha(arg)
    self.color_alpha = arg
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Drawing the body :--:--:--:--:--:--:--:--:--:--:--:}>                                                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Paint(w, h)
    local jv, clr = jv(), clr()
    local border = jv.GetBorder("pnl")
    local round = jv.GetRound("base")
    local circ = 0
    local img_p_x, img_p_y, img_w_y, img_h_y = 0, 0, 0, 0

    if (self:GetType() == "round") then circ = round end
    if not (bool_typs[self:GetType()]) then self.color_alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(clr["line"], self.color_alpha))
    draw.RoundedBox(circ, border/2, border/2, w-border, h-border, ColorAlpha(clr["body"], self.color_alpha))

    if (self:GetImage()) and (self:GetType() != "round") then
        surface.SetMaterial(Material(self:GetImage()))
        surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
        surface.DrawTexturedRect(img_p_x+border/2, img_p_y+border/2, w-img_w_y-border, h-img_h_y-border) 
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Executed when the screen resolution changes :--:--:--:--:--:--:--:--:--:--:--:}>                        |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:OnScreenSizeChanged(old_w, old_h, new_w, new_h)
    --[*] adapting the element size to screen resolutions
    local arg = self.cust_size
    if not (arg) then return end
    self:SetSize(new_w*arg[1], new_h*arg[2])

    local pos_x, pos_y = self:GetPos()
    local new_x, new_y = new_w*(pos_x/old_w), new_h*(pos_y/old_h)
    self:SetPos(new_x, new_y)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.panel-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 