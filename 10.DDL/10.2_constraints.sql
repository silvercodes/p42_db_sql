-- == PRIMARY KEY == --
-- Не допускается NULL + значения уникальны


-- Определение при объявлении столбца
--CREATE TABLE units (
--	id int PRIMARY KEY,
--	title varchar(32)
--);


-- Определение вне объявления столбца
--CREATE TABLE units (
--	id int,
--	title varchar(32),

--	CONSTRAINT PK_units_id PRIMARY KEY(id)
--);


-- Определение вне объявления столбца составного PRIMARY KEY
--CREATE TABLE units (
--	id int,
--	path varchar(256),
--	title varchar(32),

--	CONSTRAINT PK_units_id_path PRIMARY KEY(id, path),
--	--PRIMARY KEY(id, path)
--);



-- Добавление PRIMARY KEY после создания таблицы
--CREATE TABLE units (
--	id int NOT NULL,
--	title varchar(32)
--);

--ALTER TABLE units
--ADD CONSTRAINT PK_units_id PRIMARY KEY(id);


--DROP TABLE units;



-- == FOREIGN KEY == --
-- Допускаются только значения из определённого множества (столбца)

CREATE TABLE roles (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(64) NOT NULL
);

CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(32) NOT NULL,
	role_id int NOT NULL,

	CONSTRAINT FK_users_role FOREIGN KEY(role_id) REFERENCES roles(id)
);

INSERT INTO roles(title)
VALUES
	('admin'),
	('guest'),
	('author');

INSERT INTO users (email, role_id)
VALUES 
	('v@m.c', 3),
	('a@m.c', 1),
	('x@m.c', 3);

-- ERROR
-- INSERT INTO users (email, role_id)
-- VALUES 
--	 ('d@m.c', 333);


DELETE FROM roles
WHERE id = 2;


DROP TABLE users;
DROP TABLE roles;



CREATE TABLE roles (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(64) NOT NULL
);

CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(32) NOT NULL,
	role_id int NOT NULL DEFAULT(2),

	CONSTRAINT FK_users_role FOREIGN KEY(role_id) REFERENCES roles(id)
		-- ON DELETE NO ACTION			-- работает по-умолчанию
		-- ON DELETE CASCADE
		-- ON DELETE SET NULL
		-- ON DELETE SET DEFAULT

		-- ON UPDATE NO ACTION			-- работает по-умолчанию
		-- ON UPDATE CASCADE
		-- ON UPDATE SET NULL
		-- ON UPDATE SET DEFAULT
);

INSERT INTO roles(title)
VALUES
	('admin'),
	('guest'),
	('author');

INSERT INTO users (email, role_id)
VALUES 
	('v@m.c', 3),
	('a@m.c', 1),
	('x@m.c', 3);

DELETE FROM roles
WHERE id = 3;

DROP TABLE users;
DROP TABLE roles;






CREATE TABLE roles (
	id int PRIMARY KEY NOT NULL,
	title varchar(64) NOT NULL
);

CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(32) NOT NULL,
	role_id int NOT NULL,

	CONSTRAINT FK_users_role FOREIGN KEY(role_id) REFERENCES roles(id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);

INSERT INTO roles(id, title)
VALUES
	(1, 'admin'),
	(2, 'guest'),
	(3, 'author');

INSERT INTO users (email, role_id)
VALUES 
	('v@m.c', 3),
	('a@m.c', 1),
	('x@m.c', 3);

UPDATE roles
SET id = 333
WHERE id = 3;


DROP TABLE users;
DROP TABLE roles;






-- == NOT NULL == ---
-- Отсутствие значений NULL

CREATE TABLE permissions (
	id int PRIMARY KEY IDENTITY(1,1)	NOT NULL,
	title varchar(32)					NOT NULL,
	description varchar(128)			NULL
);

INSERT INTO permissions (title)
VALUES('read_config');

-- Добавление
UPDATE permissions
SET description = 'no_description'
WHERE description IS NULL;

ALTER TABLE permissions
ALTER COLUMN description varchar(128) NOT NULL;

-- Удаление
ALTER TABLE permissions
ALTER COLUMN description varchar(128) NULL;


DROP TABLE permissions;





-- == UNIQUE == --
-- Не допускает дубликатов

CREATE TABLE roles (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(64) NOT NULL
);

CREATE TABLE users (
	id int IDENTITY(1,1)		NOT NULL,
	email varchar(32)			NOT NULL,
	role_id int					NOT NULL,
	username varchar(64)		NOT NULL,

	CONSTRAINT PK_users_id		PRIMARY KEY(id),
	CONSTRAINT FK_users_role	FOREIGN KEY(role_id) REFERENCES roles(id),
	CONSTRAINT UQ_users_email	UNIQUE(email)
);

-- Добавление
ALTER TABLE roles
ADD CONSTRAINT UQ_roles_title UNIQUE(title);

-- Удаление
ALTER TABLE roles
DROP CONSTRAINT UQ_roles_title;





-- == CHECK == --

CREATE TABLE products (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(128) NOT NULL,

	-- price decimal(10,2) CHECK(price > 0)

	price decimal(10,2),

	CONSTRAINT CK_products_price CHECK(price > 0)
);

DROP TABLE products;


CREATE TABLE products (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(128) NOT NULL,

	-- price decimal(10,2) CHECK(price > 0)

	price decimal(10,2) NOT NULL,
	discount_price decimal(10,2) NOT NULL,

	CONSTRAINT CK_products_price CHECK(price > 0),
	CONSTRAINT CK_products_discount_price
		CHECK(discount_price > 0 AND discount_price < price)
);

