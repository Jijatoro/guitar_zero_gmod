local PANEL = {}

function PANEL:Init()
    local theme = Merry.Themes[Merry.Theme]
    
    self:SetText("Готово")
    self:SetFont("Merry.btn")
    self:SetTextColor(theme["title_btn"])

    self.status = false
    self.data = {}
    self.error_text = ""

    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)

    self:SetSize(210, 50)   
end

function PANEL:Paint(w, h)
    local theme = Merry.Themes[Merry.Theme]

    if (self.Hovered) or (self:GetStatus()) then 
        self:SetTextColor(theme["title_btn"])
        draw.RoundedBox(32, 0, 0, w, h, theme["btn_line_hover"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn_hover"])
    else
        self:SetTextColor(theme["title_btn_hover"])
        draw.RoundedBox(32, 0, 0, w, h, theme["btn_line"])
        draw.RoundedBox(32, 3, 3, w-6, h-6, theme["btn"])
    end
end

function PANEL:SetStatus(val)
    self.status = val
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:SetError(val)
    self.error_text = val
end

function PANEL:GetError()
    return self.error_text
end

function PANEL:SetData(val)
    self.data = val
end

-- local textentry_form = {
--     ["name"] = ""
-- }

function PANEL:CheckData()
    local reply = true
    for i = 1, #self.data do
        if (self.data[i].type == "selector") then
            if (self.data[i].val:GetValue() == "не выбрано") then
                self:SetError("Упс. Вы что-то ещё не выбрали!")
                reply = false
            end
        end

        if (self.data[i].type == "textentry") then
            if (self.data[i].val:GetValue() == "") then
                self:SetError("Упс. В '" .. self.data[i].name .. "' ничего не указано!")
                reply = false
            elseif (not MerryUI.blacksymbol(self.data[i].val:GetValue(), self.data[i].form)) then
                 self:SetError("Упс. В '" .. self.data[i].name .. "' есть запрещённый символ!")
                reply = false               
            elseif (MerryUI.len(self.data[i].val:GetValue())<self.data[i].min) then
                self:SetError("Упс. В '" .. self.data[i].name .. "' должно быть минимум " .. self.data[i].min .. " символа!")
                reply = false
            elseif (MerryUI.len(self.data[i].val:GetValue())>self.data[i].max) then
                self:SetError("Упс. В '" .. self.data[i].name .. "' не должно быть больше " .. self.data[i].max .. " символов!")
                reply = false
            elseif (self.data[i].blacklist != nil) then
                for j = 1, #self.data[i].blacklist do
                    if (self.data[i].val:GetValue() == self.data[i].blacklist[j].name) then
                        self:SetError("Упс. В '" .. self.data[i].name .. "' введено недоступное значение!")
                        reply = false                        
                    end
                end
            end
        end
    end
    return reply
end

vgui.Register("MerryUI.Submit", PANEL, "Button")