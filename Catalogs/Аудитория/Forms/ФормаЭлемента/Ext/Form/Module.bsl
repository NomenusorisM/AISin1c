﻿&НаКлиенте
Процедура МестаПриИзменении(Элемент)   
	Если Не Параметры.Ключ.Пустая() Тогда 
		Если МестаДоИзменения > Объект.Места Тогда
			ТекстВопроса = "Уменьшение мест аудитории может привести к ошибкам в расписании. Продолжить?";
			Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет);
			Если Ответ = КодВозвратаДиалога.Нет Тогда
				Объект.Места = МестаДоИзменения;
			Иначе МестаДоИзменения = Объект.Места;
			КонецЕсли; 
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	МестаДоИзменения = Объект.Места;
КонецПроцедуры
