--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| :--:--:--:--:--:--:--:--:--:--:--:}>                                                      |>
--------------------------------------------------------------------------------------------------------------|>
local defalt = {extended = true, weight = 500, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, additive = false, outline = false, shadow = false}
local size_list = {10, 12, 14, 16, 18, 20, 24, 32, 48, 54, 64}
local fonts_list = {
	["simple"] = {
		"Poiret One", "Playfair Display SC", "Rubik Mono One", "Amatic SC", "TikTok Sans 36pt Light"
	},	
	["base"] = {
		"Great Vibes", "Lobster", "Caveat", "Bad Script" 
	},
	["anime"] = {
		"Stick", "LXGW WenKai TC", "LXGW WenKai TC Light", "Hachi Maru Pop", "Reggae One"
	},	
	["fantasy"] = {
		"Cormorant Unicase", "Marck Script", "Comic Relief"
	},
	["horror"] = {
		"Rubik Wet Paint", "Ruslan Display", "Underdog", "Rubik Distressed", "Rubik Burned", "Kablammo Zoink"
	},
	["terminal"] = {
		"Tiny5", "Press Start 2P", "DotGothic16", "Handjet"
	},
	["cyber"] = {
		"Stalinist One", "Tektur", "Rubik Broken Fax", "Rubik Glitch", "Train One"
	}
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local function FontLoad(arg)
	if not (fonts_list[arg]) then return end
	local num = 1
	for _, name in ipairs(fonts_list[arg]) do
		for i = 1, #size_list do
			local data = table.Copy(defalt) 
			data.font = name 
			data.size = size_list[i]
			surface.CreateFont(string.sub(arg, 1, 1) .. tostring(num) .. "-" .. tostring(size_list[i]), data)
			local text = string.sub(arg, 1, 1) .. tostring(num) .. "-" .. tostring(size_list[i])
		end
		num = num + 1
	end
end

local function LoadFonts(data)
	for _, t in pairs(data) do
		FontLoad(t)
	end
end

--[*] Font Loading
LoadFonts(jlib.cfg.fonts)

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w-