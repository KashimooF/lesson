CREATE TABLE Groups(
    id_group SERIAL PRIMARY KEY NOT NULL UNIQUE,
    name_group VARCHAR(32) NOT NULL UNIQUE,
    course INTEGER NOT NULL
);
CREATE TABLE Subjects(
  id_item SERIAL PRIMARY KEY NOT NULL,
  name_item VARCHAR(256)NOT NULL UNIQUE

);
CREATE TABLE Teachers(
    id_teach SERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(64) NOT NULL
);
CREATE TABLE Schedules(
    id_schedule SERIAL PRIMARY KEY NOT NULL,
    groups_id INTEGER NOT NULL,
    items_id INTEGER NOT NULL,
    teachers_id INTEGER NOT NULL,
    FOREIGN KEY (groups_id) REFERENCES Groups (id_group),
    FOREIGN KEY (items_id) REFERENCES  Subjects(id_item),
    FOREIGN KEY (teachers_id) REFERENCES Teachers(id_teach),
    days_of_week INTEGER NOT NULL,
    CONSTRAINT chk_day_range CHECK(days_of_week BETWEEN 1 AND 7),
    number_par SMALLINT DEFAULT 0 NOT NULL CHECK(number_par BETWEEN 1 AND 6),
    week_type SMALLINT DEFAULT 0 NOT NULL CHECK(week_type IN (0,1,2))
    --0 - каждую неделю
    --1 - чётная
    --2 - нечётная

);
CREATE TABLE Teachers_items(

    id SERIAL PRIMARY KEY,

    teachers_id INTEGER NOT NULL REFERENCES Teachers(id_teach) ON DELETE CASCADE,
    items_id INTEGER NOT NULL REFERENCES Subjects(id_item) ON DELETE CASCADE,

    UNIQUE(teachers_id, items_id)

);
CREATE TABLE schema_migrations(
    version INTEGER PRIMARY KEY UNIQUE, --Уникальный номер миграции
    description VARCHAR(256) NOT NULL, -- Описание
    installed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP, --Временя применения 
    success BOOLEAN NOT NULL -- успшено или нет
)

--добавить индексы      