
SELECT
	'const_string',
	COUNT(*)							AS [Общее кол-во строк],
	COUNT(id)							AS [Кол-во не NULL id],
	COUNT(DISTINCT department_id)		AS [Кол-во не NULL уникальных department_id]
FROM employees
GROUP BY department_id;



SELECT
	'const_string',
	position_id,
	department_id,
	COUNT(*)							AS [Общее кол-во строк],
	COUNT(id)							AS [Кол-во не NULL id],
	COUNT(DISTINCT department_id)		AS [Кол-во не NULL уникальных department_id]
FROM employees
GROUP BY position_id, department_id;



-- Посчитать кол-во сотрудников, родившихся в одаковые года
SELECT
	YEAR(birthday),
	COUNT(id)
FROM employees
WHERE birthday IS NOT NULL
GROUP BY YEAR(birthday);


-- По каждому отделу посчитать:
-- количество задействованных должностей
-- кол-во сотрудников
-- сумму з/п
-- среднюю з/п
-- |Отдел|Кол-во должностей|Кол-во служащих|Сумма зп|Средняя зп|

SELECT
	CASE department_id
		WHEN 1 THEN 'Administration'
		WHEN 2 THEN 'Accounting'
		WHEN 3 THEN 'IT'
		ELSE 'Other'
	END								AS [Отдел],
	COUNT(DISTINCT position_id)		AS [Кол-во должностей],
	COUNT(id)						AS [Кол-во служащих],						
	SUM(salary)						AS [Сумма зп],
	AVG(salary)						AS [Средняя зп]
FROM employees
GROUP BY department_id






-- Получить сводную таблицу в разрезе отделов
-- Посчитать суммарную зп в разбивке по должностям

--|department		|bookers	|directors	|developers	|teamlieads	|
---------------------------------------------------------------------
--|Administration	|0			|40000		|...
--|Accounting		|17000		|0
--|It				|2500		|0
--...

SELECT
	CASE department_id
		WHEN 1 THEN 'Administration'
		WHEN 2 THEN 'Accounting'
		WHEN 3 THEN 'IT'
		ELSE 'Other'
	END																	AS [Department_name],

	SUM(CASE WHEN position_id = 1 THEN ISNULL(salary, 0) ELSE 0 END)	AS [Bookers],
	SUM(CASE WHEN position_id = 2 THEN ISNULL(salary, 0) ELSE 0 END)	AS [Directors],
	SUM(CASE WHEN position_id = 3 THEN ISNULL(salary, 0) ELSE 0 END)	AS [Developers],
	SUM(CASE WHEN position_id = 4 THEN ISNULL(salary, 0) ELSE 0 END)	AS [Teamleads]

FROM employees
GROUP BY department_id
ORDER BY Department_name DESC




-- ======= HAVING ========

SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 6000;



SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 6000 AND COUNT(id) >= 2;



-- :-(((
SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
GROUP BY department_id
HAVING department_id = 3;


-- :-)))
SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
WHERE department_id = 3
GROUP BY department_id



-- DISTINCT					5
-- TOP						7
-- SELECT				4
-- FROM			0
-- WHERE		1
-- HAVING			3
-- GROUP BY			2
-- ORDER BY					6





