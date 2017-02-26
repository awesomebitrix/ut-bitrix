﻿
#Область ПроцедурыИФункцииПоРаботеСHTTP

// Функция - получает настройки прокси
//
// Параметры:
//  НастройкаПроксиСервера	 - 	 Настройки прокси сервера 
//  Протокол				 - 	 Протокол "https" или "http" 
// Возвращаемое значение:
//   Прокси. Если не удается, то Неопределено 
Функция ПолучитьПрокси(НастройкаПроксиСервера, Протокол) Экспорт
	
	Если НастройкаПроксиСервера <> Неопределено Тогда
		ИспользоватьПрокси = НастройкаПроксиСервера.Получить("ИспользоватьПрокси");
		ИспользоватьСистемныеНастройки = НастройкаПроксиСервера.Получить("ИспользоватьСистемныеНастройки");
		Если ИспользоватьПрокси Тогда
			Если ИспользоватьСистемныеНастройки Тогда
				// Системные настройки прокси-сервера
				Прокси = Новый ИнтернетПрокси(Истина);
			Иначе
				// Ручные настройки прокси-сервера
				Прокси = Новый ИнтернетПрокси;
				Прокси.Установить(Протокол, НастройкаПроксиСервера["Сервер"], НастройкаПроксиСервера["Порт"]);
				Прокси.НеИспользоватьПроксиДляЛокальныхАдресов = НастройкаПроксиСервера["НеИспользоватьПроксиДляЛокальныхАдресов"];
				Прокси.Пользователь = НастройкаПроксиСервера["Пользователь"];
				Прокси.Пароль       = НастройкаПроксиСервера["Пароль"];
			КонецЕсли;
		Иначе
			// Не использовать прокси-сервер	
			Прокси = Новый ИнтернетПрокси(Ложь);
		КонецЕсли;
	Иначе
		Прокси = Неопределено;
	КонецЕсли;
	
	Возврат Прокси;
	
КонецФункции

#КонецОбласти


#Область ПроверкаВерсий

Функция ПолучитьСлужебноеНазваниеКонфигурации() Экспорт
	
	Возврат "UT 11";
	
КонецФункции
Функция ПолучитьЛокализациюКонфигурации() Экспорт
	//UKR
	//BEL
	//KAZ
	Возврат "RUS";
	
КонецФункции

Функция РазобратьФайлСАктуальнымиВерсиямиМодулей(ИмяФайла) Экспорт
	
	ТзнВерсииМодулей = Новый ТаблицаЗначений;
	ТзнВерсииМодулей.Колонки.Добавить("НаименованиеКонфигурации");
	ТзнВерсииМодулей.Колонки.Добавить("РелизКонфигурации");
	ТзнВерсииМодулей.Колонки.Добавить("НаименованиеМодуля");
	ТзнВерсииМодулей.Колонки.Добавить("ВерсияМодуля");
	ТзнВерсииМодулей.Колонки.Добавить("Локализация");
	ТзнВерсииМодулей.Колонки.Добавить("Ссылка");
	ТзнВерсииМодулей.Колонки.Добавить("История");
		
	Чтение = новый ЧтениеXML;
	Чтение.ОткрытьФайл(сокрЛП(ИмяФайла));
	Modules 		= Ложь;
	Location        = Ложь;
	Link       		= Ложь;
	Module 	 		= Ложь;
	Name1C 			= Ложь;
	Version1C 		= Ложь;
	NameModule 		= Ложь;
	VersionModule 	= Ложь;
	
	History 		= Ложь;
	HModule 		= Ложь;
	HVersionModule 	= Ложь;
	HDescriptions 	= Ложь;

	Пока Чтение.Прочитать() Цикл
		
		Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И НЕ History И Чтение.Имя = "Modules" Тогда
			Modules = Истина;
		ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И НЕ History И Чтение.Имя = "Modules" тогда
			Modules = Ложь;
		КонецЕсли;
		
		Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И НЕ History И Чтение.Имя = "Module" И Modules Тогда
			Module = Истина;
			НовСтрока = ТзнВерсииМодулей.Добавить();
		ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И НЕ History И Чтение.Имя = "Module" И Modules Тогда 	
			Module = Ложь;
		КонецЕсли;
		
		Если Modules И Module И НЕ History тогда
			
			Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя = "Name1C" Тогда
				Name1C = Истина;
			ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "Name1C" тогда
				Name1C = Ложь;
			КонецЕсли;
			
			Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя = "Version1C" Тогда
				Version1C = Истина;
			ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "Version1C" тогда
				Version1C = Ложь;
			КонецЕсли;
			
			Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя = "NameModule" Тогда
				NameModule = Истина;
			ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "NameModule" тогда
				NameModule = Ложь;
			КонецЕсли;
			
			Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя 	= "VersionModule" Тогда
				VersionModule = Истина;
			ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "VersionModule" тогда
				VersionModule = Ложь;
			КонецЕсли;
			
			Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя 	= "Location" Тогда
				Location = Истина;
			ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "Location" тогда
				Location = Ложь;
			КонецЕсли;
			
			Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя 	= "Link" Тогда
				Link = Истина;
			ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "Link" тогда
				Link = Ложь;
			КонецЕсли;
			
			Если Name1C И Чтение.Имя = "#text" тогда
				НовСтрока.НаименованиеКонфигурации = Чтение.Значение;
			КонецЕсли;
			
			Если Version1C И Чтение.Имя = "#text" тогда
				НовСтрока.РелизКонфигурации = Чтение.Значение;
			КонецЕсли;
			
			Если NameModule И Чтение.Имя = "#text" тогда
				НовСтрока.НаименованиеМодуля = Чтение.Значение;
			КонецЕсли;
			
			Если VersionModule И Чтение.Имя = "#text" тогда
				НовСтрока.ВерсияМодуля = Чтение.Значение;
			КонецЕсли;
			
			Если Location И Чтение.Имя = "#text" тогда
				НовСтрока.Локализация = Чтение.Значение;
			КонецЕсли;
			
			Если Link И Чтение.Имя = "#text" тогда
				НовСтрока.Ссылка = Чтение.Значение;
			КонецЕсли;
			
		КонецЕсли;
		
		Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя 	= "History" Тогда
			
			History = Истина;
			
			тзнИстории = Новый ТаблицаЗначений;
			тзнИстории.Колонки.Добавить("ВерсияМодуля"); 
			тзнИстории.Колонки.Добавить("Описание"); 
			
		ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "History" тогда
			
			History = Ложь;
			
			НовСтрока.История = тзнИстории;
			
		КонецЕсли;
			
		Если  Modules И Module И History тогда
			
			Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя 	= "Module" Тогда
				
				HModule = Истина;
				
				НовИстрия = тзнИстории.Добавить();	

			ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "Module" тогда
				HModule = Ложь;
			КонецЕсли;
			
			Если  Modules И Module И History И HModule тогда
				
				Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя 	= "VersionModule" Тогда
					HVersionModule = Истина;
				ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "VersionModule" тогда
					HVersionModule = Ложь;
				КонецЕсли;
				
				Если Чтение.ТипУзла = ТипУзлаXML.НачалоЭлемента И Чтение.Имя 	= "Descriptions" Тогда
					HDescriptions = Истина;
				ИначеЕсли Чтение.ТипУзла = ТипУзлаXML.КонецЭлемента И Чтение.Имя = "Descriptions" тогда
					HDescriptions = Ложь;
				КонецЕсли;
				
				Если HVersionModule И Чтение.Имя = "#text" тогда
					НовИстрия.ВерсияМодуля = Чтение.Значение;
				КонецЕсли;
				
				Если HDescriptions И Чтение.Имя = "#text" тогда
					НовИстрия.Описание = Чтение.Значение;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ТзнВерсииМодулей;
	
КонецФункции

Функция РазобратьВерсиюМодуля4(ВерсияМодуля)
		
	СтруктураРазбора = Новый Структура;
	СтруктураРазбора.Вставить("МажорнаяВерсия"	, 0);
	СтруктураРазбора.Вставить("МинорнаяВерсия"	, 0);
	СтруктураРазбора.Вставить("Релиз"			, 0);
	СтруктураРазбора.Вставить("Сборка"			, 0);

	ДлинаВерсии = СтрДлина(ВерсияМодуля);	
	
	Ряд = 1;
	Версия = "";
	Для Пер = 1 по ДлинаВерсии Цикл
		
		Сим = Сред(ВерсияМодуля, Пер,1);
		
		Если Сим = "." тогда
			
			Если Ряд = 1 тогда
				СтруктураРазбора.МажорнаяВерсия = Число(Версия); 	
			ИначеЕсли Ряд = 2 тогда
				СтруктураРазбора.МинорнаяВерсия = Число(Версия); 	
			ИначеЕсли Ряд = 3 тогда
				СтруктураРазбора.Релиз 			= Число(Версия); 	
			КонецЕсли;
			
			Ряд 	= Ряд + 1;
			Версия 	= "";
			
		Иначе
			Версия 	= Версия + Сим;	
			
			Если Пер = ДлинаВерсии тогда
				СтруктураРазбора.Сборка 		= Число(Версия); 	
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат СтруктураРазбора;
	
КонецФункции

Функция ПроверитьАктуальностьТекущегоМодуля4(ВерсияТекущегоМодуля, ВерсияАктуальногоМодуля) Экспорт
	
	Результат = Истина;
	
	РазобранаяВерсияТекущегоМодуля 		= РазобратьВерсиюМодуля4(ВерсияТекущегоМодуля);
	РазобранаяВерсияАктуальногоМодуля 	= РазобратьВерсиюМодуля4(ВерсияАктуальногоМодуля);
	
	Если  РазобранаяВерсияТекущегоМодуля.МажорнаяВерсия < РазобранаяВерсияАктуальногоМодуля.МажорнаяВерсия тогда
		Результат = Ложь;
	ИначеЕсли РазобранаяВерсияТекущегоМодуля.МажорнаяВерсия = РазобранаяВерсияАктуальногоМодуля.МажорнаяВерсия тогда
		
		Если  РазобранаяВерсияТекущегоМодуля.МинорнаяВерсия < РазобранаяВерсияАктуальногоМодуля.МинорнаяВерсия тогда
			Результат = Ложь;	
		ИначеЕсли  РазобранаяВерсияТекущегоМодуля.МинорнаяВерсия = РазобранаяВерсияАктуальногоМодуля.МинорнаяВерсия тогда

			Если  РазобранаяВерсияТекущегоМодуля.Релиз < РазобранаяВерсияАктуальногоМодуля.Релиз тогда
				Результат = Ложь;	
			ИначеЕсли  РазобранаяВерсияТекущегоМодуля.Релиз = РазобранаяВерсияАктуальногоМодуля.Релиз тогда
				Если  РазобранаяВерсияТекущегоМодуля.Сборка < РазобранаяВерсияАктуальногоМодуля.Сборка тогда
					Результат = Ложь;	
				КонецЕсли;	
			КонецЕсли;	
		КонецЕсли;	
	КонецЕсли;	
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область ПрочиеПроцедурыИФункции

// Процедура - отображает состояние
//
// Параметры:
//  ТекстСостояния	-  Строка, предназначенная для вывода в панель состояния. Если параметр не указан, возобновляется вывод системного текста в панель состояния. 
Процедура ОтображениеСостояния(ТекстСостояния) Экспорт
	
	#Если Клиент Тогда
		Состояние(ТекстСостояния);
	#КонецЕсли
	
КонецПроцедуры

Функция ПолучитьРеквизитОбъекта(Объект, НазваниеРеквизита) Экспорт
	
	Возврат Объект[НазваниеРеквизита]; 
	
КонецФункции

Функция ПолучитьПредопределенныйИдОбъекта(ИдОбъекта) Экспорт  //язык проверяем отдельно, т.к. есть ситуции, когда локализация не поможет
	
	Локализация = ПолучитьЛокализациюКонфигурации();
	
	Если ИдОбъекта = "ИдСвойстваФискальныйПризнак" и Локализация = "RUS" тогда
		Результат = "FISCAL_SIGN";	
	ИначеЕсли ИдОбъекта = "ИдСвойствАдресСайта" и Локализация = "RUS" тогда
		Результат = "URL";	
	ИначеЕсли ИдОбъекта = "ИдСвойствРегНомерККТ" и Локализация = "RUS" тогда
		Результат = "REG_NUMBER_KKT";	
	ИначеЕсли ИдОбъекта = "ИдСвойствПечатьЧека" и Локализация = "RUS" тогда
		Результат = "PRINT_CHECK";	
	Иначе
		Результат = "";	
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции


#КонецОбласти

#Область ПроцедурыИФункцииПоРаботеСФС

// Функция - возвращает путь к файлам/папкам, в звависимости от ОС
//
// Параметры:
//  ПлатформаWindows - 	 Признак того, что эта ОС - Windows 
//  Путь			 - 	 Адрес к файлу/папке 
// Возвращаемое значение:
//   Адрес к файлу/папке 
Функция ПолучитьПутьДляПлатформы(ПлатформаWindows, Путь) Экспорт
	
	Если ПлатформаWindows Тогда
		ЧтоМенять = "/";
		НаЧтоМенять = "\";
	Иначе
		ЧтоМенять = "\";
		НаЧтоМенять = "/";
	КонецЕсли;
	
	Путь = СтрЗаменить(Путь, ЧтоМенять, НаЧтоМенять);
	
	Возврат Путь;
	
КонецФункции

// Функция - проверяет, существует ли указанный файл
//
// Параметры:
//  ИмяФайла - 	 Имя проверяемого файла 
// Возвращаемое значение:
//   Истина, если файл существует 
Функция СуществуетФайл(ИмяФайла) Экспорт
	
	ВыбФайл = Новый Файл(ИмяФайла);
	Если ВыбФайл.Существует() Тогда  
		Возврат Истина;
	Иначе   
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

// Функция - очищает содержимое каталога 
//
// Параметры:
//  Каталог			 - 	 Каталог, в котором очищаются файлы 
//  ПараметрыОбмена	 - 	 Настройки узла обмена  
// Возвращаемое значение:
//   Истина, если каталог очищен 
Функция КаталогОчищен(Каталог) Экспорт
	
	Попытка		
		УдалитьФайлы(Каталог, "*.*");
		Возврат Истина;
	Исключение
		Сообщить("Не удалось очистить каталог обмена: (" + Каталог + ")");			
		Возврат Ложь;		
	КонецПопытки;
	
КонецФункции

#КонецОбласти