﻿
&НаКлиенте
Процедура ФамилияПриИзменении(Элемент)
	Объект.Наименование = 
		Объект.Фамилия + " "
		+ Лев(Объект.Имя, 1) + ". "
		+ Лев(Объект.Отчество, 1) + ".";
КонецПроцедуры

&НаКлиенте
Процедура ИмяПриИзменении(Элемент)
	ФамилияПриИзменении(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ОтчествоПриИзменении(Элемент)
	ФамилияПриИзменении(Элемент);
КонецПроцедуры
