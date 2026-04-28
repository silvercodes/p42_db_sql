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




