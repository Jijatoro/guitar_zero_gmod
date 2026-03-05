--------------------------------------------------------------------------------------------------------------|>
--[+] Variables (CLIENT) :--:--:--:--:--:--:--:--:--:--:--:}>                                                 |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.vgui) then jlib.vgui = {} end

--[*] sound
jlib.vgui.CurrentMusicName = ""
jlib.vgui.CurrentMusic = ""

--[*] scroll
jlib.vgui.current_scrolls = {}

--[*] selector
jlib.vgui.selector = false

--[*] drag
jlib.vgui.drag_ready = false
jlib.vgui.drag_image = false
jlib.vgui.drag_size = {}

--[*] adapting to the screen size
jlib.vgui.all_font = {}
jlib.vgui.elements_font = {}
jlib.vgui.maxborder = {[1] = {key = "pnl", max = 6}, [2] = {key = "btn", max = 4}}
jlib.vgui.maxround = {[1] = {key = "base", max = 8}, [2] = {key = "weak", max = 4}}
jlib.vgui.border = {pnl = 6, btn = 4}
jlib.vgui.round = {base = 8, weak = 4}
jlib.vgui.font_scale = {
	--[*] dark, light, blue
	["main"] = {
		h1 = {cat = "s", id = 3, size = 0.025}, -- frame
		p1 = {cat = "s", id = 1, size = 0.017}, -- checkbox, key_txt, label, progress, rating
		p2 = {cat = "s", id = 1, size = 0.017}, -- slider, switch, selector_txt, tip
		p3 = {cat = "s", id = 1, size = 0.017}, -- table
		btn1 = {cat = "s", id = 5, size = 0.02}, -- button, submit
		btn2 = {cat = "s", id = 5, size = 0.02}, -- selector_btn
		btn2 = {cat = "s", id = 5, size = 0.02}, -- key_bind
		textentry = {cat = "s", id = 5, size = 0.017} -- textblock, textentry
	},
	--[*] anime
	["anime"] = {
		h1 = {cat = "a", id = 5, size = 0.025}, -- frame
		p1 = {cat = "a", id = 3, size = 0.017}, -- checkbox, key_txt, label, progress, rating
		p2 = {cat = "a", id = 3, size = 0.017}, -- slider, switch, selector_txt, tip
		p3 = {cat = "a", id = 3, size = 0.017}, -- table
		btn1 = {cat = "a", id = 5, size = 0.02}, -- button, submit, textblock, textentry
		btn2 = {cat = "a", id = 5, size = 0.02}, -- selector_btn
		btn2 = {cat = "a", id = 5, size = 0.02}, -- key_bind
		textentry = {cat = "a", id = 5, size = 0.017} -- textblock, textentry
	},
	--[*] fantasy
	["fantasy"] = {
		h1 = {cat = "b", id = 3, size = 0.035}, -- frame
		p1 = {cat = "f", id = 1, size = 0.018}, -- checkbox, key_txt, label, progress, rating
		p2 = {cat = "f", id = 1, size = 0.018}, -- slider, switch, selector_txt, tip
		p3 = {cat = "f", id = 1, size = 0.018}, -- table
		btn1 = {cat = "f", id = 3, size = 0.021}, -- button, submit, textblock, textentry
		btn2 = {cat = "s", id = 5, size = 0.021}, -- selector_btn
		btn2 = {cat = "s", id = 5, size = 0.021}, -- key_bind
		textentry = {cat = "f", id = 3, size = 0.017} -- textblock, textentry
	},
	--[*] cyber
	["cyber"] = {
		h1 = {cat = "c", id = 1, size = 0.025}, -- frame
		p1 = {cat = "c", id = 2, size = 0.017}, -- checkbox, key_txt, label, progress, rating
		p2 = {cat = "c", id = 2, size = 0.017}, -- slider, switch, selector_txt, tip
		p3 = {cat = "c", id = 2, size = 0.017}, -- table
		btn1 = {cat = "c", id = 4, size = 0.02}, -- button, submit, textblock, textentry
		btn2 = {cat = "s", id = 5, size = 0.02}, -- selector_btn
		btn2 = {cat = "s", id = 5, size = 0.02}, -- key_bind
		textentry = {cat = "c", id = 4, size = 0.017} -- textblock, textentry
	},
	--[*] horror
	["horror"] = {
		h1 = {cat = "h", id = 1, size = 0.025}, -- frame
		p1 = {cat = "h", id = 4, size = 0.017}, -- checkbox, key_txt, label, progress, rating
		p2 = {cat = "h", id = 4, size = 0.017}, -- slider, switch, selector_txt, tip
		p3 = {cat = "h", id = 4, size = 0.017}, -- table
		btn1 = {cat = "h", id = 5, size = 0.02}, -- button, submit, textblock, textentry
		btn2 = {cat = "s", id = 5, size = 0.02}, -- selector_btn
		btn2 = {cat = "s", id = 5, size = 0.02}, -- key_bind
		textentry = {cat = "h", id = 5, size = 0.017} -- textblock, textentry
	},
	--[*] terminal
	["terminal"] = {
		h1 = {cat = "t", id = 2, size = 0.025}, -- frame
		p1 = {cat = "s", id = 1, size = 0.017}, -- checkbox, key_txt, label, progress, rating
		p2 = {cat = "s", id = 1, size = 0.017}, -- slider, switch, selector_txt, tip
		p3 = {cat = "s", id = 1, size = 0.017}, -- table
		btn1 = {cat = "s", id = 5, size = 0.02}, -- button, submit, textblock, textentry
		btn2 = {cat = "s", id = 5, size = 0.02}, -- selector_btn
		btn2 = {cat = "s", id = 5, size = 0.02}, -- key_bind
		textentry = {cat = "s", id = 5, size = 0.017} -- textblock, textentry
	}
}