

SELECT
	id,
	last_name,
	first_name,
	salary,
	department_id
FROM employees
WHERE department_id = 3
ORDER BY last_name, first_name, id




-- Вывести информацию о пользователях из it отдела с их абсолютным выражением бонуса
SELECT
	id,
	email,
	ISNULL(salary, 0) / 100 * bonus_percent   AS [amount]
FROM employees
-- WHERE (bonus_percent >= 0 AND bonus_percent IS NOT NULL)
-- WHERE (NOT(bonus_percent < 0 OR bonus_percent IS NULL))
WHERE (ISNULL(bonus_percent, 0) <> 0 AND bonus_percent >= 0)
	AND department_id = 3
ORDER BY amount DESC;


-- =========== BETWEEN IN LIKE =============

-- SELECT id, name, salary
-- FROM employees

-- WHERE salary >= 2000 AND salary <= 3000
-- WHERE salary BETWEEN 2000 AND 3000

--	WHERE salary BETWEEN 2000 AND 3000
--	AND department_id = 3

-- WHERE department_id = 3 OR department_id = 4
-- WHERE department_id IN (3, 4)
-- WHERE department_id NOT IN (3, 4)

-- WHERE department_id IN (3, 4, NULL)								-- :-(((
-- WHERE department_id IN (3, 4) OR department_id IS NULL			-- :-)))
-- WHERE ISNULL(department_id, -1) IN (3, 4, -1)					-- :-)



-- %	_	[abc]	[^abc]		[a-c]	[^a-c]
-- SELECT id, name, salary
-- FROM employees
-- -- WHERE name LIKE N'Сид%'
-- -- WHERE last_name LIKE N'%ов';
-- -- WHERE last_name LIKE N'%ре%';
-- -- WHERE email LIKE '%.com';
-- -- WHERE email LIKE '%.c__';
-- -- WHERE email LIKE '%.[cbr]__';
-- -- WHERE email LIKE '%.[^a-c]__';
-- -- WHERE email LIKE '%.!%__' ESCAPE '!'
 
--WHERE LOWER(email) LIKE '%.pro';				-- :-)





-- ============= DATE / TIME functions =========== --

DECLARE @year int = 1982;

SELECT *
FROM employees
WHERE YEAR(birthday) = @year;


-- Отобрать пользователей, у которых сегодня др
DECLARE @now datetime = GETDATE();

SELECT *
FROM employees
WHERE MONTH(birthday) = MONTH(@now) AND DAY(birthday) = DAY(@now);



DECLARE @d date = '20260409';
-- SELECT @d;
SELECT DATEDIFF(year, @d, GETDATE());

-- Вывести возраст служащих
SELECT
	id,
	name,
	DATEDIFF(year, birthday, GETDATE()) AS [age]
FROM employees;



SELECT CONVERT(DATE, '20260409', 104);

