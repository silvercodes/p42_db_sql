-- 1 form
--CASE
--	WHEN <condition_1> THEN <value_1>
--	...
--	WHEN <condition_n> THEN <value_n>

--	[ELSE <default_value>]
--END

-- 2 form
--CASE <value>
--	WHEN <case_value> THEN <value_1>
--	...
--	WHEN <case_value> THEN <value_n>

--	[ELSE default_value]
--END

-- 3 IIF
-- IIF(<condition>, <value_if_true>, <value_if_false>)



-- |email|salary|evaluation|

--SELECT
--	email AS [Email],
--	salary AS [Salary],
--	CASE
--		WHEN salary >= 3000 THEN 'salary >= 3000'
--		WHEN salary >= 2000 THEN 'salary >= 2000'
--		ELSE 'salary < 2000'
--	END AS [Evaluation_1],
--	CASE
--		WHEN salary >= 3000 THEN 'salary >= 3000'
--		WHEN salary >= 2000 THEN 'salary >= 2000'
--	END AS [Evaluation_2]
--FROM employees;




-- Расчитать размер премии по принципу: it(30%), accounting(10%), other(5%)
-- |id|name|salary|department_id|percent|amount|

SELECT
	id, 
	name, 
	salary, 
	department_id,
	CASE department_id
		WHEN 3 THEN '30%'
		WHEN 2 THEN '10%'
		ELSE '5%'
	END AS [Percent],
	ISNULL(salary, 0) / 100 *
		CASE department_id
			WHEN 3 THEN 30
			WHEN 2 THEN 10
			ELSE 5
		END AS [Amount]
FROM employees





SELECT
	id, email, salary,
	IIF(salary >= 2500, 'OK', 'not OK'),
	CASE WHEN salary >= 2500 THEN 'OK' ELSE 'not OK' END
FROM employees





SELECT
	id, name, email,

	CASE
		WHEN department_id IN (1, 2) THEN 'A'
		WHEN department_id = 3 THEN
			CASE position_id
				WHEN 3 THEN 'B-1'
				WHEN 4 THEN 'B-2'
			END
		ELSE 'C'
	END

FROM employees



-- Отсортировать сотрудников по приоритету получения ЗП
-- <= 2500
-- > 2500
-- Отсортировать в каждой "группе" (части списка) по полю name

SELECT
	id, name, salary
FROM
	employees
ORDER BY
	CASE WHEN salary <= 2500 THEN 'A' ELSE 'B' END,
	name;



SELECT
	id, name, salary,
	CASE WHEN salary <= 2500 THEN 'A' ELSE 'B' END
FROM
	employees
ORDER BY
	CASE WHEN salary <= 2500 THEN 'A' ELSE 'B' END,
	name;






