local PANEL = {}

function PANEL:Init()
    self.hasText = false
    self.hasTitle = false
    self.wrapped = false
    self.pnltype = "base"
    self.pnlvalue = nil
    self.imgtype = nil
end

function PANEL:SetType(type)
	self.pnltype = type
end

function PANEL:GetType()
	return self.pnltype
end

function PANEL:SetImageType(type)
	self.imgtype = type
end

function PANEL:GetImageType()
	return self.imgtype
end

function PANEL:SetValue(value)
	self.pnlvalue = value
end

function PANEL:GetValue()
	return self.pnlvalue
end

local function DrawCircle(x, y, radius, segments)
    local circle = {}
    
    for i = 1, segments do
        local angle = math.rad((i / segments) * -360)
        local x_pos = x + math.sin(angle) * radius
        local y_pos = y + math.cos(angle) * radius
        
        circle[i] = {
            x = x_pos,
            y = y_pos
        }
    end
    
    surface.DrawPoly(circle)
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]
    
    if (self:GetValue() != nil) then
        if (self.imgtype == "circle") then
            -- Сначала рисуем рамку

            draw.RoundedBox(32, 0, 0, w, h, theme["p_line"])
            
            -- Настраиваем stencil для круглой маски
            render.ClearStencil()
            render.SetStencilEnable(true)
            
            render.SetStencilWriteMask(1)
            render.SetStencilTestMask(1)
            render.SetStencilReferenceValue(1)
            render.SetStencilCompareFunction(STENCIL_ALWAYS)
            render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
            render.SetStencilFailOperation(STENCILOPERATION_KEEP)
            render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
            
            -- Рисуем круг для маски (немного больше, чтобы избежать артефактов)
            draw.NoTexture()
            surface.SetDrawColor(color_white)
            DrawCircle(w/2, h/2, math.min(w, h)/2 - 2, 64) -- Увеличиваем segments до 64 для сглаживания
            
            -- Применяем маску
            render.SetStencilCompareFunction(STENCIL_EQUAL)
            render.SetStencilPassOperation(STENCILOPERATION_KEEP)

            -- Рисуем текстуру с небольшим увеличением, чтобы заполнить края
            surface.SetMaterial(Material(self:GetValue(), "noclamp smooth"))
            surface.SetDrawColor(Color(255, 255, 255))
            surface.DrawTexturedRect(2, 2, w-4, h-4) -- Увеличиваем на 1 пиксель с каждой стороны
            
            render.SetStencilEnable(false)
        else
            -- Для некруглых изображений
            surface.SetMaterial(Material(self:GetValue(), "noclamp smooth"))
            surface.SetDrawColor(Color(255, 255, 255))
            surface.DrawTexturedRect(3, 3, w-6, h-6)
        end
    else
        -- Рисуем placeholder
        if (self:GetType() == "base") then
            draw.RoundedBox(0, 0, 0, w, h, theme["p_line"])
            draw.RoundedBox(0, 3, 3, w-6, h-6, theme["p_body"])
        elseif (self:GetType() == "round") then
            draw.RoundedBox(32, 0, 0, w, h, theme["p_line"])
            draw.RoundedBox(32, 3, 3, w-6, h-6, theme["p_body"])
        end
    end    
end

vgui.Register("MerryUI.Panel", PANEL, "Panel")