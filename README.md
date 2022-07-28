# Novosoft_sql_task

Результаты по выполнению тестового задания на должность
"Программист / разработчик баз данных" в компанию "Novosoft"

Решение применимо для СУБД PostgreSQL

## Task 1

Существуют таблицы, в которых хранятся данные о товарах в документах:

**Docs:**
|doc_code|doc_num|In_out_flag|state|Modified_Date|
|-|-|-|-|-|
|Код документа|Номер документа|0 - расход, 1 - приход|Состояние: 0 - черновик, 1 - Исполняется|Дата изменения состояния|

**goods:**
|doc_cod|Good_cod|Qty|Price|
|-|-|-|-|
|Код документа|Код товара|Количество|Цена|

Необходимо сформировать одним SQL запросом баланс по всем товарам с группировкой по каждому товару. Баланс  есть (сумма прихода по товару) - (сумма расхода по товару) в денежном выражении. Желательно без подзапросов.

## Solution for task 1


```sql
select Good_code, sum(  case docs.In_out_flag 
                        when 1 then qte * price 
                        when 0 then qte * price * (-1) 
                        end)
from goods
join docs using(doc_cod)
where docs.state= true
group by goods.Good_code;
```

## Task 2

Написать функцию с тремя числовыми опциональными параметрами (каждый из них по умолчанию=null), возвращающую значение минимального из непустых параметров (без использования функции nvl, decode, coalesce). 

**Function min3(pVal1 number:=null, pVal2 number:=null, pVal3 number:=null) return number;**

## Solution for task 2

```sql
CREATE OR REPLACE FUNCTION min3( pVal1 numeric DEFAULT null, pVal2 numeric DEFAULT null, pVal3 numeric DEFAULT null) 
	RETURNS numeric 
	AS 'select least(pVal1, pVal2, pVal3);'
    LANGUAGE SQL;
```

## Task 3

Таблицы:

* visits - посещения пациентов к врачам:
	+ id(число) ~ уникальный идентификатор;
	+ employer_id(число) ~ внешний ключ из таблицы employers;
    + visit_date(дата) ~ дата посещения;
    + lpu_id(число) ~ внешний ключ из таблицы lpu;
    + cablab_id(число) ~ внешний ключ из таблицы cablab;
* cablabs - кабинет:
    + id(число) ~ уникальный идентификатор;
    + name(строка) ~ название кабинета;
* divisions - подразделения ЛПУ:
    + id(число) ~ уникальный идентификатор;
    + code(строка) ~ код подразделения;
    + name(строка) ~ название подразделения;
    + lpu_id(число) ~ внешний ключ из таблицы lpu;
* lpu - лечебно-профилактическое учреждение:
    + id(число) ~ уникальный идентификатор;
    + name(строка) ~ название ЛПУ;
* employers - работники ЛПУ:
    + id(число) ~ уникальный идентификатор;
    + firstname(строка) ~ имя;
    + lastname(строка) ~ фамилия;
    + middlename(строка) ~ отчество;

Схема базы данных:

![схема](/pics/scheme.png)


Вывести название кабинетов, в которых суммарное число оказанных приемов максимально.

## Solution for task 3

```sql
select t1.name "Название кабинета", t1.count_visits "Суммарное число оказанных приемов" 
from (	select cablabs.name as name, count(visits.id) as  count_visits
		from cablabs
		join visits on visits.cablab_id = cablabs.id
	  	group by cablabs.id
		) as t1
where t1.count_visits = (select max(t1.count_visits) from t1);
``` 

## Для загрузки файлов

Файлы с кодом расположены в каталоге code_files этого проекта.

Для загрузки проекта используем:

`git clone https://github.com/SergeyVlK/Novosoft_sql_task.git`