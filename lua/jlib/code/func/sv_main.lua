--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local meta = FindMetaTable("Player")
local image_form = {
    ["png"] = true, ["jpg"] = true, ["jpeg"] = true, ["tga"] = true, ["vtf"] = true, ["bmp"] = true,
    ["gif"] = true, ["dds"] = true, ["vmt"] = true
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Gets an image by url                                                                                    |>
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

        if (len >= start_char) then local char = string.sub(str, i, i + char_length - 1) table.insert(data_word, char) end i = i + char_length len = len + 1
    end
    local new_data = table.concat(data_word, "") return new_data
end

--------------------------------------------------------------------------------------------------------------|>
--[+] Checking for bad characters :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
--------------------------------------------------------------------------------------------------------------|>
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

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 