--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
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

local sound_form = {
    ["ogg"] = true, ["mp3"] = true, ["wav"] = true
}

local sound_types = {
    ["audio/ogg"] = "ogg", ["application/ogg"] = "ogg", ["audio/mpeg"] = "mp3", ["audio/mp3"] = "mp3",
    ["audio/wav"] = "wav", ["audio/x-wav"] = "wav", ["audio/webm"] = "ogg"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Basic |~| Основное :--:--:--:--:--:--:--:--:--:--:--:}>                                                 |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Creating a vgui |~| Создание vgui
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

--[*] SUI audio playback |~| Проигрывание UI звука
function jlib.vgui.PlaySound(name, vol, ui)
    if not (jlib.cfg.sound_ui) and (ui) then return end
    local path = name
    local volume = jlib.cfg.sound_ui_volume
    local theme = jlib.cfg.themes[jlib.cfg.theme]["ui_sound"]
    if (vol) then volume = vol end 
    if (ui) then path = "jlib/ui/" .. theme .. "/" .. name .. ".mp3" end 
    LocalPlayer():EmitSound(path, 75, 100, volume, CHAN_AUTO)
end

--[*] Installing a font for a particular theme |~| Установка шрифта под ту или иную тему
function jlib.vgui.GetFont(data, key)
    local name = jlib.cfg.themes[jlib.cfg.theme]["font"]
    if not (table.KeyFromValue(jlib.cfg.fonts, name)) then name = "main" end
    return data[name][key]
end

--[*] Set tip |~| Установить подсказку
function meta:SetTip(text, pos_top)
    local tip = jlib.vgui.Create("tip")
    tip:SetText(text)
    tip:SetObject(self, pos_top)
end

--[*] Install a draggable clone |~| Установить перетаскиваемого клона
function meta:SetDrag(func)
    local drag = jlib.vgui.Create("drag")
    drag:SetData(self)
    drag:SetFunc(func)
end

--[*] Triggering the warning |~| Запуск предупреждения
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

--[*] Smooth appearance animation for elements |~| Анимация плавного появления для элементов
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
--[+] Saving data |~| Сохранение данных :--:--:--:--:--:--:--:--:--:--:--:}>                                  |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Saving config |~| Сохранение конфига
function jlib.UpdateConfig(data)
    for k, v in pairs(data) do
        jlib.cfg[k] = v
    end
end

--[*] Getting saved data |~| Получение сохранённых данных
function jlib.GetSaveData(name)
    if (file.Read(file_data[name].folder .. "/" .. file_data[name].path, "DATA") == nil) then
        return false
    else 
        local your_data = file.Read(file_data[name].folder .. "/" .. file_data[name].path, "DATA")
        return util.JSONToTable(your_data)
    end
end 

--[*] Saving data |~| Сохранение данных
function jlib.SaveData(name, data)
    local new_data = util.TableToJSON(data, true) 
    file.CreateDir(file_data[name].folder)
    file.Write(file_data[name].folder .. "/" .. file_data[name].path, new_data)
    if (file_data[name].cfg) then jlib.UpdateConfig(data) end
end 

--------------------------------------------------------------------------------------------------------------|>
--[+] HTTP Requests |~| HTTP Запросы :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
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

function jlib.UrlSound(url, callback)
    local fileName = "jlib_cache/" .. util.SHA256(url)
    for k, _ in pairs(sound_form) do
        if (file.Exists(fileName .. "." .. k, "DATA")) then if (callback) then callback("data/" .. fileName .. "." .. k) end return end
    end

    http.Fetch(url,
        --[*] Success
        function(body, len, headers, code)
            if (code != 200) then return end
            if not (headers["content-type"]) then return end
            if not (sound_types[headers["content-type"]]) then return end
            local format = sound_types[headers["content-type"]]

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
--[+] Mask Stencil |~| Наложение маски (Трафарет) :--:--:--:--:--:--:--:--:--:--:--:}>                        |>
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
--[+] Technical |~| Техническое :--:--:--:--:--:--:--:--:--:--:--:}>                                          |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Measuring the length of a Cyrillic string (.len) |~| Измерение длины строки с кириллицей (.len) 
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

--[*] Processing a Cyrillic string (.sub) |~| Обработка строки с кириллицей (.sub) 
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

--[*] Checking for bad characters |~| Проверка на плохие !
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