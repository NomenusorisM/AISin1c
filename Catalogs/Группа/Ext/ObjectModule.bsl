﻿Процедура ПередЗаписью(Отказ)
	Родитель = ЭтотОбъект.Родитель; 
	НазвМассив = СтрРазделить(ЭтотОбъект.Наименование, "-");  
	
	Если НазвМассив.Количество() <> 2 Тогда
		Сообщить("Наименование группы должно быть в формате <НП>-<Курс><Номер группы>");
		Отказ = Истина;
	КонецЕсли;
	
	Если СтрСравнить(Строка(ЭтотОбъект.Родитель), НазвМассив[0]) <> 0 Тогда
		Сообщить("Название группы должно начинаться с " + Родитель + "-");
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры