--------------------------------------------------------------------------------------------------------------|>
--[+] Variables (CLIENT) :--:--:--:--:--:--:--:--:--:--:--:}>                                                 |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.vgui) then jlib.vgui = {} end

--[*] sound
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
jlib.vgui.current_fkey = false
jlib.vgui.current_felements = {}
jlib.vgui.font_type = {
	--[*] dark, light, blue
	["main"] = {
		[1] = {
			w = 640, h = 480,
			elements = {
				h1 = "s3-12", -- frame
				p1 = "s1-8", -- checkbox, key_txt, label, progress, rating
				p2 = "s1-6", -- slider, switch, selector_txt, tip
				p3 = "s1-6", -- table
				btn1 = "s5-6", -- button, submit, textblock, textentry
				btn2 = "s5-6", -- selector_btn
				btn2 = "s5-6" -- key_bind
			},
			border = {pnl = 2, btn = 2},
			round = {base = 4, weak = 2}
		},
		[2] = {
			w = 1024, h = 768,
			elements = {
				h1 = "s3-16", -- frame
				p1 = "s1-12", -- checkbox, key_txt, label, progress, rating
				p2 = "s1-10", -- slider, switch, selector_txt, tip
				p3 = "s1-10", -- table
				btn1 = "s5-12", -- button, submit, textblock, textentry
				btn2 = "s5-12", -- selector_btn
				btn2 = "s5-10" -- key_bind
			},
			border = {pnl = 4, btn = 2},
			round = {base = 8, weak = 4}
		},
		[3] = {
			w = 1280, h = 720,
			elements = {
				h1 = "s3-18", -- frame
				p1 = "s1-16", -- checkbox, key_txt, label, progress, rating
				p2 = "s1-12", -- slider, switch, selector_txt, tip
				p3 = "s1-12", -- table
				btn1 = "s5-14", -- button, submit, textblock, textentry
				btn2 = "s5-14", -- selector_btn
				btn2 = "s5-12" -- key_bind
			},
			border = {pnl = 4, btn = 2},
			round = {base = 8, weak = 4}
		},
		[4] = {
			w = 1600, h = 900,
			elements = {
				h1 = "s3-22", -- frame
				p1 = "s1-20", -- checkbox, key_txt, label, progress, rating
				p2 = "s1-16", -- slider, switch, selector_txt, tip
				p3 = "s1-16", -- table
				btn1 = "s5-18", -- button, submit, textblock, textentry
				btn2 = "s5-18", -- selector_btn
				btn2 = "s5-16" -- key_bind
			},
			border = {pnl = 6, btn = 4},
			round = {base = 8, weak = 4}
		},								
		[5] = {
			w = 1920, h = 1080,
			elements = {
				h1 = "s3-24", -- frame
				p1 = "s1-24", -- checkbox, key_txt, label, progress, rating
				p2 = "s1-20", -- slider, switch, selector_txt, tip
				p3 = "s1-16", -- table
				btn1 = "s5-20", -- button, submit, textblock, textentry
				btn2 = "s5-20", -- selector_btn
				btn2 = "s5-18" -- key_bind
			},
			border = {pnl = 6, btn = 4},
			round = {base = 8, weak = 8}
		},
	    [6] = {
	        w = 2560, h = 1440,
	        elements = {
	            h1 = "s3-32", -- frame
	            p1 = "s1-32", -- checkbox, key_txt, label, progress, rating
	            p2 = "s1-24", -- slider, switch, selector_txt, tip
	            p3 = "s1-22", -- table
	            btn1 = "s5-24", -- button, submit, textblock, textentry
	            btn2 = "s5-24", -- selector_btn
	            btn3 = "s5-22" -- key_bind
	        },
	        border = {pnl = 6, btn = 4},
	        round = {base = 8, weak = 8}
	    },
	    [7] = {
	        w = 3840, h = 2160,
	        elements = {
	            h1 = "s3-48", -- frame
	            p1 = "s1-48", -- checkbox, key_txt, label, progress, rating
	            p2 = "s1-32", -- slider, switch, selector_txt, tip
	            p3 = "s1-32", -- table
	            btn1 = "s5-32", -- button, submit, textblock, textentry
	            btn2 = "s5-32", -- selector_btn
	            btn3 = "s5-32" -- key_bind
	        },
	        border = {pnl = 8, btn = 6},
	        round = {base = 8, weak = 8}
	    },
	    [8] = {
	        w = 5120, h = 2880,
	        elements = {
	            h1 = "s3-64", -- frame
	            p1 = "s1-64", -- checkbox, key_txt, label, progress, rating
	            p2 = "s1-48", -- slider, switch, selector_txt, tip
	            p3 = "s1-48", -- table
	            btn1 = "s5-48", -- button, submit, textblock, textentry
	            btn2 = "s5-48", -- selector_btn
	            btn3 = "s5-48" -- key_bind
	        },
	        border = {pnl = 10, btn = 8},
	        round = {base = 8, weak = 8}
	    },		
	},
	--[*] anime
	["anime"] = {
		[1] = {
			w = 640, h = 480,
			elements = {
				h1 = "a5-16",
				p1 = "a3-8",
				p2 = "a3-5",
				p3 = "a3-5",
				btn1 = "s5-8",
				btn2 = "s5-8",
				btn2 = "s5-6"
			}
		},
		[2] = {
			w = 1024, h = 768,
			elements = {
				h1 = "a5-20",
				p1 = "a3-12",
				p2 = "a3-10",
				p3 = "a3-10",
				btn1 = "s5-10",
				btn2 = "s5-10",
				btn2 = "s5-8"
			}
		},
		[3] = {
			w = 1280, h = 720,
			elements = {
				h1 = "a5-22",
				p1 = "a3-16",
				p2 = "a3-12",
				p3 = "a3-12",
				btn1 = "s5-14",
				btn2 = "s5-14",
				btn2 = "s5-10"
			}
		},
		[4] = {
			w = 1600, h = 900,
			elements = {
				h1 = "a5-24",
				p1 = "a3-20",
				p2 = "a3-16",
				p3 = "a3-16",
				btn1 = "s5-18",
				btn2 = "s5-18",
				btn2 = "s5-14"
			}
		},
		[5] = {
			w = 1920, h = 1080,
			elements = {
				h1 = "a5-32",
				p1 = "a3-24",
				p2 = "a3-18",
				p3 = "a3-16",
				btn1 = "s5-20",
				btn2 = "s5-20",
				btn2 = "s5-18"
			}
		},
		[6] = {
			w = 2560, h = 1440,
			elements = {
				h1 = "a5-42",
				p1 = "a3-32",
				p2 = "a3-24",
				p3 = "a3-22",
				btn1 = "s5-28",
				btn2 = "s5-28",
				btn2 = "s5-24"
			}
		},
		[7] = {
			w = 3840, h = 2160,
			elements = {
				h1 = "a5-54",
				p1 = "a3-48",
				p2 = "a3-32",
				p3 = "a3-32",
				btn1 = "s5-42",
				btn2 = "s5-42",
				btn2 = "s5-32"
			}
		},
		[8] = {
			w = 5120, h = 2880,
			elements = {
				h1 = "a5-64",
				p1 = "a3-64",
				p2 = "a3-48",
				p3 = "a3-48",
				btn1 = "s5-54",
				btn2 = "s5-54",
				btn2 = "s5-48"
			}
		}
	},
	--[*] fantasy
	["fantasy"] = {
		[1] = {
			w = 640, h = 480,
			elements = {
				h1 = "b3-16",
				p1 = "f1-8",
				p2 = "f1-6",
				p3 = "f1-6",
				btn1 = "f3-8",
				btn2 = "s5-8",
				btn2 = "s5-6"
			}
		},
		[2] = {
			w = 1024, h = 768,
			elements = {
				h1 = "b3-20",
				p1 = "f1-12",
				p2 = "f1-10",
				p3 = "f1-10",
				btn1 = "f3-12",
				btn2 = "s5-12",
				btn2 = "s5-10"
			}
		},	
		[3] = {
			w = 1280, h = 720,
			elements = {
				h1 = "b3-22",
				p1 = "f1-16",
				p2 = "f1-12",
				p3 = "f1-12",
				btn1 = "f3-14",
				btn2 = "s5-14",
				btn2 = "s5-12"
			}
		},	
		[4] = {
			w = 1600, h = 900,
			elements = {
				h1 = "b3-24",
				p1 = "f1-20",
				p2 = "f1-16",
				p3 = "f1-16",
				btn1 = "f3-18",
				btn2 = "s5-18",
				btn2 = "s5-14"
			}
		},			
		[5] = {
			w = 1920, h = 1080,
			elements = {
				h1 = "b3-32",
				p1 = "f1-24",
				p2 = "f1-18",
				p3 = "f1-16",
				btn1 = "f3-20",
				btn2 = "s5-20",
				btn2 = "s5-18"
			}
		},
		[6] = {
			w = 2560, h = 1440,
			elements = {
				h1 = "b3-42",
				p1 = "f1-32",
				p2 = "f1-24",
				p3 = "f1-22",
				btn1 = "f3-28",
				btn2 = "s5-28",
				btn2 = "s5-24"
			}
		},
		[7] = {
			w = 3840, h = 2160,
			elements = {
				h1 = "b3-54",
				p1 = "f1-48",
				p2 = "f1-32",
				p3 = "f1-32",
				btn1 = "f3-42",
				btn2 = "s5-42",
				btn2 = "s5-32"
			}
		},
		[8] = {
			w = 5120, h = 2880,
			elements = {
				h1 = "b3-64",
				p1 = "f1-64",
				p2 = "f1-48",
				p3 = "f1-48",
				btn1 = "f3-54",
				btn2 = "s5-54",
				btn2 = "s5-48"
			}
		}
	},
	--[*] cyber
	["cyber"] = {
		[1] = {
			w = 640, h = 480,
			elements = {
				h1 = "c1-16",
				p1 = "c2-8",
				p2 = "c2-6",
				p3 = "c2-6",
				btn1 = "c4-8",
				btn2 = "s5-8",
				btn2 = "s5-6"
			}
		},
		[2] = {
			w = 1024, h = 768,
			elements = {
				h1 = "c1-20",
				p1 = "c2-12",
				p2 = "c2-10",
				p3 = "c2-10",
				btn1 = "c4-14",
				btn2 = "s5-14",
				btn2 = "s5-12"
			}
		},
		[3] = {
			w = 1280, h = 720,
			elements = {
				h1 = "c1-24",
				p1 = "c2-16",
				p2 = "c2-12",
				p3 = "c2-12",
				btn1 = "c4-16",
				btn2 = "s5-16",
				btn2 = "s5-14"
			}
		},
		[4] = {
			w = 1600, h = 900,
			elements = {
				h1 = "c1-24",
				p1 = "c2-20",
				p2 = "c2-16",
				p3 = "c2-16",
				btn1 = "c4-20",
				btn2 = "s5-20",
				btn2 = "s5-16"
			}
		},		
		[5] = {
			w = 1920, h = 1080,
			elements = {
				h1 = "c1-32",
				p1 = "c2-24",
				p2 = "c2-18",
				p3 = "c2-16",
				btn1 = "c4-20",
				btn2 = "s5-20",
				btn2 = "s5-18"
			}
		},
		[6] = {
			w = 2560, h = 1440,
			elements = {
				h1 = "c1-42",
				p1 = "c2-32",
				p2 = "c2-24",
				p3 = "c2-22",
				btn1 = "c4-28",
				btn2 = "s5-28",
				btn2 = "s5-24"
			}
		},
		[7] = {
			w = 3840, h = 2160,
			elements = {
				h1 = "c1-54",
				p1 = "c2-48",
				p2 = "c2-32",
				p3 = "c2-32",
				btn1 = "c4-42",
				btn2 = "s5-42",
				btn2 = "s5-32"
			}
		},
		[8] = {
			w = 5120, h = 2880,
			elements = {
				h1 = "c1-64",
				p1 = "c2-64",
				p2 = "c2-48",
				p3 = "c2-48",
				btn1 = "c4-54",
				btn2 = "s5-54",
				btn2 = "s5-48"
			}
		}
	},
	--[*] horror
	["horror"] = {
		[1] = {
			w = 640, h = 480,
			elements = {
				h1 = "h1-24",
				p1 = "h4-8",
				p2 = "h4-6",
				p3 = "h4-6",
				btn1 = "h5-8",
				btn2 = "s5-8",
				btn2 = "s5-6"
			}
		},
		[2] = {
			w = 1024, h = 768,
			elements = {
				h1 = "h1-24",
				p1 = "h4-12",
				p2 = "h4-10",
				p3 = "h4-10",
				btn1 = "h5-12",
				btn2 = "s5-12",
				btn2 = "s5-10"
			}
		},
		[3] = {
			w = 1280, h = 720,
			elements = {
				h1 = "h1-32",
				p1 = "h4-16",
				p2 = "h4-12",
				p3 = "h4-12",
				btn1 = "h5-14",
				btn2 = "s5-14",
				btn2 = "s5-12"
			}
		},
		[4] = {
			w = 1600, h = 900,
			elements = {
				h1 = "h1-32",
				p1 = "h4-20",
				p2 = "h4-16",
				p3 = "h4-16",
				btn1 = "h5-18",
				btn2 = "s5-18",
				btn2 = "s5-14"
			}
		},		
		[5] = {
			w = 1920, h = 1080,
			elements = {
				h1 = "h1-48",
				p1 = "h4-24",
				p2 = "h4-18",
				p3 = "h4-16",
				btn1 = "h5-20",
				btn2 = "s5-20",
				btn2 = "s5-18"
			}
		},
		[6] = {
			w = 2560, h = 1440,
			elements = {
				h1 = "h1-54",
				p1 = "h4-32",
				p2 = "h4-24",
				p3 = "h4-22",
				btn1 = "h5-28",
				btn2 = "s5-28",
				btn2 = "s5-24"
			}
		},
		[7] = {
			w = 3840, h = 2160,
			elements = {
				h1 = "h1-64",
				p1 = "h4-48",
				p2 = "h4-32",
				p3 = "h4-32",
				btn1 = "h5-42",
				btn2 = "s5-42",
				btn2 = "s5-32"
			}
		},
		[8] = {
			w = 5120, h = 2880,
			elements = {
				h1 = "h1-64",
				p1 = "h4-64",
				p2 = "h4-48",
				p3 = "h4-48",
				btn1 = "h5-54",
				btn2 = "s5-54",
				btn2 = "s5-48"
			}
		}
	},
	--[*] terminal
	["terminal"] = {
		[1] = {
			w = 640, h = 480,
			elements = {
				h1 = "t2-12",
				p1 = "s1-8",
				p2 = "s1-6",
				p3 = "s1-6",
				btn1 = "s5-8",
				btn2 = "s5-8",
				btn2 = "s5-6"
			}
		},
		[2] = {
			w = 1024, h = 768,
			elements = {
				h1 = "t2-16",
				p1 = "s1-14",
				p2 = "s1-12",
				p3 = "s1-12",
				btn1 = "s5-12",
				btn2 = "s5-12",
				btn2 = "s5-10"
			}
		},	
		[3] = {
			w = 1280, h = 720,
			elements = {
				h1 = "t2-16",
				p1 = "s1-16",
				p2 = "s1-12",
				p3 = "s1-12",
				btn1 = "s5-14",
				btn2 = "s5-14",
				btn2 = "s5-12"
			}
		},	
		[4] = {
			w = 1600, h = 900,
			elements = {
				h1 = "t2-20",
				p1 = "s1-20",
				p2 = "s1-16",
				p3 = "s1-16",
				btn1 = "s5-18",
				btn2 = "s5-18",
				btn2 = "s5-16"
			}
		},			
		[5] = {
			w = 1920, h = 1080,
			elements = {
				h1 = "t2-24",
				p1 = "s1-24",
				p2 = "s1-18",
				p3 = "s1-16",
				btn1 = "s5-20",
				btn2 = "s5-20",
				btn2 = "s5-18"
			}
		},
		[6] = {
			w = 2560, h = 1440,
			elements = {
				h1 = "t2-32",
				p1 = "s1-32",
				p2 = "s1-24",
				p3 = "s1-22",
				btn1 = "s5-28",
				btn2 = "s5-28",
				btn2 = "s5-24"
			}
		},
		[7] = {
			w = 3840, h = 2160,
			elements = {
				h1 = "t2-48",
				p1 = "s1-48",
				p2 = "s1-32",
				p3 = "s1-32",
				btn1 = "s5-42",
				btn2 = "s5-42",
				btn2 = "s5-32"
			}
		},
		[8] = {
			w = 5120, h = 2880,
			elements = {
				h1 = "t2-64",
				p1 = "s1-64",
				p2 = "s1-48",
				p3 = "s1-48",
				btn1 = "s5-54",
				btn2 = "s5-54",
				btn2 = "s5-48"
			}
		}
	}
}