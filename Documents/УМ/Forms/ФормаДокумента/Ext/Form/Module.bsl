﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Объект.Дата = ТекущаяДата();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьМатериал(Команда)  
	ПерейтиПоНавигационнойСсылке(Объект.Файл);
КонецПроцедуры
