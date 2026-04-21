---- Типы JOIN ----
-- LEFT JOIN		(LEFT OUTER JOIN)
-- RIGHT JOIN		(RIGHT OUTER JOIN)
-- JOIN				(INNER JOIN)
-- FULL JOIN		(FULL OUTER JOIN)
-- CROSS JOIN		(CROSS OUTER JOIN)


--SELECT *
--FROM employees, departments;



-- ========== LEFT JOIN
SELECT *
FROM 
	employees e LEFT JOIN departments d ON e.department_id = d.id;

SELECT *
FROM 
	 departments d LEFT JOIN employees e ON e.department_id = d.id;


-- ========== RIGHT JOIN
SELECT *
FROM 
	employees e RIGHT JOIN departments d ON e.department_id = d.id;

SELECT *
FROM 
	 departments d RIGHT JOIN employees e ON e.department_id = d.id;



-- ========== JOIN
SELECT *
FROM 
	employees e JOIN departments d ON e.department_id = d.id;

SELECT *
FROM 
	 departments d JOIN employees e ON e.department_id = d.id;



-- ========== FULL JOIN
SELECT *
FROM 
	employees e FULL JOIN departments d ON e.department_id = d.id;

SELECT *
FROM 
	 departments d FULL JOIN employees e ON e.department_id = d.id;




-- ========== CROSS JOIN
SELECT *
FROM 
	employees e CROSS JOIN departments d;

SELECT *
FROM 
	 departments d CROSS JOIN employees e;



---------------------------------
-- TASK
-- Вернуть кол-во сотрудников по всем должностям
-- |position_name|count|

SELECT
	p.title,
	COUNT(e.id)
FROM positions p LEFT JOIN employees e ON e.position_id = p.id
GROUP BY p.title, p.id



----------------------
-- TASK
-- Вернуть служащих, которые родились в 1982 с информацией об их должности и отделе
-- |emp_id|emp_name|emp_birthday|position|department|

-- employees, departments, positions


SELECT
	e.id,
	e.name,
	e.birthday,
	ISNULL(p.title, '---')			AS [Position],
	ISNULL(d.title, '---')			AS [Department]
FROM employees e 
	LEFT JOIN positions p ON e.position_id = p.id
	LEFT JOIN departments d ON e.department_id = d.id
WHERE YEAR(e.birthday) = 1982
ORDER BY birthday DESC



------------------------
-- TASK
-- Для каждого отдела вывести последнюю дату приёма сотрудника
-- |department|hire_date|


SELECT
	d.title,
	ISNULL(CONVERT(varchar(16), MAX(e.hire_date), 104), '---') AS [hire_date]
FROM departments d LEFT JOIN employees e ON e.department_id = d.id
GROUP BY d.title, d.id



------------------------
-- TASK
-- Для каждого отдела вывести последнего принятого сотрудника
-- |department|name|

SELECT
	d.title,
	MAX(IIF(e.hire_date = MAX(e.hire_date), e.name, ''))
FROM departments d LEFT JOIN employees e ON e.department_id = d.id
GROUP BY d.title, d.id
	


SELECT
	d.id,
	d.title,
	ISNULL(e.name, '')
FROM employees e
	JOIN (
			SELECT
				MAX(id) maxEmpId					-- :-((( Анализировать нужно hire_date
			FROM employees
			GROUP BY department_id
		) lastEmp ON e.id = lastEmp.maxEmpId
	RIGHT JOIN departments d ON e.department_id = d.id;



-- TASK
-- Посчитать кол-во сотрудников по каждому отделу для каждой должности
-- |department|position|count|

SELECT
	dep.title AS [Department],
	pos.title AS [Position],
	COUNT(emp.id) AS [Count]
FROM
	departments dep
	CROSS JOIN positions pos
	LEFT JOIN employees emp ON emp.position_id = pos.id AND emp.department_id = dep.id
GROUP BY dep.id, dep.title, pos.id, pos.title
