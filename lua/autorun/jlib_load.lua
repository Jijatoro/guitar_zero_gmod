--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.all_vgui) then jlib.all_vgui = {} end
local name = "jlib"

--------------------------------------------------------------------------------------------------------------|>
--[+] Functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
local function LoadLua(cat, data)
	if not (cat) then return end
	local path = "/"
	if (data != "") then path = path .. data .. "/" end

	for _, v in pairs(cat) do
		if (string.StartWith(v, "cl")) or (string.find(path, "vgui")) then
			AddCSLuaFile(name .. path .. v)
			if (CLIENT) then 
				include(name .. path .. v)
			end
			if (string.find(path, "vgui")) then
				table.insert(jlib.all_vgui, string.Replace(v, ".lua", ""))
			end
		elseif (string.StartWith(v, "sv")) then
			if (SERVER) then 
				include(name .. path .. v)
			end
		elseif (string.StartWith(v, "sh")) then
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

--[*] To download the library (don't touch!) |>
DownLoad("")
MsgC(Color(59, 163, 212), "[jLib] ", Color(228, 240, 240), "Files loaded.\n")

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w-        