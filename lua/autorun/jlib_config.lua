--------------------------------------------------------------------------------------------------------------|>
--[+] Variables |~| Переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.cfg) then jlib.cfg = {} end

--------------------------------------------------------------------------------------------------------------|>
--[+] Configuration |~| Конфигурация :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
--------------------------------------------------------------------------------------------------------------|>
--[*] Language |~| Язык |> 
jlib.cfg.lan = "ru"

--[*] Languages |~| Языки |> "en", "ru", de <..>.
jlib.cfg.lan_all = {"ru", "en", "de"}

--[*] Turn on the sound for UI elements? |~| Включить звук для UI элементов?
jlib.cfg.sound_ui = true

--[*] The standard volume for UI sounds. |~| Стандартная громкость для UI звуков.
jlib.cfg.sound_ui_volume = 0.3

--[*] Icon Type |~| Тип иконок |> "main", <..>.
jlib.cfg.icon = "main"

--[*] Theme |~| Тема |> "dark", "light", "blue", "anime", "fantasy", "cyber", "horror", "terminal".
jlib.cfg.theme = "blue"

--[*] Allowed themes |~| Разрешённые темы
jlib.cfg.theme_ChangeList = {"dark", "light", "blue", "anime", "fantasy", "cyber", "horror", "terminal"} 

--[*] Fonts |~| Шрифты |> "simple", "base", "anime", "fantasy", "horror", "cyber", "terminal".
jlib.cfg.fonts = {"simple", "base", "anime", "fantasy", "horror", "cyber", "terminal"}

--[*] A white sheet of symbols (nicknames, names, and so on) |~| Белый лист с символами (ники, названия и т.д.)
jlib.cfg.whitelist_symbols = {
    --[+] en
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
    --[+] ru 
    "а","б","в","г","д","е","ё","ж","з","и","й","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","ъ","ы","ь","э","ю","я",
    "А","Б","В","Г","Д","Е","Ё","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я",
    --[+] numbers |~| цифры
    "0","1","2","3","4","5","6","7","8","9",
    --[+] other |~| другое
    " "
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Workpieces |~| Заготовки :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
--------------------------------------------------------------------------------------------------------------|>
jlib.cfg.clientsetting = {
    ["lan"] = jlib.cfg.lan, ["theme"] = jlib.cfg.theme,
    ["sound_ui"] = jlib.cfg.sound_ui, ["sound_ui_volume"] = jlib.cfg.sound_ui_volume
}

list.Set(
    "DesktopWindows", "Jlib",
    {
        title = "Jlib",
        icon = "jlib/img/logo-jlib.png",
        init = function(i, w)
            jlib.SettingsMenu()
        end
    })

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w-  