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
--[+] Emergence (primary function) :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Init()
    local jv, lan, clr = jv(), lan(), clr()
    self.truename = "submit"
    self:SetSize(210, 80) 
    self:SetText(lan["ready"])
    jv.SetFont(self, "btn1", true)
    self:SetTextColor(clr["t_btn"])
    self.status = false
    self.data = {}
    self.error_text = ""
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetIsToggle(true)
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
    local jv = jv()
    local data = {...}
    jv["Scale"](self, data)
end

function PANEL:Margin(...)
    local jv = jv()
    local data = {...}
    if (data) and not (table.IsEmpty(data)) then self.dockmargin = data end
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
--[+] Status control (whether the button is pressed or not) :--:--:--:--:--:--:--:--:--:--:--:}>              |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetStatus(val)
    self.status = val
end

function PANEL:GetStatus()
    return self.status
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We will notify you if there is an error (if any) :--:--:--:--:--:--:--:--:--:--:--:}>                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetError(val)
    self.error_text = val
    chat.AddText(Color(17, 128, 106), "[jLib] ", Color(228, 240, 240), tostring(val))
end

function PANEL:GetError()
    return self.error_text
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We assign data for verification with this button :--:--:--:--:--:--:--:--:--:--:--:}>                   |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:SetData(...)
    self.data = {...}
end

function PANEL:GetData()
    return self.data
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Data verification :--:--:--:--:--:--:--:--:--:--:--:}>                                                  |>
--------------------------------------------------------------------------------------------------------------|>
function PANEL:Check()
    local lan = lan()
    local reply = true
    for _, v in ipairs(self:GetData()) do
        --[*] selector check
        if (string.find(tostring(v), "selector")) then
            if (v:GetValue() == lan["not-selected"]) then
                self:SetError(l["oops-dont-selected"])
                reply = false
            end
        end

        --[*] textentry check
        if (string.find(tostring(v), "textentry")) then
            local limit = v:GetMinMax()

            if (v:GetValue() == "") then
                self:SetError(lan["oops"] .. ", " .. lan["in"] .. " '" .. v:GetName() .. "' " .. lan["oops-nothing-specified"] .. "!")
                reply = false
            elseif (not jlib.blacksymbol(v:GetValue())) then
                self:SetError(lan["oops"] .. ", " .. lan["in"] .. " '" .. v:GetName() .. "' " .. lan["oops-forbidden-symbol"] .. "!")
                reply = false
            end

            if (limit) then
                if (jlib.len(v:GetValue())<limit.min) then
                    self:SetError(lan["oops"] .. ", " .. lan["in"] .. " '" .. v:GetName() .. "' " .. lan["oops-should-be-minimum"] .. " " .. limit.min .. " " .. lan["oops-symbol"] .. "!")
                    reply = false
                elseif (jlib.len(v:GetValue())>limit.max) then
                    self:SetError(lan["oops"] .. ", " .. lan["in"] .. " '" .. v:GetName() .. "' " .. lan["oops-shouldnt-be-more"] .. " " .. limit.max .. " " .. lan["oops-symbols"] .. "!")
                    reply = false
                end
            end
        end
    end
    return reply
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Registering a UI element :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
vgui.Register("jlib.submit-main", PANEL, "jlib.button-main")

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 