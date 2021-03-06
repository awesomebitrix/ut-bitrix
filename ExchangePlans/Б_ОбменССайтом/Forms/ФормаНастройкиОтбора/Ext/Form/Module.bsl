﻿#Область ОбработчикиСобытийФормы

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПриЧтенииСозданииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()

	ИнициализироватьКомпоновщикСервер();
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьКомпоновщикСервер()
	
	СхемаВыгрузкиТоваров = ПланыОбмена.Б_ОбменССайтом.ПолучитьМакет("СхемаВыгрузкиТоваров");
	АдресСхемы = ПоместитьВоВременноеХранилище(СхемаВыгрузкиТоваров, УникальныйИдентификатор);
	КомпоновщикНастроекКомпоновкиДанных.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемы)); 
	
	Если Параметры.НастройкаКомпоновки = НеОпределено Тогда
		КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(СхемаВыгрузкиТоваров.НастройкиПоУмолчанию);
	Иначе
		КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(Параметры.НастройкаКомпоновки);
		КомпоновщикНастроекКомпоновкиДанных.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	Закрыть(ПолучитьНастройкиКомпоновкиСервер());
	
КонецПроцедуры

&НаСервере
Функция ПолучитьНастройкиКомпоновкиСервер()
	Возврат КомпоновщикНастроекКомпоновкиДанных.ПолучитьНастройки();
КонецФункции

#КонецОбласти
