----------------------------------------------------------------------------------------------|>
--[+] Загрузка файлов :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
local lib_file = file.Find("merrylib/*", "LUA")
for k, v in pairs(lib_file) do 
	if (string.StartWith(v, "cl")) then
		AddCSLuaFile("merrylib/".. v)

		if (CLIENT) then 
			include("merrylib/".. v)
		end
	end
	if (string.StartWith(v, "sv")) then

		if (SERVER) then 
			include("merrylib/".. v)
		end
	end
	if (string.StartWith(v, "sh")) then
		AddCSLuaFile("merrylib/".. v)
		include("merrylib/".. v)
	end
end

local lib_file_vgui = file.Find("merrylib/vgui/*", "LUA")
for k, v in pairs(lib_file_vgui) do
	AddCSLuaFile("merrylib/vgui/".. v)

	if (CLIENT) then 
		include("merrylib/vgui/".. v)
	end
end