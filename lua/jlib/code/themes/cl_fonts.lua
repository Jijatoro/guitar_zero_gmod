--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| :--:--:--:--:--:--:--:--:--:--:--:}>                                                      |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.vgui) then jlib.vgui = {} end
local function j() return jlib end
local function jv() return j()["vgui"] end
local fonts_defalt = {extended = true, antialias = true, weight = 500}
local fonts_list = {
    --[*] simple
    ["s"] = {
        "Poiret One", "Playfair Display SC", "Rubik Mono One", "Amatic SC", "TikTok Sans 36pt Light"
    },
    --[*] base  
    ["b"] = {
        "Great Vibes", "Lobster", "Caveat", "Bad Script" 
    },
    --[*] anime
    ["a"] = {
        "Stick", "LXGW WenKai TC", "LXGW WenKai TC Light", "Hachi Maru Pop", "Reggae One"
    },
    --[*] fantasy  
    ["f"] = {
        "Cormorant Unicase", "Marck Script", "Comic Relief"
    },
    --[*] horror
    ["h"] = {
        "Rubik Wet Paint", "Ruslan Display", "Underdog", "Rubik Distressed", "Rubik Burned", "Kablammo Zoink"
    },
    --[*] terminal
    ["t"] = {
        "Tiny5", "Press Start 2P", "DotGothic16", "Handjet"
    },
    --[*] cyber
    ["c"] = {
        "Stalinist One", "Tektur", "Rubik Broken Fax", "Rubik Glitch", "Train One"
    }
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.vgui.NewFont(name, cat, id, size)
	local jv = jv()
	local data = fonts_defalt
	data["font"] = fonts_list[cat][id]
	data["size"] = size
	surface.CreateFont("jlib." .. name, data)
	jv["all_font"][name] = true
end

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w-