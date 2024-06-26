﻿&НаСервереБезКонтекста
Функция ПолучитьКолвоСтудентов(НазваниеГруппы) 
	Возврат Справочники
				.Группа
				.НайтиПоНаименованию(НазваниеГруппы)
				.КоличествоСтудентов;
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьСсылкуНаГруппу(НазваниеГруппы)  
	Возврат Справочники
				.Группа 
				.НайтиПоНаименованию(НазваниеГруппы)
				.Ссылка;
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьКолвоМестАудитории(Аудитория)
	Возврат Справочники
				.Аудитория
				.НайтиПоНаименованию(Аудитория)
				.Места;
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьМаксимальныйКодРасписания() 
	
	Запрос = Новый Запрос("
	|Выбрать
	|	МАКСИМУМ(Код) КАК Код
	|ИЗ
	|	РегистрСведений.Расписание"
	);     
	Результат = Запрос.Выполнить().Выгрузить();
	Возврат Результат[0].Код;
КонецФункции

&НаКлиенте
Процедура АудиторияОбработкаВыбора(Элемент, ВыбранноеЗначение, ДополнительныеДанные, СтандартнаяОбработка)
	АудВместимость = ПолучитьКолвоМестАудитории(ВыбранноеЗначение);
	Если ВсегоСтудентов > АудВместимость Тогда 
		Элементы.ВсегоСтудентов.ЦветТекста = Новый Цвет(255, 0, 0);
	Иначе
		Элементы.ВсегоСтудентов.ЦветТекста = Новый Цвет(0, 0, 0);	
	КонецЕсли; 
КонецПроцедуры

&НаКлиенте
Процедура ТЧГруппыПриИзменении(Элемент)	
	ВсегоСтудентов = ТЧГруппы.Итог("КСтудентов");	
	Если ВсегоСтудентов > АудВместимость Тогда 
		Элементы.ВсегоСтудентов.ЦветТекста = Новый Цвет(255, 0, 0);
	Иначе
		Элементы.ВсегоСтудентов.ЦветТекста = Новый Цвет(0, 0, 0);
	КонецЕсли; 	
КонецПроцедуры  

&НаКлиенте
Процедура ТЧГруппыГруппаПриИзменении(Элемент)   
	Группа = Элементы.ТЧГруппы.ТекущиеДанные.Группа; 
	Студенты = ПолучитьКолвоСтудентов(Группа);
	Элементы.ТЧГруппы.ТекущиеДанные.КСтудентов = Студенты; 	
КонецПроцедуры    

&НаКлиенте
Процедура ТЧГруппыГруппаОбработкаВыбора(Элемент, ВыбранноеЗначение, ДополнительныеДанные, СтандартнаяОбработка)
	Для каждого Строка из ТЧГруппы Цикл
		Если Строка.Группа = ВыбранноеЗначение Тогда
			Предупреждение("Данная группа уже есть в списке!");
			СтандартнаяОбработка = ложь;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте  
Функция СформироватьСтрокуГрупп()
	Группы = "";
	Для каждого Строка из ТЧГруппы Цикл
		Группы = Строка(Группы) + " " + Строка.Группа;
	КонецЦикла; 
	Возврат Группы;
КонецФункции

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	Запись.Группы = СформироватьСтрокуГрупп();
	Если не ЗначениеЗаполнено(Запись.Код) Тогда
		Значение = ПолучитьМаксимальныйКодРасписания() + 1;
		Запись.Код = Значение; 
	КонецЕсли; 
	
	Если ВсегоСтудентов > АудВместимость Тогда
		ТекстВопроса = "Все студенты выбранных групп не поместятся в этой аудитории. Продолжить?";
		Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Если Ответ = КодВозвратаДиалога.Нет Тогда
			Отказ = Истина;
		КонецЕсли; 
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ) 	
	МассивГрупп = СтрРазделить(Запись.Группы, " ", Ложь);
	Если МассивГрупп.Количество() <> 0 Тогда
		Для каждого Значение из МассивГрупп Цикл
			СтрокаГруппа = ТЧГруппы.Добавить();
			СтрокаГруппа.Группа = ПолучитьСсылкуНаГруппу(Значение);
			СтрокаГруппа.КСтудентов = ПолучитьКолвоСтудентов(Значение);
		КонецЦикла;
	КонецЕсли;  
	
	Если ЗначениеЗаполнено(Запись.Аудитория) Тогда
		АудВместимость = ПолучитьКолвоМестАудитории(Запись.Аудитория); 
	КонецЕсли;
	
	ВсегоСтудентов = ТЧГруппы.Итог("КСтудентов");
	
КонецПроцедуры    

&НаКлиенте
Процедура ВсегоСтудентовПриИзменении(Элемент)
КонецПроцедуры


