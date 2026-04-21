
---- TASK

---- Посчитать кол-во сотрудников по всем должностям
--SELECT
--	p.title,
--	COUNT(e.id) AS [Count]
--FROM
--	positions p LEFT JOIN employees e ON e.position_id = p.id
--GROUP BY p.id, p.title



--SELECT
--	p.title,
--	(
--		SELECT COUNT(id)
--		FROM employees e
--		WHERE e.position_id = p.id
--	) AS [Count]
--FROM
--	positions p;



-- EXISTS / NOT EXISTS
-- TASK
-- Показать пользователей, которые создавали альбомы

SELECT DISTINCT
	u.id,
	u.nickname
FROM albums a
	LEFT JOIN users u ON a.user_id = u.id



SELECT
	u.id, 
	u.nickname
FROM albums a
	LEFT JOIN users u ON a.user_id = u.id
GROUP BY u.id, u.nickname




SELECT
	u.nickname
FROM users u
WHERE EXISTS (
	SELECT u.id
	FROM albums a
	WHERE a.user_id = u.id
);




-- Показать пользователей, которые не создавали альбомы
SELECT
	u.nickname
FROM users u
WHERE NOT EXISTS (
	SELECT u.id
	FROM albums a
	WHERE a.user_id = u.id
);




-- TASK
-- Показать пользователей, у которых больше 1 альбома (2 и более)

SELECT
	u.nickname
FROM
	users u
WHERE (
	SELECT COUNT(a.id)
	FROM albums a
	WHERE a.user_id = u.id
) > 1;



-- Ради тренировки

SELECT
	u.nickname
FROM users u
WHERE EXISTS (
	SELECT a.user_id
	FROM albums a
	WHERE a.user_id = u.id
	GROUP BY a.user_id
	HAVING COUNT(a.user_id) > 1
);




-- ALL / ANY / IN

-- TASK
-- Вывести пользователей, у которых есть альбомы с рейтингом 5

SELECT
	u.id, u.email
FROM users u
WHERE EXISTS (
	SELECT a.id
	FROM albums a
	WHERE a.user_id = u.id AND a.rate = 5
);



SELECT
	u.id, u.email
FROM users u
WHERE u.id IN (
	SELECT a.user_id
	FROM albums a
	WHERE a.rate = 5
);




SELECT
	u.id, u.email
FROM users u
WHERE u.id = ANY (
	SELECT a.user_id
	FROM albums a
	WHERE a.rate = 5
);




-- TASK
-- Для каждого отдела выбрать сотрудника,
-- у которого ЗП больше, чем ЗП каждого сотрудника этого отдела


-- TODO ???
--SELECT
--	d.id,
--	d.title,
--	MAX(e.salary)
--FROM departments d
--	LEFT JOIN employees e ON e.department_id = d.id
--GROUP BY 
--	d.id, d.title




--SELECT
--	dep.title,
--	ISNULL(emp.name, '---'),
--	ISNULL(emp.salary, 0)
--FROM departments dep
--	LEFT JOIN employees emp ON emp.department_id = dep.id
--WHERE emp.salary > ALL (
--	SELECT e.salary
--	FROM employees e
--	WHERE e.id <> emp.id
--		AND e.department_id = emp.department_id
--		AND e.salary IS NOT NULL
--)

