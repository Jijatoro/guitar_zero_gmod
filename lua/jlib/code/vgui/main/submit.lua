--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local PANEL = {}
local data_font = {
    ["main"] = {
        btn = "s5-24"
    },
    ["anime"] = {
        btn = "a1-24"
    },
    ["fantasy"] = {
        btn = "f3-24"
    },
    ["cyber"] = {
        btn = "c4-24"
    },    
    ["horror"] = {
        btn = "h4-24"
    },
    ["terminal"] = {
        btn = "t3-24"
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
--[+] Main functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                     |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    self:SetSize(210, 80) 
    self:SetText(lan()["ready"])
    self:SetFont(jlib.vgui.GetFont(data_font, "btn"))
    self:SetTextColor(clr()["t_btn"])
    self.status = false
    self.data = {}
    self.error_text = ""
    self:SetTall(22)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)
end

function PANEL:SetStatus(val)
    self.status = val
end

function PANEL:GetStatus()
    return self.status
end

function PANEL:SetError(val)
    self.error_text = val
    local warning = jlib.vgui.Create("warning", self:GetParent())
    warning:SetText(val)
    warning:Center()
    warning:Dock(NODOCK)
end

function PANEL:GetError()
    return self.error_text
end

function PANEL:SetData(...)
    self.data = {...}
end

function PANEL:GetData()
    return self.data
end

function PANEL:Check()
    local reply = true
    for _, v in pairs(self:GetData()) do
        if (string.find(tostring(v), "selector")) then
            if (v:GetValue() == lan()["not-selected"]) then
                self:SetError(lan()["oops-dont-selected"])
                reply = false
            end
        end

        if (string.find(tostring(v), "textentry")) then
            local limit = v:GetMinMax()

            if (v:GetValue() == "") then
                self:SetError(lan()["oops"] .. ", " .. lan()["in"] .. " '" .. v:GetName() .. "' " .. lan()["oops-nothing-specified"] .. "!")
                reply = false
            elseif (not jlib.blacksymbol(v:GetValue())) then
                self:SetError(lan()["oops"] .. ", " .. lan()["in"] .. " '" .. v:GetName() .. "' " .. lan()["oops-forbidden-symbol"] .. "!")
                reply = false
            end

            if (limit) then
                if (jlib.len(v:GetValue())<limit.min) then
                    self:SetError(lan()["oops"] .. ", " .. lan()["in"] .. " '" .. v:GetName() .. "' " .. lan()["oops-should-be-minimum"] .. " " .. limit.min .. " " .. lan()["oops-symbol"] .. "!")
                    reply = false
                elseif (jlib.len(v:GetValue())>limit.max) then
                    self:SetError(lan()["oops"] .. ", " .. lan()["in"] .. " '" .. v:GetName() .. "' " .. lan()["oops-shouldnt-be-more"] .. " " .. limit.max .. " " .. lan()["oops-symbols"] .. "!")
                    reply = false
                end
            end
        end
    end
    return reply
end

vgui.Register("jlib.submit-main", PANEL, "jlib.button-main")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 