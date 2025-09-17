----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
Merry = {}
Merry.Theme = "Merry"
Merry.CanTheme = true
Merry.Themes = {
	["Merry"] = {
		-- *Color icon
		["color_icon"] = Color(107, 97, 71),
		["color_icon_active"] = Color(80, 70, 50),
		-- *Frame
		["head"] = Color(163, 147, 98), ["body"] = Color(163, 147, 98),
		["background"] = Color(190, 171, 114), ["line"] = Color(104, 97, 74),
		-- *Panel
		["p_body"] = Color(170, 154, 105), ["p_line"] = Color(104, 97, 74),
		-- *Button
		["btn"] = Color(213, 194, 138), ["btn_line"] = Color(104, 97, 74),
		["btn_hover"] = Color(235, 215, 155), ["btn_line_hover"] = Color(120, 110, 85),
		-- *Title
		["title_head"] = Color(98, 90, 63), ["title_h1"] = Color(88, 81, 57), 
		["title_p1"] = Color(98, 90, 63), ["title_btn"] = Color(98, 90, 63),
		["title_btn_hover"] = Color(136, 125, 89),
		-- *Slider
		["slider"] = Color(213, 194, 138), ["slider_border"] = Color(104, 97, 74),
		-- *Switch
		["switch_rd"] = Color(120, 36, 46), ["switch_gr"] = Color(65, 120, 32),
		-- *Checkbox // Progress
		["checkbox"] = Color(220, 211, 163), ["progress"] = Color(65, 120, 32)		
	},
	["Dark"] = {
		-- *Color icon
		["color_icon"] = Color(80, 80, 90),
		["color_icon_active"] = Color(120, 120, 140),
		-- *Frame
		["head"] = Color(40, 40, 45), ["body"] = Color(45, 45, 50),
		["background"] = Color(30, 30, 35), ["line"] = Color(70, 70, 80),
		-- *Panel
		["p_body"] = Color(50, 50, 55), ["p_line"] = Color(70, 70, 80),
		-- *Button
		["btn"] = Color(65, 65, 75), ["btn_line"] = Color(80, 80, 90),
		["btn_hover"] = Color(85, 85, 95), ["btn_line_hover"] = Color(110, 110, 120),
		-- *Title
		["title_head"] = Color(170, 170, 180), ["title_h1"] = Color(190, 190, 200), 
		["title_p1"] = Color(150, 150, 160), ["title_btn"] = Color(200, 200, 210),
		["title_btn_hover"] = Color(220, 220, 230),
		-- *Slider
		["slider"] = Color(80, 80, 90), ["slider_border"] = Color(100, 100, 110),
		-- *Switch
		["switch_rd"] = Color(180, 60, 70), ["switch_gr"] = Color(70, 180, 80),
		-- *Checkbox // Progress
		["checkbox"] = Color(90, 90, 100), ["progress"] = Color(70, 180, 80)
	},
	["Light"] = {
		-- *Color icon
		["color_icon"] = Color(171, 171, 171),
		["color_icon_active"] = Color(100, 100, 100),
		-- *Frame
		["head"] = Color(230, 230, 235), ["body"] = Color(240, 240, 245),
		["background"] = Color(250, 250, 252), ["line"] = Color(180, 180, 190),
		-- *Panel
		["p_body"] = Color(245, 245, 248), ["p_line"] = Color(180, 180, 190),
		-- *Button
		["btn"] = Color(220, 220, 225), ["btn_line"] = Color(160, 160, 170),
		["btn_hover"] = Color(200, 200, 205), ["btn_line_hover"] = Color(130, 130, 140),
		-- *Title
		["title_head"] = Color(50, 50, 60), ["title_h1"] = Color(30, 30, 40), 
		["title_p1"] = Color(70, 70, 80), ["title_btn"] = Color(40, 40, 50),
		["title_btn_hover"] = Color(20, 20, 30),
		-- *Slider
		["slider"] = Color(200, 200, 210), ["slider_border"] = Color(150, 150, 160),
		-- *Switch
		["switch_rd"] = Color(220, 80, 90), ["switch_gr"] = Color(80, 200, 90),
		-- *Checkbox // Progress
		["checkbox"] = Color(230, 230, 235), ["progress"] = Color(80, 200, 90)
	},
	["Blue"] = {
		-- *Color icon
		["color_icon"] = Color(70, 90, 120),
		["color_icon_active"] = Color(50, 70, 100),
		-- *Frame
		["head"] = Color(50, 70, 100), ["body"] = Color(60, 80, 110),
		["background"] = Color(40, 60, 90), ["line"] = Color(80, 100, 130),
		-- *Panel
		["p_body"] = Color(70, 90, 120), ["p_line"] = Color(80, 100, 130),
		-- *Button
		["btn"] = Color(90, 110, 140), ["btn_line"] = Color(100, 120, 150),
		["btn_hover"] = Color(110, 130, 160), ["btn_line_hover"] = Color(130, 150, 180),
		-- *Title
		["title_head"] = Color(167, 189, 231),
		["title_h1"] = Color(183, 199, 230),
		["title_p1"] = Color(200, 210, 230),
		["title_btn"] = Color(200, 210, 230),
		["title_btn_hover"] = Color(174,191,224),
		-- *Slider
		["slider"] = Color(110, 130, 160), ["slider_border"] = Color(130, 150, 180),
		-- *Switch
		["switch_rd"] = Color(200, 80, 90), ["switch_gr"] = Color(80, 200, 100),
		-- *Checkbox // Progress
		["checkbox"] = Color(130, 150, 180), ["progress"] = Color(80, 200, 100)
	}
}

Merry.Mat = {
	["accept"] = {mat = Material("merryui/accept.png", "noclamp smooth"),  num1 = 8, num2 = 15},
	["arrow_down"] = {mat = Material("merryui/arrow_down.png", "noclamp smooth"),  num1 = 8, num2 = 15},
	["arrow_left"] = {mat = Material("merryui/arrow_left.png", "noclamp smooth"), num1 = 8, num2 = 15}, 
	["arrow_right"] = {mat = Material("merryui/arrow_right.png", "noclamp smooth"), num1 = 8, num2 = 15}, 
	["arrow_up"] = {mat = Material("merryui/arrow_up.png", "noclamp smooth"), num1 = 8, num2 = 15}, 
	["boy"] = {mat = Material("merryui/boy.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["camer"] = {mat = Material("merryui/camer.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["circle"] = {mat = Material("merryui/circle.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["close"] = {mat = Material("merryui/close.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cube"] = {mat = Material("merryui/cube.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["edit"] = {mat = Material("merryui/edit.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["exclamation"] = {mat = Material("merryui/exclamation.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["girl"] = {mat = Material("merryui/girl.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["minus"] = {mat = Material("merryui/minus.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["plus"] = {mat = Material("merryui/plus.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["question"] = {mat = Material("merryui/question.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["reward"] = {mat = Material("merryui/reward.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["search"] = {mat = Material("merryui/search.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["setting"] = {mat = Material("merryui/setting.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["sound"] = {mat = Material("merryui/sound.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["star"] = {mat = Material("merryui/star.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["stats"] = {mat = Material("merryui/stats.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["triangle"] = {mat = Material("merryui/triangle.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["trophy"] = {mat = Material("merryui/trophy.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["heart"] = {mat = Material("merryui/heart.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["lamp"] = {mat = Material("merryui/lamp.png", "noclamp smooth"), num1 = 8, num2 = 15},
	-- *Panel
	["bg"] = Material("merryui/background/bg.png", "noclamp smooth"),
	-- *Gallery
	["img_1"] = Material("merryui/img/1.png", "noclamp smooth"),
	["img_2"] = Material("merryui/img/2.png", "noclamp smooth"),
	-- *Profile
	["like"] = {mat = Material("merryprofile/like.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["dislike"] = {mat = Material("merryprofile/dislike.png", "noclamp smooth"), num1 = 8, num2 = 15},
	-- *Cooking
	["cook_bread"] = {mat = Material("merrycooking/bread.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_cheese"] = {mat = Material("merrycooking/cheese.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_chicken"] = {mat = Material("merrycooking/chicken.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_chocolate"] = {mat = Material("merrycooking/chocolate.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_cucumbers"] = {mat = Material("merrycooking/cucumbers.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_cutlet"] = {mat = Material("merrycooking/cutlet.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_dough"] = {mat = Material("merrycooking/dough.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_flatbread"] = {mat = Material("merrycooking/flatbread.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_ketchup"] = {mat = Material("merrycooking/ketchup.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_meat"] = {mat = Material("merrycooking/meat.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_milk"] = {mat = Material("merrycooking/milk.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_sausage"] = {mat = Material("merrycooking/sausage.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_straw"] = {mat = Material("merrycooking/straw.png", "noclamp smooth"), num1 = 8, num2 = 15},
	["cook_turkey_meat"] = {mat = Material("merrycooking/turkey_meat.png", "noclamp smooth"), num1 = 8, num2 = 15}
}

MerryBlackSymbol_Name = {
	["!"]=true, ["?"]=true, ["."]=true, [":"]=true, [","]=true, ["-"]=true, 
	[";"]=true, ["("]=true, [")"]=true, ["="]=true,
	["`"]=true, ["~"]=true, ["@"]=true, ["#"]=true, ["$"]=true, ["%"]=true, 
	["^"]=true, ["&"]=true, ["*"]=true, ["_"]=true, ["+"]=true, ["["]=true,
	["]"]=true, ["{"]=true, ["}"]=true, ["'"]=true, ["|"]=true, ["/"]=true, 
	[">"]=true, ["<"]=true
}

MerryBlackSymbol_Text = {
	["`"]=true, ["~"]=true, ["@"]=true, ["#"]=true, ["$"]=true, ["%"]=true, 
	["^"]=true, ["&"]=true, ["*"]=true, ["_"]=true, ["+"]=true, ["["]=true,
	["]"]=true, ["{"]=true, ["}"]=true, ["'"]=true, ["|"]=true, ["/"]=true, 
	[">"]=true, ["<"]=true
}