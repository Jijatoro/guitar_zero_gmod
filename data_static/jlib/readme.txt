--------------------------------------------------------------------------------------------------------------|>
--[+] [EN] :--:--:--:--:--:--:--:--:--:--:--:}>                                                               |>
--------------------------------------------------------------------------------------------------------------|>
# jlib Library - VGUI Elements

## Creating Elements:
>> jlib.vgui.Create("element_name", parent_or_nil)

Note: You can use abbreviated names (first letters). The system will automatically determine the required element.

--------------------------------------------------------------------------------------------------------------|>
📋 Elements List                                                                                              |>
--------------------------------------------------------------------------------------------------------------|>
[1.] accept - Confirmation dialog
Functions:
    • :SetFunc(func) - Function to execute upon confirmation
    • :SetText(string) - Main message text

[2.] avatar - Player avatar
Functions:
    • :SetAvatar(player) - Player to display avatar for
    • :SetColor(Color) - Frame color

[3.] button - Button
Functions:
    • :SetText(string) - Button text
    • :SetImage(string) - Icon name from jlib
    • :SetDraw(bool) - Draw background (true) or text only (false)
    • :SetStatus(bool) - Visual state
    • :Enable() / :Disable() - Enable/disable button

[4.] chapter - Window/tab switcher
Functions:
    • :SetPosition("h"|"v") - Layout: "h" - horizontal, "v" - vertical
    • :SetForm("t"|"i") - Form: "t" - text, "i" - icons
    • :SetType("base"|"round"|"none") - Display style
    • :SetContent(panel1, panel2, ...) - Panels for tabs

[5.] checkbox - Checkbox
Functions:
    • :SetText(string) - Text beside checkbox
    • :SetValue(bool) / :GetValue() - Set/get state
    • :SetType("base"|"round"|"none") - Style
    • :Enable() / :Disable() - Enable/disable

[6.] frame - Main window
Functions:
    • :SetText(string) - Window title
    • :ShowCloseButton(bool) - Show close button
    • :SetHide(bool) - Hide window body

[7.] gallery - Gallery with image and text
Functions:
    • :SetData(table) - Data to display
    • :SetKey(number) - Index of displayed item
    • :SetType("base"|"round"|"none") - Style

[8.] hint - Tooltip
Functions:
    • :SetText(string) - Tooltip text
    • :SetMat(string) - Icon name from jlib

[9.] key - Key selector
Functions:
    • :SetValue(KEY_*) - Key code
    • :SetText(string) - Action description
    • :SetType("base"|"round"|"none") - Style

[10.] label - Text element
    • Full DLabel analog with jlib settings

[11.] panel - Base panel
Functions:
    • :SetType("base"|"round"|"none") - Style
    • :SetName(string) / :GetName() - Unique name
    • :SetData(table, itemsPerPage) - Data for pagination

[12.] progress - Progress bar
Functions:
    • :SetText(string) - Text above bar
    • :SetMax(number) - Maximum value
    • :SetValue(number) / :GetValue() - Current value

[13.] scroll - Scrollable panel
Functions:
    • :SetType("base"|"none") - Style

[14.] search - Element search
Functions:
    • :SetData(panel) - Panel with data to search
    • :SetValue(string) - Preset search text

[15.] selector - List selector
Functions:
    • :SetData(table) - List of options
    • :SetName(string) - Unique name (for submit)
    • :SetValue(string) - Default value
    • :Enable() / :Disable() - Enable/disable

[16.] slider - Number slider
Functions:
    • :SetText(string) - Text beside slider
    • :SetMax(number) - Maximum number
    • :SetMin(number) - Minimum number
    • :SetValue(number) - Initial value
    • :SetType("base"|"round"|"none") - Style

[17.] submit - Validation button
Functions:
    • :SetData(element1, element2, ...) - Elements to validate
    • :Check() - Check data (returns true/false)

[18.] switch - Toggle switch
Functions:
    • :SetText(string) - Text beside switch
    • :SetValue(bool) / :GetValue() - Set/get state
    • :Enable() / :Disable() - Enable/disable

[19.] textblock - Multi-line text with scroll
Functions:
    • :SetValue(string) - Text to display
    • :SetHide(bool) - Hide background
    • :SetEnabled(bool) - Allow editing

[20.] textentry - Text input field
Functions:
    • :SetValue(string) - Default text
    • :SetName(string) - Unique name (for submit)
    • :SetMinMax(min, max) - Minimum and maximum length
    • :SetType("base"|"none") - Style
    • :SetEnabled(bool) - Allow editing

[21.] warning - Popup warning
Functions:
    • :SetText(string) - Warning text
    • :SetMat(string) - Icon name from jlib
    • Also available: jlib.vgui.SetWarning(text, mat, parent)

[22.] table - Panel with table data
Functions:
    • :SetData(table, number or nil) - Fill data container, where *table* - data, number - items per page.
    • Example data:
    local my_data = {
        category = {"name", "surname", "age"},
        size = {350, 150, 153},
        data = {
            [1] = {"Ivan", "Abobova", 52},
            [2] = {"Arthur", "Gueev", 32},
        }
    }

[23.] color - Color picker element
Functions:
    • :GetValue() - Get color selected by user
    • :SetText(string) - Main text

[24.] model - Model rendering element
Functions:
    • For other operations use .dmodel.
    • :SetModel(string) - Set model by .mdl path
    • :SetForm(string) - Use ready templates for model position/size. Available options: "pm-face", "pm-face-little", "pm-face-big", "pm", "pm-little", "pm-big", "model", "model-little", "model-very-little", "model-big". If options don't fit, use lower functions manually.
    • :SetFOV(number) - Set model distance (50+- is standard).
    • :SetCamPos(vector) - Set camera position (x (usually 30-50), y (usually 0), point where model's eyes look).
    • :SetLookAt(vector) - Set model position (x (usually 0), y (usually 0), point where model's eyes look), z - (lower if needed higher).
    • :SetText(string) - Set bottom label text.
    • :SetTextCustom(string, x, y) - Custom text in any block zone.
    • :SetValue(number) - Set quantity.
    • :SetColorBG(color, color) - Set background color (normal state, hover state).

[25.] rating - Rating element (1-5 stars)
Functions:
    • :SetType("base"|"round"|"none") - Background display style.
    • :SetValue(number) - Set rating from 1 to 5.
    • :GetValue() - Get set rating.
    • :SetText(string) - Set main text.

[26.] image - Image drawing
Functions:
    • :SetType("base"|"round") - Background display style.
    • :SetDraw(bool) - Draw background for image?
    • :Enable(bool) - Enable hover highlight (this element supports .DoClick like button).
    • :SetColor(color) - Change main image color.

[27.] tip - Text tooltip for specified elements.
Functions:
    • target:SetTip(string). 

[28.] drag - Drag element
Functions:
    • target:SetDrag(func or nil) - Set target + optional function. Function will receive 2 values (x, y), checking position when LMB mouse cursor is released. More precise UI element position can still be obtained: element:LocalToScreen(0, 0).

--------------------------------------------------------------------------------------------------------------|>
--[+] [DE] :--:--:--:--:--:--:--:--:--:--:--:}>                                                               |>
--------------------------------------------------------------------------------------------------------------|>
# jlib Bibliothek - VGUI Elemente

## Elemente erstellen:
>> jlib.vgui.Create("element_name", parent_or_nil)

Hinweis: Sie können abgekürzte Namen (erste Buchstaben) verwenden. Das System erkennt automatisch das benötigte Element.

--------------------------------------------------------------------------------------------------------------|>
📋 Elementliste                                                                                            |>
--------------------------------------------------------------------------------------------------------------|>
[1.] accept - Bestätigungsdialog
Funktionen:
    • :SetFunc(func) - Funktion bei Bestätigung ausführen
    • :SetText(string) - Hauptnachrichtentext

[2.] avatar - Spieleravatar
Funktionen:
    • :SetAvatar(player) - Spieler für Avatar-Anzeige
    • :SetColor(Color) - Rahmenfarbe

[3.] button - Button
Funktionen:
    • :SetText(string) - Button-Text
    • :SetImage(string) - Icon-Name aus jlib
    • :SetDraw(bool) - Hintergrund zeichnen (true) oder nur Text (false)
    • :SetStatus(bool) - Visueller Status
    • :Enable() / :Disable() - Button aktivieren/deaktivieren

[4.] chapter - Fenster/Tab-Umschalter
Funktionen:
    • :SetPosition("h"|"v") - Anordnung: "h" - horizontal, "v" - vertikal
    • :SetForm("t"|"i") - Form: "t" - Text, "i" - Icons
    • :SetType("base"|"round"|"none") - Anzeigestil
    • :SetContent(panel1, panel2, ...) - Panels für Tabs

[5.] checkbox - Checkbox
Funktionen:
    • :SetText(string) - Text neben Checkbox
    • :SetValue(bool) / :GetValue() - Status setzen/erhalten
    • :SetType("base"|"round"|"none") - Stil
    • :Enable() / :Disable() - Aktivieren/deaktivieren

[6.] frame - Hauptfenster
Funktionen:
    • :SetText(string) - Fenstertitel
    • :ShowCloseButton(bool) - Schließen-Button anzeigen
    • :SetHide(bool) - Fensterkörper ausblenden

[7.] gallery - Galerie mit Bild und Text
Funktionen:
    • :SetData(table) - Anzuzeigende Daten
    • :SetKey(number) - Index des angezeigten Elements
    • :SetType("base"|"round"|"none") - Stil

[8.] hint - Tooltip
Funktionen:
    • :SetText(string) - Tooltip-Text
    • :SetMat(string) - Icon-Name aus jlib

[9.] key - Tastenauswahl
Funktionen:
    • :SetValue(KEY_*) - Tastencode
    • :SetText(string) - Aktionsbeschreibung
    • :SetType("base"|"round"|"none") - Stil

[10.] label - Textelement
    • Vollständiges DLabel-Analog mit jlib-Einstellungen

[11.] panel - Basis-Panel
Funktionen:
    • :SetType("base"|"round"|"none") - Stil
    • :SetName(string) / :GetName() - Eindeutiger Name
    • :SetData(table, itemsPerPage) - Daten für Paginierung

[12.] progress - Fortschrittsbalken
Funktionen:
    • :SetText(string) - Text über Balken
    • :SetMax(number) - Maximalwert
    • :SetValue(number) / :GetValue() - Aktueller Wert

[13.] scroll - Scrollbares Panel
Funktionen:
    • :SetType("base"|"none") - Stil

[14.] search - Elementsuche
Funktionen:
    • :SetData(panel) - Panel mit zu durchsuchenden Daten
    • :SetValue(string) - Voreingestellter Suchtext

[15.] selector - Listenauswahl
Funktionen:
    • :SetData(table) - Liste der Optionen
    • :SetName(string) - Eindeutiger Name (für submit)
    • :SetValue(string) - Standardwert
    • :Enable() / :Disable() - Aktivieren/deaktivieren

[16.] slider - Zahlen-Schieberegler
Funktionen:
    • :SetText(string) - Text neben Regler
    • :SetMax(number) - Maximale Zahl
    • :SetMin(number) - Minimale Zahl
    • :SetValue(number) - Anfangswert
    • :SetType("base"|"round"|"none") - Stil

[17.] submit - Validierungsbutton
Funktionen:
    • :SetData(element1, element2, ...) - Zu validierende Elemente
    • :Check() - Daten prüfen (gibt true/false zurück)

[18.] switch - Umschalter
Funktionen:
    • :SetText(string) - Text neben Umschalter
    • :SetValue(bool) / :GetValue() - Status setzen/erhalten
    • :Enable() / :Disable() - Aktivieren/deaktivieren

[19.] textblock - Mehrzeiliger Text mit Scroll
Funktionen:
    • :SetValue(string) - Anzuzeigender Text
    • :SetHide(bool) - Hintergrund ausblenden
    • :SetEnabled(bool) - Bearbeitung erlauben

[20.] textentry - Texteingabefeld
Funktionen:
    • :SetValue(string) - Standardtext
    • :SetName(string) - Eindeutiger Name (für submit)
    • :SetMinMax(min, max) - Minimale und maximale Länge
    • :SetType("base"|"none") - Stil
    • :SetEnabled(bool) - Bearbeitung erlauben

[21.] warning - Popup-Warnung
Funktionen:
    • :SetText(string) - Warnungstext
    • :SetMat(string) - Icon-Name aus jlib
    • Auch verfügbar: jlib.vgui.SetWarning(text, mat, parent)

[22.] table - Panel mit Tabellendaten
Funktionen:
    • :SetData(table, number or nil) - Datencontainer füllen, wo *table* - Daten, number - Elemente pro Seite.
    • Beispiel-Daten:
    local my_data = {
        category = {"name", "surname", "alter"},
        size = {350, 150, 153},
        data = {
            [1] = {"Ivan", "Abobova", 52},
            [2] = {"Arthur", "Gueev", 32},
        }
    }

[23.] color - Farbauswahlelement
Funktionen:
    • :GetValue() - Vom Benutzer gewählte Farbe erhalten
    • :SetText(string) - Haupttext

[24.] model - Modelldarstellungselement
Funktionen:
    • Für andere Operationen .dmodel verwenden.
    • :SetModel(string) - Modell nach .mdl-Pfad setzen
    • :SetForm(string) - Fertige Vorlagen für Modellposition/-größe verwenden. Verfügbare Optionen: "pm-face", "pm-face-little", "pm-face-big", "pm", "pm-little", "pm-big", "model", "model-little", "model-very-little", "model-big". Wenn Optionen nicht passen, untere Funktionen manuell verwenden.
    • :SetFOV(number) - Modellabstand setzen (50+- ist Standard).
    • :SetCamPos(vector) - Kameraposition setzen (x (normalerweise 30-50), y (normalerweise 0), Punkt, wohin Modelaugen schauen).
    • :SetLookAt(vector) - Modellposition setzen (x (normalerweise 0), y (normalerweise 0), Punkt, wohin Modelaugen schauen), z - (niedriger wenn höher benötigt).
    • :SetText(string) - Unteren Beschriftungstext setzen.
    • :SetTextCustom(string, x, y) - Benutzerdefinierter Text in beliebiger Blockzone.
    • :SetValue(number) - Menge setzen.
    • :SetColorBG(color, color) - Hintergrundfarbe setzen (Normalzustand, Hover-Zustand).

[25.] rating - Bewertungselement (1-5 Sterne)
Funktionen:
    • :SetType("base"|"round"|"none") - Hintergrundanzeigestil.
    • :SetValue(number) - Bewertung von 1 bis 5 setzen.
    • :GetValue() - Gesetzte Bewertung erhalten.
    • :SetText(string) - Haupttext setzen.

[26.] image - Bildzeichnung
Funktionen:
    • :SetType("base"|"round") - Hintergrundanzeigestil.
    • :SetDraw(bool) - Hintergrund für Bild zeichnen?
    • :Enable(bool) - Hover-Hervorhebung aktivieren (dieses Element unterstützt .DoClick wie Button).
    • :SetColor(color) - Hauptbildfarbe ändern.

[27.] tip - Text-Tooltip für bestimmte Elemente.
Funktionen:
    • target:SetTip(string). 

[28.] drag - Drag-Element
Funktionen:
    • target:SetDrag(func or nil) - Zielobjekt setzen + optional Funktion. Funktion erhält 2 Werte (x, y), prüft Position bei Loslassen der LMB-Mauszeigers. Präzisere UI-Elementposition kann weiterhin erhalten werden: element:LocalToScreen(0, 0).

--------------------------------------------------------------------------------------------------------------|>
--[+] [RU] :--:--:--:--:--:--:--:--:--:--:--:}>                                                               |>
--------------------------------------------------------------------------------------------------------------|>
# Библиотека jlib - VGUI элементы

## Создание элементов:
>> jlib.vgui.Create("имя_элемента", родитель_или_nil)

Примечание: Можно использовать сокращённые имена (первые буквы). Система автоматически определит нужный элемент.

--------------------------------------------------------------------------------------------------------------|>
📋 Список элементов																							  |>
--------------------------------------------------------------------------------------------------------------|>
[1.] accept - Окно подтверждения действия
Функции:
	• :SetFunc(func) - Функция, выполняемая при подтверждении
	• :SetText(string) - Основной текст сообщения

[2.] avatar - Аватар игрока
Функции:
	• :SetAvatar(player) - Игрок для отображения аватара
	• :SetColor(Color) - Цвет рамки

[3.] button - Кнопка
Функции:
	• :SetText(string) - Текст кнопки
	• :SetImage(string) - Имя иконки из jlib
	• :SetDraw(bool) - Отображать фон (true) или только текст (false)
	• :SetStatus(bool) - Визуальное состояние
	• :Enable() / :Disable() - Включить/выключить кнопку

[4.] chapter - Переключатель окон/вкладок
Функции:
	• :SetPosition("h"|"v") - Расположение: "h" - горизонтально, "v" - вертикально
	• :SetForm("t"|"i") - Форма: "t" - текст, "i" - иконки
	• :SetType("base"|"round"|"none") - Стиль отображения
	• :SetContent(panel1, panel2, ...) - Панели для вкладок

[5.] checkbox - Чекбокс
Функции:
	• :SetText(string) - Текст рядом
	• :SetValue(bool) / :GetValue() - Установить/получить состояние
	• :SetType("base"|"round"|"none") - Стиль
	• :Enable() / :Disable() - Включить/выключить

[6.] frame - Основное окно
Функции:
	• :SetText(string) - Заголовок окна
	• :ShowCloseButton(bool) - Показывать кнопку закрытия
	• :SetHide(bool) - Скрыть тело окна

[7.] gallery - Галерея с изображением и текстом
Функции:
	• :SetData(table) - Данные для отображения
	• :SetKey(number) - Индекс отображаемого элемента
	• :SetType("base"|"round"|"none") - Стиль

[8.] hint - Всплывающая подсказка
Функции:
	• :SetText(string) - Текст подсказки
	• :SetMat(string) - Имя иконки из jlib

[9.] key - Выбор клавиши
Функции:
	• :SetValue(KEY_*) - Код клавиши
	• :SetText(string) - Описание действия
	• :SetType("base"|"round"|"none") - Стиль

[10.] label - Текстовый элемент
	• Полный аналог DLabel с настройками jlib

[11.] panel - Базовая панель
Функции:
	• :SetType("base"|"round"|"none") - Стиль
	• :SetName(string) / :GetName() - Уникальное имя
	• :SetData(table, itemsPerPage) - Данные для пагинации

[12.] progress - Индикатор прогресса
Функции:
	• :SetText(string) - Текст над индикатором
	• :SetMax(number) - Максимальное значение
	• :SetValue(number) / :GetValue() - Текущее значение

[13.] scroll - Прокручиваемая панель
Функции:
	• :SetType("base"|"none") - Стиль

[14.] search - Поиск по элементам
Функции:
	• :SetData(panel) - Панель с данными для поиска
	• :SetValue(string) - Предустановленный текст поиска

[15.] selector - Выбор из списка
Функции:
	• :SetData(table) - Список вариантов
	• :SetName(string) - Уникальное имя (для submit)
	• :SetValue(string) - Значение по умолчанию
	• :Enable() / :Disable() - Включить/выключить

[16.] slider - Выбор числа через ползунок
Функции:
	• :SeText(string) - Текст рядом
	• :SetMax(number) - Максимальное число
	• :SetMin(number) - Минимальное число
	• :SetValue(number) - Начальное значение
	• :SetType("base"|"round"|"none") - Стиль	

[17.] submit - Кнопка проверки введённых данных.
Функции:
	• :SetData(element1, element2, ...) - Элементы для валидации
	• :Check() - Проверка данных (возвращает true/false)

[18.] switch - Переключатель
Функции:
	• :SetText(string) - Текст рядом
	• :SetValue(bool) / :GetValue() - Установить/получить состояние
	• :Enable() / :Disable() - Включить/выключить

[19.] textblock - Многострочный текст с прокруткой
Функции:
	• :SetValue(string) - Текст для отображения
	• :SetHide(bool) - Скрыть фон
	• :SetEnabled(bool) - Разрешить редактирование

[20.] textentry - Поле ввода текста
Функции:
	• :SetValue(string) - Текст по умолчанию
	• :SetName(string) - Уникальное имя (для submit)
	• :SetMinMax(min, max) - Минимальная и максимальная длина
	• :SetType("base"|"none") - Стиль
	• :SetEnabled(bool) - Разрешить редактирование

[21.] warning - Всплывающее предупреждение
Функции:
	• :SetText(string) - Текст предупреждения
	• :SetMat(string) - Имя иконки из jlib
    • Можно и так: jlib.vgui.SetWarning(text, mat, parent)

[22.] table - Панель с табличными данными
Функции:
	• :SetData(table, number or nil) - Заполнение контейнера данных, где *table* - данные, number - количесво элементов на странице.
	• Пример данных:
	local my_data = {
		category = {"имя", "фамилия", "возраст"},
		size = {350, 150, 153},
		data = {
			[1] = {"Иван", "Абобова", 52},
			[2] = {"Артур", "Гуеев", 32},
		}
	}

[23.] color - Элемент выбора цвета
Функции:
	• :GetValue() - Получить цвет, что выбрал пользователь.
	• :SetText(string) - Основной текст

[24.] model - Элемент с отрисовкой модели
Функции:
    • Для иного обращения используйте .dmodel.
	• :SetModel(string) - Установка модели по пути .mdl
	• :SetForm(string) - Использование готовых шаблонов поднастройки положения и размера модели. Имеющиеся варианты: "pm-face", "pm-face-little", "pm-face-big", "pm", "pm-little", "pm-big", "model", "model-little", "model-very-little", "model-big". Если варианты не подходят, придётся вручную использовать нижние функции.
	• :SetFOV(number) - Установка расстояния модели (50+- является стандартным значением).
	• :SetCamPos(vector) - Установка позиции камеры (x (обычно 30-50), y (обычно 0), точка куда смотрят глаза модели).
	• :SetLookAt(vector) - Установка позиция модели (x (обычно 0), y (обычно 0), точка куда смотрят глаза модели), z - (ниже, если надо выше).
	• SetText(string) - Установка текста именования снизу.
    • SetTextCustom(string, x, y) - Кастомный текст в любой зоне блока.
	• SetValue(number) - Установка количества.
    • :SetColorBG(color, color) - Установить цвет фона (обычное состояние, состояние при наводке).

[25.] rating - Элемент оценивания от 1 до 5 звёзд
Функции:
	• :SetType("base"|"round"|"none") - Стиль отображения заднего тела.
	• :SetValue(number) - Установить оценку от 1 до 5.
	• :GetValue() - Получить поставленную оценку.
	• :SetText(string) - Установка основного текста.

[26.] image - Рисование картинки
Функции:
	• :SetType("base"|"round") - Стиль отображения заднего тела.
	• :SetDraw(bool) - Рисовать заднее тело для картинки?
	• :Enable(bool)- Включить выделение при наводке (данный элемент как и кнопка поддерживает .DoClick).
	• :SetColor(color) - Измененить основной цвет картинки.

[27.] tip - Текстовая подсказка к указанным элементам.
Функции:
	• target:SetTip(string). 

[28.] drug - Текстовая подсказка к указанным элементам.
Функции:
    • target:SetDrag(func or nil) - Указание объекта + при желании функция. Функция получит 2 значения (x, y), проверяя положения в момент отжатия ЛКМ курсора мыши. Более точное положение того или иного ui элемента всё также можно получить так: element:LocalToScreen(0, 0).