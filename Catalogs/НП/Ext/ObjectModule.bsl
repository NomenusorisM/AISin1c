﻿Процедура ПередЗаписью(Отказ)
	Наим = ЭтотОбъект.Наименование;
	Если 
		ЭтотОбъект.Квалификация = Перечисления.Квалификация.Магистратура
		И НЕ СтрНайти(Наим, "(маг.)")
	Тогда
		ЭтотОбъект.Наименование = Наим + " (маг.)";
	ИначеЕсли
		ЭтотОбъект.Квалификация = Перечисления.Квалификация.Специалитет
		И НЕ СтрНайти(Наим, "(спец.)")
	Тогда
		ЭтотОбъект.Наименование = Наим + " (спец.)";	
	КонецЕсли;
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(*) КАК Количество
	|ИЗ Справочник.НП
	|ГДЕ Наименование = &Наименование
	|	И Квалификация = &Квалификация
	|"); 
	Запрос.УстановитьПараметр("Наименование", ЭтотОбъект.Наименование);
	Запрос.УстановитьПараметр("Квалификация", ЭтотОбъект.Квалификация);
	Результат = Запрос.Выполнить().Выгрузить();
	
	Если Результат[0].Количество > 0 Тогда
		Сообщить("НП с таким наименованием и квалификацией уже существует!");
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры