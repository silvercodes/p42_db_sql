
-- group
-- student
-- teacher
-- pair             <--------
-- homework
-- subject
-- grade
-- event
-- user
--..........






CREATE TABLE schedule_items (
    id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    number tinyint NOT NULL,
    item_start time NOT NULL,
    item_end time NOT NULL,
    status tinyint DEFAULT(0) NOT NULL
);

CREATE TABLE subjects (
    id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    title nvarchar(256) NOT NULL,
    deleted_at datetime NULL
);

CREATE TABLE groups (
    id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    title nvarchar(128) NOT NULL,
    status tinyint DEFAULT(0) NOT NULL
    --- TODO...
);

-- TODO: HW
-- roles
-- permissions
-- role_user
-- permission_user
-- permission_role


CREATE TABLE users (
    id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    email varchar(32) UNIQUE NOT NULL,
    hash char(256) NOT NULL,
    deleted_at datetime NULL
    -- TODO roles vs permissions
);

CREATE TABLE teachers (
    id int PRIMARY KEY NOT NULL,
    first_name nvarchar(32) NOT NULL,
    last_name nvarchar(32) NOT NULL,
    -- ......

    CONSTRAINT FK_teacher_user FOREIGN KEY (id) REFERENCES users (id)
);

CREATE TABLE pairs (
    id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    pair_date date NOT NULL,
    schedule_item_id int NOT NULL,
    subject_id int NOT NULL,
    theme nvarchar(256) NOT NULL,


    CONSTRAINT FK_pairs_schedule_item FOREIGN KEY (schedule_item_id) REFERENCES schedule_items (id),
    CONSTRAINT FK_pairs_subject FOREIGN KEY (subject_id) REFERENCES subjects (id)

);



CREATE TABLE group_pair (
    group_id int NOT NULL,
    pair_id int NOT NULL,

    CONSTRAINT PK_group_pair PRIMARY KEY (group_id, pair_id),
    CONSTRAINT FK_group_pair_group FOREIGN KEY (group_id) REFERENCES groups (id),
    CONSTRAINT FK_group_pair_pair FOREIGN KEY (pair_id) REFERENCES pairs (id)
);







