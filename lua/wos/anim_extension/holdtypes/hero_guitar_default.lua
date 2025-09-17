--[[-------------------------------------------------------------------
	Blade Symphony Judgement - Heavy Hold Type:
		Uses the Heavy variation of the Judgement animations from Blade Symphony to create a variety Hold Type
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
----------------------------- Copyright 2017, David "King David" Wiltos ]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
-- Copyright 2017, David "King David" Wiltos ]]--


local DATA = {}

DATA.Name = "character holdtype"
DATA.HoldType = "hero_guitar_default"
DATA.BaseHoldType = "normal"
DATA.Translations = {}

DATA.Translations[ ACT_MP_STAND_IDLE ]	= "hero_guitar.stand"
-- DATA.Translations[ ACT_MP_WALK ] = ""
-- DATA.Translations[ ACT_MP_RUN ] = ""
-- DATA.Translations[ ACT_MP_CROUCH_IDLE ] = ""
-- DATA.Translations[ ACT_MP_CROUCHWALK ] = ""
-- DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = "" 
-- DATA.Translations[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = "" 
-- DATA.Translations[ ACT_MP_RELOAD_STAND ] = ""
-- DATA.Translations[ ACT_MP_RELOAD_CROUCH ] = ""
-- DATA.Translations[ ACT_MP_JUMP ] = ""
-- DATA.Translations[ ACT_MP_SWIM ] = ""
-- DATA.Translations[ ACT_LAND ] = ""

wOS.AnimExtension:RegisterHoldtype( DATA )