--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local function clr() return jlib.cfg.themes[jlib.cfg.theme]  or {} end
local all_typs = {"base", "round"}

--------------------------------------------------------------------------------------------------------------|>
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self.hasText, self.hasTitle, self.wrapped = false, false, false
    self.pnltype = "base"
    self.pnlname = nil
    self.color_alpha = 200

    self.image = nil
    self.image_alpha = 255
    self.image_clr = Color(255, 255, 255)  
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

function PANEL:SetColorAlpha(arg)
    self.color_alpha = arg
end

function PANEL:Paint(w, h)
    local c = clr()
    local circ = 0
    local ad_pos, ad_size = 3, 6
    local img_p_x, img_p_y, img_w_y, img_h_y = 0, 0, 0, 0

    if (self:GetType() == "round") then circ = 32 end
    if not (table.KeyFromValue(all_typs, self:GetType())) then self.color_alpha = 0 end

    draw.RoundedBox(circ, 0, 0, w, h, ColorAlpha(c["line"], self.color_alpha))
    draw.RoundedBox(circ, ad_pos, ad_pos, w-ad_size, h-ad_size, ColorAlpha(c["body"], self.color_alpha))

    if (self:GetImage()) and (self:GetType() != "round") then
        surface.SetMaterial(Material(self:GetImage()))
        surface.SetDrawColor(ColorAlpha(self:GetColor(), self.image_alpha))
        surface.DrawTexturedRect(img_p_x+ad_pos, img_p_y+ad_pos, w-img_w_y-ad_size, h-img_h_y-ad_size) 
    end
end

vgui.Register("jlib.panel-main", PANEL, "Panel")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 