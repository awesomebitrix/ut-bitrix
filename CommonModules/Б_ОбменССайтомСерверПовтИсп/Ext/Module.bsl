﻿
// Функция - Возвращает массив узлов обмена с сайтом с отбором по назначению 
//
// Параметры:
//  ВыбиратьУзлыОбменаТоварами	 - 	 Признак указывающий, что выбираются узлы выгружаемые товар 
//  ВыбиратьУзлыОбменаЗаказами	 - 	 Признак указывающий, что выбираются узлы обмена заказов 
//
// Возвращаемое значение:
//   -  Массив узлов обмена с сайтом 
//
Функция ПолучитьМассивУзловДляРегистрации(ВыбиратьУзлыОбменаТоварами = Ложь, ВыбиратьУзлыОбменаЗаказами = Ложь) Экспорт
	
Запрос = Новый Запрос;
   Запрос.Текст = 
   "ВЫБРАТЬ
   |   ПланОбмена.Ссылка
   |ИЗ
   |   ПланОбмена.Б_ОбменССайтом КАК ПланОбмена
   |ГДЕ
   |   (ПланОбмена.ОбменТоварами = &ВыбиратьУзлыОбменаТоварами
   |         ИЛИ ПланОбмена.ОбменДокументами = &ВыбиратьУзлыОбменаЗаказами)
   |   И НЕ ПланОбмена.ЭтотУзел";
   Запрос.УстановитьПараметр("ВыбиратьУзлыОбменаТоварами",ВыбиратьУзлыОбменаТоварами);
   Запрос.Установитьпараметр("ВыбиратьУзлыОбменаЗаказами",ВыбиратьУзлыОбменаЗаказами);
   МассивУзлов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
   
   Возврат МассивУзлов;
	
КонецФункции
