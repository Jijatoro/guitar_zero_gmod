--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
local defalt = {extended = true, weight = 500, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, additive = false, outline = false, shadow = false}
local size_list = {10, 12, 14, 16, 18, 20, 24, 32, 48, 54, 64}
local fonts_list = {
	["anime"] = {
		"asia-normal", "bonzai", "dist-inking", "farang", "faux-hanamin", "hp001",
		"keetano_katakana", "keetano-gaijin", "sangha", "yomogi-regular"
	},
	["base"] = {
		"alistair-signature", "bodega-script", "dikoe-disco", "leo-hand", "old-b", "trial-extalight",
		"trial-light", "trial-medium", "trial-regular", "trial-script", "trial-semibold"
	},
	["fantasy"] = {
		"antikvarika", "carmen", "chocogirl", "coquettec", "dama-bubey", "eterna-breaks",
		"islandof-misfit-toys", "kereru", "kereru-bold", "kot-leopold", "la-bamba-std", "metamorphous",
		"modestina", "nk", "sabrina-star", "tmvinograd-filled", "tmvinograd-filled-oblique", "tmvinograd-oblique",
		"tmvinograd-regular", "twinkle-star", "wonderland", "wonderland-stars"
	},
	["horror"] = {
		"blackcraft", "catacombs", "deadline-1", "deadline-mac-1", "harry-p-v1", "harry-p-v2",
		"harry-p-v3", "harry-p-v4", "lost", "mouse-memoirs",
	},
	["terminal"] = {
		"a_3pix", "alagard", "dxtt-regular", "faithful", "fixedsys", "gohu",
		"harreegh-popped", "harry-p-pix", "harry-p-pix-e", "harry-p-pix-r", "keleti-regular", "minecraft-pix",
		"mix-serif-condense", "offbit-101", "offbit-101-bold", "offbit-bold", "offbit-dot", "offbit-regular",
		"pixel", "pixelizer-bold", "rune-scape", "sonic-italic", "teletactile"
	},
	["simple"] = {
		"cuyabra-regular", "fatal-bold", "kyiv-type-sans", "manege-light", "podarok", "rennie"
	},
	["cyber"] = {
		"damione-regular", "digiface-regular", "lpmpuffpuff-bold", "lpmpuffpuff-regular",
		"lpmpuffpuff-vf", "marske", "neuropol-medium", "pobeda-bold", "pobeda-regular"
	}
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Functions |~| Функции :--:--:--:--:--:--:--:--:--:--:--:}>                                              |>
--------------------------------------------------------------------------------------------------------------|>
local function FontLoad(arg)
	if not (fonts_list[arg]) then return end
	local num = 1
	for _, name in pairs(fonts_list[arg]) do
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

--[*] Font Loading |~| Загрузка шрифтов
LoadFonts(jlib.cfg.fonts)

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w-