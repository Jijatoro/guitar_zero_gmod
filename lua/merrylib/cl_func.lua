----------------------------------------------------------------------------------------------|>
--[+] Тех. переменные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
MerryUI = {}

----------------------------------------------------------------------------------------------|>
--[+] Основное окно :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Frame(frame, title, x, y, text_pos, hide, close)
	frame:SetSize(x, y)
	frame:Center()
	frame:ShowCloseButton(close)
	frame:SetText(title)
	frame:MakePopup()
	frame:SetHide(hide)
	if (text_pos != nil) then
		frame:SetTextPos(text_pos)
	end 
end

----------------------------------------------------------------------------------------------|>
--[+] Тех. граница для основного окна :--:--:--:--:--:--:--:--:--:--:--:}>                    |>
----------------------------------------------------------------------------------------------|>
function MerryUI.MainPanel(frame, panel, x, y, type)
	-- *На случай, если нужны будут элементы, выходящие за пределы таргета]]
	panel:SetSize(x, y-63)
	panel:SetPos(0, 60)
	if (type) then
		panel:SetType(type)
	else
		panel:SetType("none")
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Простое основное окно :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
----------------------------------------------------------------------------------------------|>
function MerryUI.FrameSimple(frame, type, value, close_bool, x, y)
	frame:SetSize(x, y)
	frame:Center()
	frame:ShowCloseButton(close_bool)
	frame:MakePopup()
	frame:SetType(type)
end

----------------------------------------------------------------------------------------------|>
--[+] Окно с ползунком :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Scroll(target, form, x, y)
	if (form) then
		target:SetPos(150, 0)
		target:SetSize(x-300, y-70)
	else
		target:SetPos(150, 60)
		target:SetSize(x-300, y-123)
	end

	target:SetType("none")
	target:SetVisible(false)
end

----------------------------------------------------------------------------------------------|>
--[+] Панель :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Panel(panel, parent, popur, type, value, x, y, dock, left, top, right, bottom, close_btn)
	if (parent) then
		panel:SetSize(x, y)
		panel:Dock(FILL)
		panel:DockMargin(150, 0, 150, 0)
	else
		panel:SetSize(x, y)
	end

	if (popur) then
		panel:MakePopup()
	end

	panel:SetType(type)
	panel:SetValue(value)

	if (dock != nil) then
		panel:Dock(dock)
		if (left != nil) then
			panel:DockMargin(left, top, right, bottom)
		end
	else
		panel:Center()
	end

	if (close_btn) then
		local head = vgui.Create("MerryUI.Panel", panel)
			head:SetSize(0, 60)
			head:Dock(TOP)
			head:DockMargin(0, 5, 0, 0)
			head:DockPadding(0, 7, 0, 7)
			head:SetType("nodraw")

		local cls_btn = vgui.Create("MerryUI.ButtonIcon", head)
			cls_btn:SetSize(47, 27)
			cls_btn:SetImage(Merry.Mat["close"])
			cls_btn:Dock(RIGHT)
			cls_btn:DockMargin(0, 0, 15, 0)
			cls_btn.DoClick = function()
				panel:Remove()
			end		
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Переключатель окон :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Chapter(chapter, action, type, form, val, size, dock, left, top, right, bottom)
		chapter:SetType(type)
		chapter:SetForm(form)
		chapter:SetElements(val)	
	if (size == nil) and (form == 1) then
		chapter:SetSize(0, 50)
	elseif (size == nil) and (form == 2) then
		chapter:SetSize(0, 210)
	else
		chapter:SetSize(0, size)
	end
	if (action == "panel") then
		chapter:SetAction("panel")
		chapter:Dock(dock)
		if (left == nil) and (form == 1) then
			chapter:DockMargin(160, 7, 160, 0)
		elseif (left == nil) and (form == 2) then
			chapter:DockMargin(460, 0, 460, 0)
		else
			chapter:DockMargin(left, top, right, bottom)
		end
	else
		chapter:SetAction("text")
		chapter:Dock(dock)	
		if (left == nil) and (form == 1) then
			chapter:DockMargin(160, 7, 160, 0)
		elseif (left == nil) and (form == 2) then
			chapter:DockMargin(420, 0, 420, 0)
		else
			chapter:DockMargin(left, top, right, bottom)
		end
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Окно выбора :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Selector(selector, target, text, value, tbl, key, dock, left, top, right, bottom)
	selector:SetText(text)
	if (value != nil) then
		selector:SetValue(value)
	end
	selector:SetKeyTbl(tbl)
	selector:Dock(dock)
	if (left == nil) then
		selector:DockMargin(100, 3, 100, 3)
	else
		selector:DockMargin(left, top, right, bottom)
	end 
end		

----------------------------------------------------------------------------------------------|>
--[+] Окно ввода текста :--:--:--:--:--:--:--:--:--:--:--:}>                                  |>
----------------------------------------------------------------------------------------------|>
function MerryUI.TextEntry(text_entry, placeholder, mode, dock, left, top, right, bottom)
	text_entry:SetPlaceholderText(placeholder)
	text_entry:SetEnabled(mode)
	text_entry:Dock(dock)
	if (left == nil) then
		text_entry:DockMargin(25, 3, 25, 3)
	else
		text_entry:DockMargin(left, top, right, bottom)
	end 
end 

----------------------------------------------------------------------------------------------|>
--[+] Кнопка с проверкой на действительность :--:--:--:--:--:--:--:--:--:--:--:}>             |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Submit(submit, dock, left, top, right, bottom)
	submit:Dock(dock)
	if (left == nil) then
		submit:DockMargin(250, 15, 250, 3)
	else
		submit:DockMargin(left, top, right, bottom)
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Кнопка :--:--:--:--:--:--:--:--:--:--:--:}>                                             |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Button(button, text, draw, x, dock, left, top, right, bottom)
	button:SetText(text)
	button:SetDraw(draw)
	if (x == nil) then
		button:SetSize(210, 50)
	else
		button:SetSize(x, 50)
	end
	button:Dock(dock)
	if (left == nil) then
		button:DockMargin(230, 3, 230, 3)
	else
		button:DockMargin(left, top, right, bottom)
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Кнопка с иконкой :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
function MerryUI.ButtonIcon(button_icon, mat, x, y, dock, left, top, right, bottom)
	button_icon:SetImage(mat)
	if (x == nil) then
		button_icon:SetSize(50, 50)
	else
		button_icon:SetSize(x, y)
	end
	button_icon:Dock(dock)
	if (left == nil) then
		button_icon:DockMargin(315, 3, 315, 3)
	else
		button_icon:DockMargin(left, top, right, bottom)
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Элемент указывающий желаемую кнопку  :--:--:--:--:--:--:--:--:--:--:--:}>               |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Key(key, value, text, dock, left, top, right, bottom)
	if (value) then
		key:SetValue(value)
	end 
	key:SetText(text)
	key:Dock(dock)
	if (left == nil) then
		key:DockMargin(230, 3, 230, 3)
	else
		key:DockMargin(left, top, right, bottom)
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Текст с иконкой :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function MerryUI.LabelIcon(label_icon, text, mat, dock, left, top, right, bottom)
	label_icon:SetText(text)
	if (mat == nil) then
		label_icon:SetIcon(Merry.Mat["star"])
	else
		label_icon:SetIcon(Merry.Mat[mat])
	end
	label_icon:Dock(dock)
	if (left == nil) then
		label_icon:DockMargin(25, 5, 5, 0)
	else
		label_icon:DockMargin(left, top, right, bottom)
	end 
end

----------------------------------------------------------------------------------------------|>
--[+] Текст :--:--:--:--:--:--:--:--:--:--:--:}>                                              |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Label(label, text, font, x, y, align, dock, left, top, right, bottom)
	label:SetText(text)
    label:SetType(font)
	if (x == nil) then
		label:SetSize(410, 40)
	else
		label:SetSize(x, y)
	end 
    label:SetContentAlignment(align)

    if (dock) then
		label:Dock(dock)
		if (left == nil) then
			label:DockMargin(25, 5, 5, 0)
		else
			label:DockMargin(left, top, right, bottom)
		end 
	end
end

----------------------------------------------------------------------------------------------|>
--[+] Аватарка :--:--:--:--:--:--:--:--:--:--:--:}>                                           |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Avatar(avatar, ply, dock, left, top, right, bottom)
	avatar:SetAvatar(ply)
	avatar:Dock(dock)
	if (left == nil) then
		avatar:DockMargin(25, 5, 5, 0)
	else
		avatar:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Блок текста :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
----------------------------------------------------------------------------------------------|>
function MerryUI.TextBlock(text_block, placeholder, text, bool, hide, x, y, dock, left, top, right, bottom)
	text_block:SetText(text)
	text_block:SetSize(x, y)
	text_block:Dock(dock)
	text_block:SetEnabled(bool)
	text_block:SetHide(hide)
	text_block:SetPlaceholderText(placeholder)
	if (left == nil) then
		text_block:DockMargin(25, 5, 5, 25)
	else
		text_block:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Окна для инвентаря :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Inventory(inventory, type, value, dock, left, top, right, bottom, id)
	inventory:SetType(type)
	inventory:SetValue(value)
	inventory:SetStatus(id)
	inventory:Dock(dock)
	if (left == nil) then
		inventory:DockMargin(25, 5, 5, 0)
	else
		inventory:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Окна для F4 :--:--:--:--:--:--:--:--:--:--:--:}>                                        |>
----------------------------------------------------------------------------------------------|>
function MerryUI.JobF4(job, value, dock, left, top, right, bottom)
	job:SetValue(value)
	job:Dock(dock)
	if (left == nil) then
		job:DockMargin(25, 5, 5, 0)
	else
		job:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Окно с переключаемым контентом :--:--:--:--:--:--:--:--:--:--:--:}>                     |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Gallery(gallery, value, dock, left, top, right, bottom)
	gallery:SetValue(value)		
	gallery:Dock(dock)
	if (left == nil) then
		gallery:DockMargin(50, 5, 50, 5)
	else
		gallery:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Шкала прогресса :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Progress(progress, text, max, value, dock, left, top, right, bottom)
	progress:SetText(text)
	progress:SetMax(max)
	progress:SetValue(value)
	progress:Dock(dock)
	if (left == nil) then
		progress:DockMargin(200, 5, 200, 5)
	else
		progress:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Окно с галочкой :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function MerryUI.CheckBox(checkbox, value, text, dock, left, top, right, bottom)
	checkbox:SetValue(value)
	checkbox:SetText(text)
	checkbox:Dock(dock)
	if (left == nil) then
		checkbox:DockMargin(100, 5, 100, 5)
	else
		checkbox:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Переключатель :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Switch(switch, value, text, dock, left, top, right, bottom)
	switch:SetValue(value)
	switch:SetText(text)
	switch:Dock(dock)
	if (left == nil) then
		switch:DockMargin(95, 5, 95, 5)
	else
		switch:DockMargin(left, top, right, bottom)
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Ползунок с интервалом :--:--:--:--:--:--:--:--:--:--:--:}>                              |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Slider(slider, text, min, max, value, dock, left, top, right, bottom)
		slider:SetText(text)
		slider:SetMin(min)
		slider:SetMax(max)
		slider:SetValue(value)
		slider:Dock(dock)
		slider:DockMargin(0, 0, 0, 3)
		if (left == nil) then
			slider:DockMargin(55, 5, 55, 5)
		else
			slider:DockMargin(left, top, right, bottom)
		end
end
	
----------------------------------------------------------------------------------------------|>
--[+] Окно предупреждения :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Warning(icon, str, frame)
	if (frame == nil) then
		local warning = vgui.Create("MerryUI.Warning")
			warning:SetMat(icon)
			warning:SetText(str)
			warning:Center()
			warning:MakePopup()
	else
		local warning = vgui.Create("MerryUI.Warning", frame)
			warning:SetMat(icon)
			warning:SetText(str)
			warning:Center()		
	end 
end

----------------------------------------------------------------------------------------------|>
--[+] Окно подсказки :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Hint(icon, str)
	local warning = vgui.Create("MerryUI.Hint")
		warning:SetMat(icon)
		warning:SetText(str)
		warning:Center()		
end

----------------------------------------------------------------------------------------------|>
--[+] Окно для подтверждения :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Accept(frame, func, text)
	if (frame == nil) then
		local accept = vgui.Create("MerryUI.Accept")
		accept:Center()
		accept:SetFunc(func)
		accept:MakePopup()
		if (text != nil) then
			accept:SetText(text)
		end 
	else
		local accept = vgui.Create("MerryUI.Accept", frame)	
		accept:Center()
		accept:SetFunc(func)
		if (text != nil) then
			accept:SetText(text)
		end 
	end

	return accept
end

----------------------------------------------------------------------------------------------|>
--[+] Элемент поиска по введённому тексту :--:--:--:--:--:--:--:--:--:--:--:}>                |>
----------------------------------------------------------------------------------------------|>
function MerryUI.Searh(searh, btn_func, dock, left, top, right, bottom)
	searh:Dock(dock)
	if (left == nil) then
		searh:DockMargin(400, 5, 400, 5)
	else
		searh:DockMargin(left, top, right, bottom)
	end

	if (btn_func != nil) then
		searh.button.DoClick = function()
			btn_func(searh)
		end
	end
end 

----------------------------------------------------------------------------------------------|>
--[+] Измерение длины строки :--:--:--:--:--:--:--:--:--:--:--:}>                             |>
----------------------------------------------------------------------------------------------|>
function MerryUI.len(str)
  	local len = 0
  	local i = 1
  		while i <= #str do
    		local byte = string.byte(str, i)
    		if byte <= 127 then
      			i = i + 1
    		elseif byte <= 223 then
      			i = i + 2
    		elseif byte <= 239 then
      			i = i + 3
    		else
      			i = i + 4
    		end
    			len = len + 1
  		end
  	return len
end

----------------------------------------------------------------------------------------------|>
--[+] Обрезка текста :--:--:--:--:--:--:--:--:--:--:--:}>                                     |>
----------------------------------------------------------------------------------------------|>
function MerryUI.sub(str, start_char, end_char)
    local data_word = {}
    local len = 1
    local i = 1

    while i <= #str do
        if not (string.byte(str, i)) then break end
        local byte = string.byte(str, i)
        local char_length = 1

        if (len > end_char) then break end
        
        -- Определяем длину символа в UTF-8
        if byte <= 127 then
            char_length = 1
        elseif byte <= 223 then
            char_length = 2
        elseif byte <= 239 then
            char_length = 3
        else
            char_length = 4
        end

        if (len >= start_char) then
            local char = string.sub(str, i, i + char_length - 1)
            table.insert(data_word, char)
        end

        i = i + char_length
        len = len + 1
    end

    local new_data = table.concat(data_word, "")
    return new_data
end

----------------------------------------------------------------------------------------------|>
--[+] Проверка на плохие символы :--:--:--:--:--:--:--:--:--:--:--:}>                         |>
----------------------------------------------------------------------------------------------|>
function MerryUI.blacksymbol(str, form)
	if (form == "name") then
		for i = 1, string.len(str) do
			local cout = 0
			if (MerryBlackSymbol_Name[string.sub(str, i, i+cout)]) then
				return false
			end
				cout = cout+1
			end
	else
		for i = 1, string.len(str) do
			local cout = 0
			if (MerryBlackSymbol_Text[string.sub(str, i, i+cout)]) then
				return false
			end
			cout = cout+1
		end
	end
	return true
end