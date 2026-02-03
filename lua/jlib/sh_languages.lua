--------------------------------------------------------------------------------------------------------------|>
--[+] Variables :--:--:--:--:--:--:--:--:--:--:--:}>                                                          |>
--------------------------------------------------------------------------------------------------------------|>
if not (jlib) then jlib = {} end
if not (jlib.cfg) then jlib.cfg = {} end
if not (jlib.cfg.lans) then jlib.cfg.lans = {} end
local l = jlib.cfg.lans

--------------------------------------------------------------------------------------------------------------|>
--[+] English :--:--:--:--:--:--:--:--:--:--:--:}>                                                            |>
--------------------------------------------------------------------------------------------------------------|>
l["en"] = {
	["yes"] = "Yes",
	["no"] = "No",
	["ok"] = "OK",
	["in"] = "in",
	["oops"] = "Oops",
	["ready"] = "Ready",
	["text"] = "Text",
	["main-menu"] = "Main menu",
	["your-request"] = "Your request...",
	["not-selected"] = "not selected",
	["settings"] = "Settings",
	["language"] = "Language",
	["theme"] = "Theme",
	["sound_ui"] = "Enable sounds?",
	["sound_ui_volume"] = "Sound volume",
	["music_volume"] = "Music volume",
	["asset-credits-rights"] = "Copyrights and licenses",
	["accept-notify"] = "Are you sure you want to perform this action?",
	["tip-for-bind"] = "RMB - select button  LMB - clear field",
	["oops-dont-selected"] = "Oops. You haven't selected anything yet",
	["oops-nothing-specified"] = "nothing specified",
	["oops-forbidden-symbol"] = "contains forbidden symbol",
	["oops-should-be-minimum"] = "should be minimum",
	["oops-shouldnt-be-more"] = "shouldn't be more",
	["oops-unavailable-value-entered"] = "unavailable value entered",
	["oops-symbol"] = "symbol",
	["oops-symbols"] = "symbols"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] German :--:--:--:--:--:--:--:--:--:--:--:}>                                                             |>
--------------------------------------------------------------------------------------------------------------|>
l["de"] = {
	["yes"] = "Ja",
	["no"] = "Nein",
	["ok"] = "OK",
	["in"] = "in",
	["oops"] = "Ups",
	["ready"] = "Fertig",
	["text"] = "Text",
	["main-menu"] = "Hauptmenü",
	["your-request"] = "Ihre Anfrage...",
	["not-selected"] = "nicht ausgewählt",
	["settings"] = "Einstellungen",
	["language"] = "Sprache",
	["theme"] = "Thema",
	["sound_ui"] = "Sounds aktivieren?",
	["sound_ui_volume"] = "Soundlautstärke",
	["music_volume"] = "Musiklautstärke",
	["asset-credits-rights"] = "Urheberrechte und Lizenzen",
	["accept-notify"] = "Sind Sie sicher, dass Sie diese Aktion ausführen möchten?",
	["tip-for-bind"] = "RM - Taste auswählen  LM - Feld löschen",
	["oops-dont-selected"] = "Ups. Sie haben noch nichts ausgewählt",
	["oops-nothing-specified"] = "nichts angegeben",
	["oops-forbidden-symbol"] = "enthält verbotenes Symbol",
	["oops-should-be-minimum"] = "sollte mindestens sein",
	["oops-shouldnt-be-more"] = "sollte nicht mehr sein",
	["oops-unavailable-value-entered"] = "unverfügbarer Wert eingegeben",
	["oops-symbol"] = "Symbol",
	["oops-symbols"] = "Symbole"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Polish :--:--:--:--:--:--:--:--:--:--:--:}>                                                             |>
--------------------------------------------------------------------------------------------------------------|>
l["pl"] = {
	["yes"] = "Tak",
	["no"] = "Nie",
	["ok"] = "OK",
	["in"] = "w",
	["oops"] = "Ups",
	["ready"] = "Gotowe",
	["text"] = "Tekst",
	["main-menu"] = "Menu główne",
	["your-request"] = "Twoje zapytanie...",
	["not-selected"] = "nie wybrano",
	["settings"] = "Ustawienia",
	["language"] = "Język",
	["theme"] = "Motyw",
	["sound_ui"] = "Włączyć dźwięki?",
	["sound_ui_volume"] = "Głośność dźwięków",
	["music_volume"] = "Głośność muzyki",
	["asset-credits-rights"] = "Prawa autorskie i licencje",
	["accept-notify"] = "Czy na pewno chcesz wykonać tę akcję?",
	["tip-for-bind"] = "PPM - wybierz przycisk  LPM - wyczyść pole",
	["oops-dont-selected"] = "Ups. Nie wybrałeś jeszcze niczego",
	["oops-nothing-specified"] = "nic nie określono",
	["oops-forbidden-symbol"] = "zawiera zabroniony symbol",
	["oops-should-be-minimum"] = "powinno być minimum",
	["oops-shouldnt-be-more"] = "nie powinno być więcej",
	["oops-unavailable-value-entered"] = "wprowadzono niedostępną wartość",
	["oops-symbol"] = "symbol",
	["oops-symbols"] = "symboli"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Ukrainian :--:--:--:--:--:--:--:--:--:--:}>                                                             |>
--------------------------------------------------------------------------------------------------------------|>
l["uk"] = {
	["yes"] = "Так",
	["no"] = "Ні",
	["ok"] = "OK",
	["in"] = "в",
	["oops"] = "Упс",
	["ready"] = "Готово",
	["text"] = "Текст",
	["main-menu"] = "Головне меню",
	["your-request"] = "Ваш запит...",
	["not-selected"] = "не обрано",
	["settings"] = "Налаштування",
	["language"] = "Мова",
	["theme"] = "Тема",
	["sound_ui"] = "Увімкнути звуки?",
	["sound_ui_volume"] = "Гучність звуків",
	["music_volume"] = "Гучність музики",
	["asset-credits-rights"] = "Авторські права та ліцензії",
	["accept-notify"] = "Ви точно хочете виконати цю дію?",
	["tip-for-bind"] = "ПКМ - вибрати кнопку  ЛКМ - очистити поле",
	["oops-dont-selected"] = "Упс. Ви ще нічого не обрали",
	["oops-nothing-specified"] = "нічого не вказано",
	["oops-forbidden-symbol"] = "є заборонений символ",
	["oops-should-be-minimum"] = "має бути мінімум",
	["oops-shouldnt-be-more"] = "не повинно бути більше",
	["oops-unavailable-value-entered"] = "введено недоступне значення",
	["oops-symbol"] = "символу",
	["oops-symbols"] = "символів"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Turkish :--:--:--:--:--:--:--:--:--:--:--:}>                                                            |>
--------------------------------------------------------------------------------------------------------------|>
l["tr"] = {
	["yes"] = "Evet",
	["no"] = "Hayır",
	["ok"] = "Tamam",
	["in"] = "içinde",
	["oops"] = "Oops",
	["ready"] = "Hazır",
	["text"] = "Metin",
	["main-menu"] = "Ana menü",
	["your-request"] = "İsteğiniz...",
	["not-selected"] = "seçilmedi",
	["settings"] = "Ayarlar",
	["language"] = "Dil",
	["theme"] = "Tema",
	["sound_ui"] = "Sesler etkinleştirilsin mi?",
	["sound_ui_volume"] = "Ses seviyesi",
	["music_volume"] = "Müzik seviyesi",
	["asset-credits-rights"] = "Telif hakları ve lisanslar",
	["accept-notify"] = "Bu işlemi gerçekleştirmek istediğinize emin misiniz?",
	["tip-for-bind"] = "Sağ tık - düğme seç  Sol tık - alanı temizle",
	["oops-dont-selected"] = "Oops. Henüz hiçbir şey seçmediniz",
	["oops-nothing-specified"] = "hiçbir şey belirtilmedi",
	["oops-forbidden-symbol"] = "yasak sembol içeriyor",
	["oops-should-be-minimum"] = "en az olmalı",
	["oops-shouldnt-be-more"] = "daha fazla olmamalı",
	["oops-unavailable-value-entered"] = "kullanılamayan değer girildi",
	["oops-symbol"] = "sembol",
	["oops-symbols"] = "sembol"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] French :--:--:--:--:--:--:--:--:--:--:--:}>                                                             |>
--------------------------------------------------------------------------------------------------------------|>
l["fr"] = {
	["yes"] = "Oui",
	["no"] = "Non",
	["ok"] = "OK",
	["in"] = "dans",
	["oops"] = "Oups",
	["ready"] = "Prêt",
	["text"] = "Texte",
	["main-menu"] = "Menu principal",
	["your-request"] = "Votre demande...",
	["not-selected"] = "non sélectionné",
	["settings"] = "Paramètres",
	["language"] = "Langue",
	["theme"] = "Thème",
	["sound_ui"] = "Activer les sons?",
	["sound_ui_volume"] = "Volume des sons",
	["music_volume"] = "Volume de la musique",
	["asset-credits-rights"] = "Droits d'auteur et licences",
	["accept-notify"] = "Êtes-vous sûr de vouloir effectuer cette action?",
	["tip-for-bind"] = "Clic droit - sélectionner bouton  Clic gauche - effacer le champ",
	["oops-dont-selected"] = "Oups. Vous n'avez encore rien sélectionné",
	["oops-nothing-specified"] = "rien n'est spécifié",
	["oops-forbidden-symbol"] = "contient un symbole interdit",
	["oops-should-be-minimum"] = "doit être au minimum",
	["oops-shouldnt-be-more"] = "ne doit pas dépasser",
	["oops-unavailable-value-entered"] = "valeur indisponible entrée",
	["oops-symbol"] = "symbole",
	["oops-symbols"] = "symboles"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Spanish :--:--:--:--:--:--:--:--:--:--:--:}>                                                            |>
--------------------------------------------------------------------------------------------------------------|>
l["es"] = {
	["yes"] = "Sí",
	["no"] = "No",
	["ok"] = "OK",
	["in"] = "en",
	["oops"] = "Ups",
	["ready"] = "Listo",
	["text"] = "Texto",
	["main-menu"] = "Menú principal",
	["your-request"] = "Su solicitud...",
	["not-selected"] = "no seleccionado",
	["settings"] = "Configuración",
	["language"] = "Idioma",
	["theme"] = "Tema",
	["sound_ui"] = "¿Activar sonidos?",
	["sound_ui_volume"] = "Volumen de sonidos",
	["music_volume"] = "Volumen de música",
	["asset-credits-rights"] = "Derechos de autor y licencias",
	["accept-notify"] = "¿Está seguro de que desea realizar esta acción?",
	["tip-for-bind"] = "Clic derecho - seleccionar botón  Clic izquierdo - limpiar campo",
	["oops-dont-selected"] = "Ups. Aún no ha seleccionado nada",
	["oops-nothing-specified"] = "nada especificado",
	["oops-forbidden-symbol"] = "contiene símbolo prohibido",
	["oops-should-be-minimum"] = "debe ser mínimo",
	["oops-shouldnt-be-more"] = "no debe ser más",
	["oops-unavailable-value-entered"] = "valor no disponible ingresado",
	["oops-symbol"] = "símbolo",
	["oops-symbols"] = "símbolos"
}

--------------------------------------------------------------------------------------------------------------|>
--[+] Russian :--:--:--:--:--:--:--:--:--:--:--:}>                                                            |>
--------------------------------------------------------------------------------------------------------------|>
l["ru"] = {
	["yes"] = "Да",
	["no"] = "Нет",
	["ok"] = "ОК",
	["in"] = "в",
	["oops"] = "Упс",
	["ready"] = "Готово",
	["text"] = "Текст",
	["main-menu"] = "Главное меню",
	["your-request"] = "Ваш запрос...",
	["not-selected"] = "не выбрано",
	["settings"] = "Настройки",
	["language"] = "Язык",
	["theme"] = "Тема",
	["sound_ui"] = "Включить звуки?",
	["sound_ui_volume"] = "Громкость звуков",
	["music_volume"] = "Громкость музыки",
	["asset-credits-rights"] = "Авторские права и лицензии",
	["accept-notify"] = "Вы точно хотите совершить это действие?",
	["tip-for-bind"] = "ПКМ - выбрать кнопку  ЛКМ - очистить поле",
	["oops-dont-selected"] = "Упс. Вы еще ничего не выбрали",
	["oops-nothing-specified"] = "ничего не указано",
	["oops-forbidden-symbol"] = "есть запрещённый символ",
	["oops-should-be-minimum"] = "должно быть минимум",
	["oops-shouldnt-be-more"] = "не должно быть больше",
	["oops-unavailable-value-entered"] = "введено недоступное значение",
	["oops-symbol"] = "символа",
	["oops-symbols"] = "символов"
}

-->                      						 _M_                                      
-- [*] Who are you, Warrior? |~| Кто ты, Воин?  (0-0)                   
-->                                              -w-  