----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные  :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
if not (Guitar_Hero) then Guitar_Hero = {} Guitar_Hero.DataMusic = {} end
local name = "guitar_zero"

----------------------------------------------------------------------------------------------|>
--[+] Обычная загрузка (почти) :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
----------------------------------------------------------------------------------------------|>
local function LoadLua(cat, data)
	if not (cat) then return end
	local path = "/"
	if (data != "") then path = path .. data .. "/" end

	for _, v in pairs(cat) do
		if (string.StartWith(v, "cl")) then
			AddCSLuaFile(name .. path .. v)
			if (CLIENT) then 
				include(name .. path .. v)
			end
		end
		if (string.StartWith(v, "sv")) then
			if (SERVER) then 
				include(name .. path .. v)
			end
		end
		if (string.StartWith(v, "sh")) then
			AddCSLuaFile(name .. path .. v)
			include(name .. path .. v)
		end
	end
end

local function DownLoad(data)
	local path
	if (data != "") then path = "/" .. data .. "/*" else path = "/*" end

	local cat, folders = file.Find(name .. path, "LUA")
	LoadLua(cat, data)

	if (folders) and not (table.IsEmpty(folders)) then
		for _, v in ipairs(folders) do
			if (data != "") then
				DownLoad(data .. "/" .. v)
			else
				DownLoad(v)
			end
		end
	end 
end

-->
-- >>>\▁▁▁▁▁▁▁▁┃▙
-- >>>  HERE WE GO!  ┃███▶
-- >>>/▔▔▔▔▔▔▔▔┃▛
-->

DownLoad("")

-->            			 _M_								                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-           