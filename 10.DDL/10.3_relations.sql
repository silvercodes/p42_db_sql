-- ==== One-To-Many ==== --
CREATE TABLE roles (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(64) NOT NULL
);

CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(32) NOT NULL,
	role_id int NULL,

	CONSTRAINT FK_users_role FOREIGN KEY(role_id) REFERENCES roles(id)
);



-- ==== One-To-One ==== --

CREATE TABLE backpacks (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	size tinyint NOT NULL DEFAULT(50)
);

CREATE TABLE units (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(64) NOT NULL,
	backpack_id int UNIQUE NOT NULL,

	CONSTRAINT FK_unit_backpack FOREIGN KEY(backpack_id) REFERENCES backpacks(id)
);

DROP TABLE units;
DROP tABLE backpacks;



CREATE TABLE units (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(64) NOT NULL
);

CREATE TABLE backpacks (
	id int PRIMARY KEY NOT NULL,
	size tinyint NOT NULL DEFAULT(50),

	CONSTRAINT FK_backpack_unit FOREIGN KEY(id) REFERENCES units(id)
);





-- ==== Many-To-Many ==== --
CREATE TABLE teachers (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	name varchar(32) NOT NULL
);

CREATE TABLE groups (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(32) NOT NULL
);

CREATE TABLE group_teacher (
	group_id int NOT NULL,
	teacher_id int NOT NULL,

	CONSTRAINT PK_group_teacher PRIMARY KEY(group_id, teacher_id),

	CONSTRAINT FK_group_teacher_group FOREIGN KEY(group_id) REFERENCES groups(id),
	CONSTRAINT FK_group_teacher_teacher FOREIGN KEY(teacher_id) REFERENCES teachers(id),
);

DROP TABLE group_teacher;
DROP TABLE teachers;
DROP TABLE groups;




CREATE TABLE teachers (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	name varchar(32) NOT NULL
);

CREATE TABLE groups (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(32) NOT NULL
);

CREATE TABLE group_teacher_statuses (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(32) NOT NULL,
	slug varchar(32) UNIQUE NOT NULL,
	comment varchar(128) NULL,
	translit varchar(32) NOT NULL
);

CREATE TABLE group_teacher (
	id int IDENTITY(1,1),
	group_id int NOT NULL,
	teacher_id int NOT NULL,
	start_date date NOT NULL,
	end_date date NULL,
	status_id int NOT NULL
	

	CONSTRAINT PK_group_teacher PRIMARY KEY(id),

	CONSTRAINT UQ_group_teacher UNIQUE(group_id, teacher_id),

	CONSTRAINT FK_group_teacher_group FOREIGN KEY(group_id) REFERENCES groups(id),
	CONSTRAINT FK_group_teacher_teacher FOREIGN KEY(teacher_id) REFERENCES teachers(id),
	CONSTRAINT FK_group_teacher_status FOREIGN KEY(status_id) REFERENCES group_teacher_statuses(id)
);


-- HW
-- Получить информацию об активных группах преподавателя с id = 12


-- =================== Неклассические случаи ====================== --

CREATE TABLE categories (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(64) NOT NULL,
	parent_id int NULL,

	CONSTRAINT FK_categories_parent FOREIGN KEY(parent_id) REFERENCES categories(id)
);

INSERT INTO categories (title, parent_id)
VALUES
	('A1', NULL),
	('A2', NULL),
	('A3', NULL);

INSERT INTO categories (title, parent_id)
VALUES
	('A11', 1),
	('A12', 1),
	('A13', 1);


------------------------------------------------------------------------
DROP TABLE subscribes;
DROP TABLE humans;

CREATE TABLE humans (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	username varchar(64) NOT NULL,
	email varchar(32) UNIQUE NOT NULL,
	age tinyint NULL
);

CREATE TABLE subscribes (
	author_id int NOT NULL,
	subscriber_id int NOT NULL,

	CONSTRAINT PK_subscribes PRIMARY KEY (author_id, subscriber_id),

	CONSTRAINT FK_subscribes_author FOREIGN KEY(author_id) REFERENCES humans(id),
	CONSTRAINT FK_subscribes_subscriber FOREIGN KEY(subscriber_id) REFERENCES humans(id),

	CONSTRAINT CK_self_subscribe CHECK(author_id <> subscriber_id)
);

INSERT INTO humans (username, email, age)
VALUES
	('vasia', 'vasia@mail.com', 23),
	('petya', 'petya@mail.com', 31),
	('dima', 'dima@mail.com', 25),
	('kolya', 'kolya@mail.com', 19)

INSERT INTO subscribes(author_id, subscriber_id)
VALUES
	(1, 2),
	(1, 3),
	(2, 1),
	(3, 1);

