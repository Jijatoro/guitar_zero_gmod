----------------------------------------------------------------------------------------------|>
--[+] Настройки конфигурации :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
----------------------------------------------------------------------------------------------|>
Guitar_Hero.Config = {}
----------------------------------------------------------------------------------------------|>
Guitar_Hero.Config["Hero"] = 0
--[[
	【EN】 
	0 ➱ The "hero" mode only works on the client.
	1 ➱ The "hero" mode works on the client and transmits the results to the server with little protection (useful if we want to reward players for playing the guitar).
	【RU】 
	0 ➱ режим "hero" работает только на клиенте.
	1 ➱ режим "hero" работает на клиенте и передаёт с небольшой защитой результаты серверу (полезно, если хотим награждать игроков за эту на гитаре).
	【DE】
	0 ➱ der "Hero" -Modus funktioniert nur auf dem Client.
	1 ➱ der "Hero" -Modus arbeitet auf dem Client und überträgt die Ergebnisse mit wenig Schutz an den Server (nützlich, wenn wir Spieler dafür auf der Gitarre belohnen wollen).
--]]
----------------------------------------------------------------------------------------------|>
Guitar_Hero.Config["Black_List"] = 0
--[[
	【EN】 
	0 ➱ Disables the black/white list feature.
	1 ➱ Includes a blacklist. Now the specified music will either not work, or it will, but with conditions.
	2 ➱ The whitelist is enabled. Now only the specified music will work.
	【RU】 
	0 ➱ Отключает функцию чёрных/белых списков.
	1 ➱ Включает чёрный список. Теперь указанная музыка либо не будет работать, либо будет, но с условиями.
	2 ➱ Включается белый список. Теперь только указанная музыка будет работать.
	【DE】
	0 ➱ Deaktiviert die Schwarz-/Weißlistenfunktion.
	1 ➱ Enthält eine schwarze Liste. Jetzt funktioniert die angegebene Musik entweder nicht oder wird es sein, aber mit den Bedingungen.
	2 ➱ Die Whitelist wird aktiviert. Jetzt funktioniert nur die angegebene Musik.
--]]
----------------------------------------------------------------------------------------------|>
Guitar_Hero.Config["List_Music"] = {}
--[[
	【EN】 
	  ➱ An example of filling is shown in the bottom list.
	  ➱ The time of filling is indicated in the lower example.
	【RU】 
	  ➱ Данный список имеет значение только при включённом чёрном или белом списке.
	  ➱ Пример заполнения указан в нижнем списке.
	【DE】
	  ➱ Diese Liste ist nur relevant, wenn die schwarze oder weiße Liste aktiviert ist.
	  ➱ Ein Beispiel für die Füllung ist in der unteren Liste aufgeführt.

	--[*] #1
	Guitar_Hero.Config["List_Music"]["name_music"] = {
		CanUse = function(ply)
			return false
		end,
		Need = function(ply)
			return "5 lvl."
		end
	}
	
	--[*] #2 DarkRP
	local jobs = {["Mayor"] = true, ["Cook"] = true}
	Guitar_Hero.Config["List_Music"]["name_music"] = {
		CanUse = function(ply)
			if (jobs[team.GetName(ply:Team())]) then
				return true
			end
			return false
		end,
		Need = function(ply)
			return "Job: Mayor or Cook."
		end
	}	  
--]]
----------------------------------------------------------------------------------------------|>

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   
