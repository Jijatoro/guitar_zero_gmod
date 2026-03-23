--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.vgui) then jlib.vgui = {} end
local meta = FindMetaTable("Panel")
local base_h = 1080
local function j() return jlib end
local function c() return j()["cfg"] end
local function jv() return j()["vgui"] end
local function clr() return c()["themes"][c()["theme"]]  or {} end
local function icon() return c()["icons"][c()["icon"]]  or {} end
local image_form = {
    ["png"] = true, ["jpg"] = true, ["jpeg"] = true, ["tga"] = true, ["vtf"] = true, ["bmp"] = true,
    ["gif"] = true, ["dds"] = true, ["vmt"] = true
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Creating a vgui :--:--:--:--:--:--:--:--:--:--:--:}>                                                    |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.Create(name, parent, main_parent)
    local jv = jv()
    if not (name) or (name == "") then return end
    local check = false
    if (jlib.all_vgui) then
        for _, v in ipairs(jlib.all_vgui) do
            if (v == name) then check = true break end 
        end
        if not (check) then
            for _, v in ipairs(jlib.all_vgui) do
                if (string.StartWith(v, name)) then check = true name = v break end 
            end
        end
    else return end
    if not (check) then return end
    
    local new
    local path = "-"
    if (parent) then
        if (parent:GetName() == "scroll") and (name != "dscroll") then
            new = vgui.Create("jlib." .. name .. path .. clr()["vgui"], parent.body_scroll)
            new.inscroll = true
        else
            new = vgui.Create("jlib." .. name .. path .. clr()["vgui"], parent)
        end
    else
        new = vgui.Create("jlib." .. name .. path .. clr()["vgui"])
    end

    if (main_parent) then new.main_parent = main_parent end
    return new
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We adapt the sizes of ordinary elements :--:--:--:--:--:--:--:--:--:--:--:}>                            |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.PlaySound(name, vol, ui)
    local jv = jv()
    if not (jlib.cfg.sound_ui) and (ui) then return end
    local path = name
    local volume = jlib.cfg.sound_ui_volume
    local theme = jlib.cfg.themes[jlib.cfg.theme]["ui_sound"]
    if (vol) then volume = vol end 
    if (ui) then path = "jlib/ui/" .. theme .. "/" .. name .. ".mp3" end
    if (string.StartWith(path, "https")) then jv.UrlSound(path, volume) return end
    
    sound.PlayFile("sound/" .. path, "noplay", function(station)
        if (IsValid(jv["CurrentMusic"])) and not (ui) then jv["CurrentMusic"]:Stop() end
        if (IsValid(station)) then
            station:Play()
            station:SetVolume(volume)
            if not (ui) then jv.CurrentMusicName = name jv.CurrentMusic = station end
        else timer.Simple(0.1, function() jv.PlaySound("errror", nil, true) end) end
    end)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We are trying to use sound through the url :--:--:--:--:--:--:--:--:--:--:--:}>                         |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.UrlSound(url, vol, callback)
    local jv = jv()
    sound.PlayURL(url, "noplay", function(station, errCode, errStr)
        if (IsValid(jv["CurrentMusic"])) then jv.CurrentMusic:Stop() end
        if (IsValid(station)) then
            local volume = vol if not (volume) then volume = 1.0 end
            station:SetPos(LocalPlayer():GetPos())
            station:SetVolume(volume)
            station:Play()
            jv.CurrentMusicName = url
            jv.CurrentMusic = station
            if (callback) then callback(station:GetLength()) end
        else timer.Simple(0.1, function() jv.PlaySound("errror", nil, true) end) end
    end)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Size adjustment :--:--:--:--:--:--:--:--:--:--:--:}>                                                    |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.Scale(pnl, data)
    local arg = data
    local parent = pnl:GetParent()
    if not (parent) then return end
    if (pnl.inscroll) then parent = parent:GetParent():GetParent() end

    if (arg[3]) then pnl.evenly = arg[3] end
    local my_x, my_y = arg[1], arg[2]
    if (arg[1] == 0) then my_x = 1 end
    if (arg[2] == 0) then my_y = 1 end
    pnl.percent_x, pnl.percent_y = my_x, my_y
end

function jlib.vgui.Margin(pnl, data)
    local arg = pnl.dockmargin
    if not (arg) then arg = data pnl.dockmargin = arg end
    local parent = pnl:GetParent()
    if not (parent) then return end
    if (pnl.inscroll) then parent = parent:GetParent():GetParent() end
    local w, h = parent:GetSize()

    --[*] margin adaptation
    local left, top, right, bottom = (arg[1] or 0)*w, (arg[2] or 0)*h or 0, (arg[3] or 0)*w or 0, (arg[4] or 0)*h or 0
    pnl:Dock(pnl:GetDock())
    pnl:DockMargin(math.floor(left), math.floor(top), math.floor(right), math.floor(bottom))

    --[*] size adjustment
    local cur_x, cur_y = pnl:GetSize()
    local percent_x, percent_y = pnl.percent_x, pnl.percent_y
    if not (percent_x) or not (percent_y) then return end
    local ready_x, ready_y = percent_x*w, percent_y*h 
    local eve = pnl.evenly  
    if (eve) then if (eve == 1) then ready_y = ready_x else ready_x = ready_y end end
    pnl:SetSize(math.floor(ready_x), math.floor(ready_y))    
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Installing a font for a particular theme :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.SetFont(element, cat, new)
    if not (IsValid(element)) then return end
    element.fcat = cat
    local c, jv = c(), jv()
    local w, h = ScrW(), ScrH()
    local name_theme, all = c["theme"], jv["all_font"]
    if not (jv["font_scale"][name_theme]) then name_theme = "main" end
    local data = jv["font_scale"][name_theme][cat]

    --[*] ultra wide screen
    if ((w/h) > 2) then h = ScrW()/3 end
    local size = math.floor(h * data["size"])
    local name = data["cat"] .. data["id"] .. "-" .. size
    --[*] create a new font
    if not (all[name]) then
        jv["NewFont"](name, data["cat"], data["id"], size)
    end

    element:SetFont("jlib." .. name)
    if (new) then table.insert(jv["elements_font"], element) end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the current size for the border :--:--:--:--:--:--:--:--:--:--:--:}>                            |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.GetBorder(name)
    local jv = jv()
    local border = jv["border"]
    if not (border[name]) then return 6 else return border[name] end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting the current size for the round :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.GetRound(name)
    local jv = jv()
    local round = jv["round"]
    if not (round[name]) then return 8 else return round[name] end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Selecting the appropriate font key :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.AdjustFont(w, h)
    local jv = jv()
    local elements_font = jv["elements_font"]
    local scale = h/base_h
    
    --[*] choosing a more suitable font size
    local max = #elements_font
    for k, v in ipairs(elements_font) do
        if not (IsValid(v)) then continue end
        jv["SetFont"](v, v.fcat)
    end

    --[*] we edit the border
    for _, v in ipairs(jv["maxborder"]) do
        local sum = math.floor(v["max"]*scale)
        local limit = math.Clamp(sum, 2, v["max"])
        local result = limit
        if ((result % 2) != 0) then result = result + 1 end
        if (result > v["max"]) then result = v["max"] end
        jv["border"][v["key"]] = result
    end

    --[*] we edit the round
    for _, v in ipairs(jv["maxround"]) do
        local sum = math.floor(v["max"]*scale)
        local limit = math.Clamp(sum, 2, v["max"])
        local result = limit
        if ((result % 2) != 0) then result = result + 1 end
        if (result > v["max"]) then result = v["max"] end
        jv["round"][v["key"]] = result
    end   

    --[*] we adjusting the size of the scroll sliders
    local all_scrolls = jv["current_scrolls"]
    local border = jv["GetBorder"]("pnl")
    if (#all_scrolls > 0) then
        for _, v in ipairs(all_scrolls) do
            if (IsValid(v)) then
                v:SetWide(border)
                v:DockMargin(0, 0, border/2, 0)
            end
        end
    end

    --[*] close the existing selector
    if (IsValid(jv["selector"])) then 
        local par = jv["selector"].trueparent
        if (IsValid(par)) then par:SetStatus(false) end
        jv["selector"]:Remove() 
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Set tip :--:--:--:--:--:--:--:--:--:--:--:}>                                                            |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.SetTip(element, text, pos_top)
    local tip = jlib.vgui.Create("tip")
    tip:SetText(text)
    tip:SetObject(element, pos_top)
    local remove = element.OnRemove
    element.OnRemove = function()
        remove()
        tip:Remove()
    end
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Panel opening animation :--:--:--:--:--:--:--:--:--:--:--:}>                                            |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.SlideOpen(element)
    local size = element:GetTall()
    local name = element:GetName()
    element:SetTall(0)
    local tall = 0
    timer.Create("jLib.SlideOpen." .. tostring(name), 0.01, 0, function()
        if (tall >= size) then element:SetTall(size) timer.Remove("jLib.SlideOpen." .. tostring(name)) return end
        if not (IsValid(element)) then timer.Remove("jLib.SlideOpen." .. tostring(name)) return end
        element:SetTall(tall)
        tall = tall + 7
    end) 
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Install a draggable clone :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.SetDrag(element, func)
    local drag = jlib.vgui.Create("drag")
    drag:SetData(element)
    drag:SetFunc(func)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Smooth appearance animation for elements :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.Alpha(element, speed)
    local alpha = 0
    local tick = speed
    if not (tick) then tick = 0.01 end
    element:SetAlpha(alpha)
    local name = tostring(element)
    timer.Create("jlib.Alpha." .. name, 0.01, 0, function()
        if (alpha >= 255) then alpha = 255 timer.Remove("jlib.Alpha." .. name) return end
        if not (IsValid(element)) then alpha = 255 timer.Remove("jlib.Alpha." .. name) return end
        element:SetAlpha(alpha)
        alpha = alpha + 5
    end)    
end

--------------------------------------------------------------------------------------------------------------|>
--[+] We are trying to make material from the image url :--:--:--:--:--:--:--:--:--:--:--:}>                  |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.UrlImage(url, callback)
    local fileName = "jlib_cache/" .. util.SHA256(url)
    for k, _ in pairs(image_form) do
        if (file.Exists(fileName .. "." .. k, "DATA")) then if (callback) then callback("data/" .. fileName .. "." .. k) end return end
    end
    http.Fetch(url,
        --[*] Success
        function(body, len, headers, code)
            if (code != 200) then return end
            if not (headers["content-type"]) then return end
            if not (string.StartWith(headers["content-type"], "image")) then return end
            local path = string.Split(headers["content-type"], "/")
            format = path[#path] if not (format) then return end

            file.CreateDir("jlib_cache")
            file.Write(fileName .. "." .. format, body)
            
            if (callback) then
                callback("data/" .. fileName .. "." .. format)
            end
        end,
        --[*] Fail
        function(err)
        end
    )
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Mask Stencil :--:--:--:--:--:--:--:--:--:--:--:}>                                                       |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.SetMask(parent, w, h, mask, image)
    render.SetStencilEnable(true)
    render.ClearStencil()
    render.SetStencilTestMask(255)
    render.SetStencilWriteMask(255)
    render.SetStencilPassOperation(STENCILOPERATION_KEEP)
    render.SetStencilZFailOperation( STENCILOPERATION_KEEP)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilReferenceValue(1)
    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)

    mask(parent, w, h)

    render.SetStencilFailOperation(STENCILOPERATION_KEEP)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

    image(parent, w, h)

    render.SetStencilEnable(false)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Saving config :--:--:--:--:--:--:--:--:--:--:--:}>                                                      |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.UpdateConfig(data)
    for k, v in pairs(data) do
        jlib.cfg[k] = v
    end
    hook.Run("jlib.UpdateSetting", data)
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Getting saved data :--:--:--:--:--:--:--:--:--:--:--:}>                                                 |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.GetSaveData()
    local path = "jlib/lib-setting.json"
    local my_file = file.Read("jlib/lib-setting.json", "DATA")
    if (my_file) then return util.JSONToTable(my_file) end
end 

--------------------------------------------------------------------------------------------------------------|>
--[+] Saving data :--:--:--:--:--:--:--:--:--:--:--:}>                                                        |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.SaveData(data)
    local new_data = util.TableToJSON(data, true) 
    file.CreateDir("jlib")
    file.Write("jlib/lib-setting.json", new_data)
    jlib.UpdateConfig(data)
end 

--------------------------------------------------------------------------------------------------------------|>
--[+] Measuring the length of a Cyrillic string (.len) :--:--:--:--:--:--:--:--:--:--:--:}>                   |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.len(str)
    local len = 0
    local i = 1
        while i <= #str do
            local byte = string.byte(str, i)
            if byte <= 127 then
                i = i + 1
            elseif byte <= 223 then
                i = i + 2
            elseif byte <= 239 then
                i = i + 3
            else
                i = i + 4
            end
                len = len + 1
        end
    return len
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Processing a Cyrillic string (.sub) :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.sub(str, start_char, end_char)
    local data_word = {} local len = 1 local i = 1
    while i <= #str do
        if not (string.byte(str, i)) then break end
        local byte = string.byte(str, i)
        local char_length = 1
        if (len > end_char) then break end
        
        if byte <= 127 then
            char_length = 1
        elseif byte <= 223 then
            char_length = 2
        elseif byte <= 239 then
            char_length = 3
        else
            char_length = 4
        end

        if (len >= start_char) then 
            local char = string.sub(str, i, i + char_length - 1) 
            table.insert(data_word, char) 
        end 
        i = i + char_length len = len + 1
    end
    local new_data = table.concat(data_word, "") return new_data
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Checking for bad characters :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.blacksymbol(str)
    local c = c()
    if not str or str == "" then return true end
    local i = 1
    while i <= #str do
        local byte = string.byte(str, i)
        local char, char_len
        
        if byte <= 127 then
            char_len = 1
            char = string.sub(str, i, i)
        elseif byte <= 223 then
            char_len = 2
            char = string.sub(str, i, i + 1)
        elseif byte <= 239 then
            char_len = 3
            char = string.sub(str, i, i + 2)
        else
            char_len = 4
            char = string.sub(str, i, i + 3)
        end
        
        local found = false
        for _, allowed in ipairs(c["whitelist_symbols"]) do
            if char == allowed then
                found = true
                break
            end
        end
        
        if not found then
            return false
        end
        
        i = i + char_len
    end
    
    return true
end

-->                                              _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 