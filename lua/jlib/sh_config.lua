--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.cfg) then jlib.cfg = {} end

--------------------------------------------------------------------------------------------------------------|>
--[+] JLib UI Library - Asset Credits & Rights :--:--:--:--:--:--:--:--:--:--:--:}>                           |>
--------------------------------------------------------------------------------------------------------------|>
jlib.cfg.asset_credits_rights = [[
=== ASSETS CREATED BY JLIB (ORIGINAL WORK) ===
• All icon graphics, UI sprites, and visual elements
• Library code, configuration files, and implementation
• Documentation and integration systems
• Full rights reserved for these components

=== EXTERNAL SOUND ASSETS (LICENSED/USED WITH PERMISSION) ===

[1] PRIMARY UI SOUNDS (ATTRIBUTION REQUIRED)
• Author: JDSherbert
• Packs: "Ultimate UI SFX Pack", "Pixel UI SFX Pack", "Wooden UI SFX Pack"
• Source: https://jdsherbert.itch.io/
• License: Commercial use with attribution required
• Attribution: Provided via this documentation

[2] CORE UI SOUND SYSTEM (ATTRIBUTION APPRECIATED)
• Author: Atelier Magicae / Ririsaurus (Riri Hinasaki)
• Pack: "Fantasy UI Sound Effects"
• Source: https://ateliermagicae.itch.io/fantasy-ui-sound-effects
• License: Free for commercial/non-commercial use
• Restriction: Do not redistribute separately
• Attribution: Provided as courtesy
• Usage: Primary UI feedback across all interface themes

[3] HORROR THEME SOUNDS (ATTRIBUTION REQUIRED - CC BY 4.0)
• Author: bedsideseraphim
• Pack: "Survival Horror UI SFX"
• Source: https://bedsideseraphim.itch.io/survival-horror-ui-sfx
• License: Creative Commons Attribution 4.0 International
• Requirements: Must credit author, link to source, indicate changes
• Changes made: "No modifications"
• Attribution: Fully provided below

=== EXTERNAL FONTS (SIL OPEN FONT LICENSE) ===
• Source: Google Fonts (https://fonts.google.com/)
• License: SIL Open Font License (OFL)
• Full license texts: available in the source code repository of each font (links below)

• Fonts used and their authors:
  - "Tiny5" The Tiny5 Project Authors (https://github.com/Gissio/font_tiny5)
  - "Rubik Wet Paint" The Rubik Filtered Project Authors (https://github.com/NaN-xyz/Rubik-Filtered)
  - "Ruslan Display" Oleg Snarsky, Denis Masharov, Vladimir Rabdu, with Reserved Font Name 'Ruslan', 'Ruslan Display'.
  - "Kablammo" The Kablammo Project Authors (https://github.com/Vectro-Type-Foundry/kablammo)
  - "Underdog" Sergey Steblina (sergey@steblina.com), Jovanny Lemonad (lemonad@jovanny.ru)
  - "Rubik Distressed" The Rubik Filtered Project Authors (https://github.com/NaN-xyz/Rubik-Filtered)
  - "Rubik Burned" The Rubik Filtered Project Authors (https://https://github.com/NaN-xyz/Rubik-Filtered)
  - "Stick" The Stick Project Authors (https://github.com/fontworks-fonts/Stick)
  - "Amatic SC" The Amatic SC Project Authors (https://github.com/googlefonts/AmaticSC)
  - "Press Start 2P" The Press Start 2P Project Authors (cody@zone38.net), with Reserved Font Name "Press Start 2P".
  - "DotGothic16" The DotGothic16 Project Authors (https://github.com/fontworks-fonts/DotGothic16)
  - "Handjet" The Handjet Project Authors (https://github.com/rosettatype/Handjet/)
  - "Stalinist One" Alexey Maslov, Jovanny Lemonad (lemonad@jovanny.ru), with Reserved Font Name 'Stalinist'
  - "Tektur" The Tektur Project Authors (https://www.github.com/hyvyys/Tektur)
  - "Rubik Broken Fax" The Rubik Filtered Project Authors (https://https://github.com/NaN-xyz/Rubik-Filtered)
  - "Rubik Glitch" The Rubik Filtered Project Authors (https://https://github.com/NaN-xyz/Rubik-Filtered)
  - "Train One" The Train Project Authors (https://github.com/fontworks-fonts/Train)
  - "TikTok Sans" TikTok Inc. (https://github.com/tiktok/TikTokSans)
  - "Poiret One" Denis Masharov (denis.masharov@gmail.com)
  - "Playfair Display SC" The Playfair Display Project Authors (https://github.com/clauseggers/Playfair-Display)
  - "Rubik Mono One" Hubert and Fischer, Philipp Hubert (philipp@hubertfischer.com), Sebastian Fischer (sebastian@hubertfischer.com)
  - "Cormorant Unicase" the Cormorant Project Authors (github.com/CatharsisFonts/Cormorant)
  - "Marck Script" Denis Masharov <denis.masharov@gmail.com> & Marck Fogel,
  - "Comic Relief" The Comic Relief Project Authors (https://github.com/loudifier/Comic-Relief)
  - "Great Vibes" The Great Vibes Pro Project Authors (https://github.com/googlefonts/great-vibes)
  - "Lobster" The Lobster Project Authors (https://github.com/impallari/The-Lobster-Font)
  - "LXGW WenKai TC" The LXGW WenKai Project Authors (https://github.com/lxgw/LxgwWenkaiTC)
  - "Hachi Maru Pop" The Hachi Maru Pop Project Authors (https://github.com/noriokanisawa/HachiMaruPop)
  - "Reggae One" The Reggae Project Authors (https://github.com/fontworks-fonts/Reggae)
  - "Caveat" The Caveat Project Authors (https://github.com/googlefonts/caveat)
  - "Bad Script" The Bad Script Project Authors (https://github.com/alexeiva/badscript)

• Usage: All UI typography and interface text rendering.
• Compliance: Fonts are used unmodified. License files preserved.

=== RIGHTS SUMMARY ===
• VISUAL ASSETS (icons, graphics): © JLib - All rights reserved
• CODE & IMPLEMENTATION: © JLib - All rights reserved
• SOUND EFFECTS: Property of respective authors, used under license
• FONTS: Licensed under SIL Open Font License, authors credited above

=== LICENSE COMPLIANCE ===
All external assets used in strict accordance with their licenses.
Attribution requirements fully satisfied.
No assets redistributed outside of this library package.
]]

--------------------------------------------------------------------------------------------------------------|>
--[+] Configuration :--:--:--:--:--:--:--:--:--:--:--:}>                                                      |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Language
jlib.cfg.lan = "en"

--[*] Turn on the sound for UI elements?
jlib.cfg.sound_ui = true

--[*] The standard volume for UI sounds
jlib.cfg.sound_ui_volume = 0.3

--[*] Standard music volume
jlib.cfg.music_volume = 0.4

--[*] Icon Type 
jlib.cfg.icon = "main"

--[*] Theme |> "dark", "light", "blue", "anime", "fantasy", "cyber", "horror", "terminal"
jlib.cfg.theme = "blue"

--[*] Allowed themes
jlib.cfg.theme_ChangeList = {"dark", "light", "blue", "anime", "fantasy", "cyber", "horror", "terminal"} 

--[*] Fonts (do not remove "simple"!)
jlib.cfg.fonts = {"simple", "base", "anime", "fantasy", "horror", "cyber", "terminal"}

--[*] A white sheet of symbols (nicknames, names, and so on)
jlib.cfg.whitelist_symbols = {
    --[+] en
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
    --[+] ru 
    "а","б","в","г","д","е","ё","ж","з","и","й","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","ъ","ы","ь","э","ю","я",
    "А","Б","В","Г","Д","Е","Ё","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я",
    --[+] numbers
    "0","1","2","3","4","5","6","7","8","9",
    --[+] other
    " "
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Workpieces :--:--:--:--:--:--:--:--:--:--:--:}>                                                         |>
--------------------------------------------------------------------------------------------------------------|>
jlib.cfg.clientsetting = {
    ["lan"] = jlib.cfg.lan, ["theme"] = jlib.cfg.theme,
    ["sound_ui"] = jlib.cfg.sound_ui, ["sound_ui_volume"] = jlib.cfg.sound_ui_volume,
    ["music_volume"] = jlib.cfg.music_volume
}

list.Set(
    "DesktopWindows", "jlib",
    {
        title = "jlib",
        icon = "jlib/img/logo-jlib.png",
        init = function(i, w)
            jlib.SettingsMenu()
        end
    })

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w-  