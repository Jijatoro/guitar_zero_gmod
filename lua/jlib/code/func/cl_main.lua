--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib.vgui) then jlib.vgui = {} end

local meta = FindMetaTable("Panel")

local function icon()
    return jlib.cfg.icons[jlib.cfg.icon]  or {}
end

local function clr()
    return jlib.cfg.themes[jlib.cfg.theme]  or {}
end

local function lan()
    return jlib.cfg.lans[jlib.cfg.lan] or {}
end

local file_data = {
    ["lib-setting"] = {
        name = "lib-setting", folder = "jlib", path = "lib-setting.json", cfg = true
    }
}

local image_form = {
    ["png"] = true, ["jpg"] = true, ["jpeg"] = true, ["tga"] = true, ["vtf"] = true, ["bmp"] = true,
    ["gif"] = true, ["dds"] = true, ["vmt"] = true
}

jlib.vgui.CurrentMusic = nil

--------------------------------------------------------------------------------------------------------------|>
--[+] Basic :--:--:--:--:--:--:--:--:--:--:--:}>                                                              |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Creating a vgui
function jlib.vgui.Create(name, parent)
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
        new = vgui.Create("jlib." .. name .. path .. clr()["vgui"], parent)
    else
        new = vgui.Create("jlib." .. name .. path .. clr()["vgui"])
    end
    return new
end

--[*] SUI audio playback
function jlib.vgui.PlaySound(name, vol, ui)
    if not (jlib.cfg.sound_ui) and (ui) then return end
    local path = name
    local volume = jlib.cfg.sound_ui_volume
    local theme = jlib.cfg.themes[jlib.cfg.theme]["ui_sound"]
    if (vol) then volume = vol end 
    if (ui) then path = "jlib/ui/" .. theme .. "/" .. name .. ".mp3" end
    if (string.StartWith(path, "https")) then
        if (IsValid(jlib.vgui.CurrentMusic)) then jlib.vgui.CurrentMusic:Stop() end
        jlib.UrlSound(path, volume)
        return
    end
    sound.PlayFile("sound/" .. path, "noplay", function(station)
        if (IsValid(jlib.vgui.CurrentMusic)) and not (ui) then jlib.vgui.CurrentMusic:Stop() end
        if (IsValid(station)) then
            station:Play()
            station:SetVolume(volume)
            if not (ui) then jlib.vgui.CurrentMusic = station end
        else timer.Simple(0.3, function() jlib.vgui.PlaySound("errror", nil, true) end) end
    end)
end

--[*] Installing a font for a particular theme
function jlib.vgui.GetFont(data, key)
    local name = jlib.cfg.themes[jlib.cfg.theme]["font"]
    if not (table.KeyFromValue(jlib.cfg.fonts, name)) then name = "main" end
    return data[name][key]
end

--[*] Set tip
function meta:SetTip(text, pos_top)
    local tip = jlib.vgui.Create("tip")
    tip:SetText(text)
    tip:SetObject(self, pos_top)
end

--[*] Panel opening animation
function meta:SlideOpen()
    local size = self:GetTall()
    local name = self:GetName()
    self:SetTall(0)
    local tall = 0
    timer.Create("jlib.SlideOpen." .. tostring(name), 0.01, 0, function()
        if (tall >= size) then self:SetTall(size) timer.Remove("jlib.SlideOpen." .. tostring(name)) return end
        if not (IsValid(self)) then timer.Remove("jlib.SlideOpen." .. tostring(name)) return end
        self:SetTall(tall)
        tall = tall + 7
    end) 
end

--[*] Install a draggable clone
function meta:SetDrag(func)
    local drag = jlib.vgui.Create("drag")
    drag:SetData(self)
    drag:SetFunc(func)
end

--[*] Triggering the warning
function jlib.vgui.SetWarning(text, mat, parent)
    local warning
    if (parent) then
        warning = jlib.vgui.Create("warning", parent)
    else
        warning = jlib.vgui.Create("warning")
    end
    warning:SetText(text)
    if (mat) then warning:SetMat(mat) end
    warning:Center()
end

--[*] Smooth appearance animation for elements
function meta:Alpha()
    local alpha = 0
    self:SetAlpha(alpha)
    local name = tostring(self)
    timer.Create("jlib.Alpha." .. name, 0.01, 0, function()
        if (alpha >= 255) then alpha = 255 timer.Remove("jlib.Alpha." .. name) return end
        if not (IsValid(self)) then alpha = 255 timer.Remove("jlib.Alpha." .. name) return end
        self:SetAlpha(alpha)
        alpha = alpha + 5
    end)    
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Saving data :--:--:--:--:--:--:--:--:--:--:--:}>                                                        |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Saving config
function jlib.UpdateConfig(data)
    for k, v in pairs(data) do
        jlib.cfg[k] = v
    end
end

--[*] Getting saved data
function jlib.GetSaveData(name)
    if (file.Read(file_data[name].folder .. "/" .. file_data[name].path, "DATA") == nil) then
        return false
    else 
        local your_data = file.Read(file_data[name].folder .. "/" .. file_data[name].path, "DATA")
        return util.JSONToTable(your_data)
    end
end 

--[*] Saving data
function jlib.SaveData(name, data)
    local new_data = util.TableToJSON(data, true) 
    file.CreateDir(file_data[name].folder)
    file.Write(file_data[name].folder .. "/" .. file_data[name].path, new_data)
    if (file_data[name].cfg) then jlib.UpdateConfig(data) end
end 

--------------------------------------------------------------------------------------------------------------|>
--[+] HTTP Requests :--:--:--:--:--:--:--:--:--:--:--:}>                                                      |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.UrlImage(url, callback)
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

function jlib.UrlSound(url, vol, callback)
    sound.PlayURL(url, "noplay", function(station, errCode, errStr)
        if (IsValid(station)) then
            local volume = vol if not (volume) then volume = 1.0 end
            station:SetPos(LocalPlayer():GetPos())
            station:SetVolume(volume)
            station:Play()
            jlib.vgui.CurrentMusic = station
            if (callback) then callback(station:GetLength()) end
        else timer.Simple(0.3, function() jlib.vgui.PlaySound("errror", nil, true) end) end
    end)
end
--------------------------------------------------------------------------------------------------------------|>
--[+] Mask Stencil :--:--:--:--:--:--:--:--:--:--:--:}>                                                       |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.SetMask(parent, w, h, mask, image)
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
--[+] Technical :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Measuring the length of a Cyrillic string (.len)
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

--[*] Processing a Cyrillic string (.sub)
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

        if (len >= start_char) then local char = string.sub(str, i, i + char_length - 1) table.insert(data_word, char) end i = i + char_length len = len + 1
    end
    local new_data = table.concat(data_word, "") return new_data
end

--[*] Checking for bad characters
function jlib.blacksymbol(str)
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
        for _, allowed in ipairs(jlib.cfg.whitelist_symbols) do
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