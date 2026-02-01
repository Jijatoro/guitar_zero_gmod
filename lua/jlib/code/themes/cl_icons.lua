--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
jlib.cfg.icons = {}
local i = jlib.cfg.icons
i["main"] = {
	["accept"] = Material("jlib/icons/accept.png", "noclamp smooth"),
	["arrow_down"] = Material("jlib/icons/arrow_down.png", "noclamp smooth"),
	["arrow_left"] = Material("jlib/icons/arrow_left.png", "noclamp smooth"),
	["arrow_right"] = Material("jlib/icons/arrow_right.png", "noclamp smooth"),
	["arrow_up"] = Material("jlib/icons/arrow_up.png", "noclamp smooth"),
	["close"] = Material("jlib/icons/close.png", "noclamp smooth"),
	["edit"] = Material("jlib/icons/edit.png", "noclamp smooth"),
	["minus"] = Material("jlib/icons/minus.png", "noclamp smooth"),
	["plus"] = Material("jlib/icons/plus.png", "noclamp smooth"),
	["search"] = Material("jlib/icons/search.png", "noclamp smooth"),		
	["music"] = Material("jlib/icons/music.png", "noclamp smooth"),
	["mute"] = Material("jlib/icons/mute.png", "noclamp smooth"),
	["ears"] = Material("jlib/icons/ears.png", "noclamp smooth"),	
	["unears"] = Material("jlib/icons/unears.png", "noclamp smooth"),
	["reward"] = Material("jlib/icons/reward.png", "noclamp smooth"),
	["setting"] = Material("jlib/icons/setting.png", "noclamp smooth"),
	["filter"] = Material("jlib/icons/filter.png", "noclamp smooth"),
	["stats"] = Material("jlib/icons/stats.png", "noclamp smooth"),
	["sound"] = Material("jlib/icons/sound.png", "noclamp smooth"),
	["load"] = Material("jlib/icons/load.png", "noclamp smooth"),
	["lock"] = Material("jlib/icons/lock.png", "noclamp smooth"),
	["unlock"] = Material("jlib/icons/unlock.png", "noclamp smooth"),		
	["exclamation"] = Material("jlib/icons/exclamation.png", "noclamp smooth"),
	["question"] = Material("jlib/icons/question.png", "noclamp smooth"),
	["lamp"] = Material("jlib/icons/lamp.png", "noclamp smooth"),
	["info"] = Material("jlib/icons/info.png", "noclamp smooth"),
	["avatar"] = Material("jlib/icons/avatar.png", "noclamp smooth"),
	["boy"] = Material("jlib/icons/boy.png", "noclamp smooth"),
	["girl"] = Material("jlib/icons/girl.png", "noclamp smooth"),
	["camera"] = Material("jlib/icons/camera.png", "noclamp smooth"),
	["home"] = Material("jlib/icons/home.png", "noclamp smooth"),
	["mail"] = Material("jlib/icons/mail.png", "noclamp smooth"),
	["circle"] = Material("jlib/icons/circle.png", "noclamp smooth"),
	["cube"] = Material("jlib/icons/cube.png", "noclamp smooth"),
	["star"] = Material("jlib/icons/star.png", "noclamp smooth"),	
	["triangle"] = Material("jlib/icons/triangle.png", "noclamp smooth"),	
	["trophy"] = Material("jlib/icons/trophy.png", "noclamp smooth"),
	["eye"] = Material("jlib/icons/eye.png", "noclamp smooth"),
	["heart"] = Material("jlib/icons/heart.png", "noclamp smooth"),
	["unknow"] = Material("jlib/icons/question.png", "noclamp smooth"),
	["menu"] = Material("jlib/icons/menu.png", "noclamp smooth")
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Functions :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
function jlib.EditIcon(arg)
	if not (jlib.cfg.icons[arg]) then return end
	jlib.cfg.icon = arg
end

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w- 