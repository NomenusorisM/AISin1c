﻿Процедура ПередЗаписью(Отказ)
	СимвОтчество = "";
	Если Не ПустаяСтрока(Отчество) Тогда
		СимвОтчество = Лев(Отчество, 1) + ".";
	КонецЕсли;
	Наименование = 
		Фамилия + " "
		+ Лев(Имя, 1) + ". "
		+ СимвОтчество;
КонецПроцедуры
