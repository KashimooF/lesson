INSERT INTO Groups(name_group,course)VALUES
('РПО1-1',1),('РПО2-1',1),('РПО3-1',1),
('ГД1-1'1),('ГД2-1',1),('ГД3-1',1),
('РПО1-2'2),('РПО2-2',2),
('РПО-3'3),('ГД-3',3);

INSERT INTO Subjects(name_subjects)VALUES
('математика'),('физика'),('информатика'),
('литература'),('химия'),('русский'),('англ'),
('история'),('физ-ра'),('география'),
('индивидуальный проект'),('конфигурация виндовс'),
('интернет-маркетинг'),('биология'),
('обществознание'),('Illustrator'),
('навигационный и экологический дизайн'),
('разработка программных модулей'),
('тестирование'),('разработка мобильных приложений'),
('с++'),('основы рисунка'),('дизайн интерьера'),
('ТЗ на графический дизайн'),('дизайн-проектирование'),
('html-css-js'),('разработка программного обеспечения'),
('инструментальные средства разработки'),
('мат.моделирование'),('поддержка комп.систем '),
('Обеспечение качества функционирования компьютерных систем')
('многостраничный дизайн'),('дизайн упаковки')
('Maya 3d'),('zbrush'),('adobe premier'),('сборка дизайна');

INSERT INTO Teachers(full_name) VALUES
('Бунед'),('Влад'),('Артемий'),
('Максим'),('Али'),('Татьяна'),
('Ольшанская'),('Тамара'),('Юлия Вячеславовна'),
('Марина'),('Парвиз'),('Вера'),
('Анна'),('Юлия'),('Данил');


INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Бунед' AND s.name_subjects IN('физика', 'математика', 'мат.моделирование');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Влад' AND s.name_subjects IN('с++', 'HTML-CSS-JS', 'поддержка комп.систем', 
'Обеспечение качества функционирования компьютерных систем');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Артемий' AND s.name_subjects IN('разработка программных модулей','разработка мобильных приложений', 
'тестирование','поддержка комп.систем','Обеспечение качества функционирования компьютерных систем');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Максим' AND s.name_subjects IN('информатика');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Али' AND s.name_subjects IN('биология');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Татьяна' AND s.name_subjects IN('английский');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Ольшанская' AND s.name_subjects IN('интернет-маркетинг','Maya 3d','zbrush','adobe premier');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Тамара' AND s.name_subjects IN('русский', 'литература');


INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Юлия Вячеславовна' AND s.name_subjects IN('химия');


INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Марина' AND s.name_subjects IN('история','обществознание', 'география');


INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Парвиз' AND s.name_subjects IN('индивидуальный проект','конфигурация виндовс');


INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Вера' AND s.name_subjects IN('физ-ра');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Анна' AND s.name_subjects IN('Illustrator','основы рисунка');


INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Юлия' AND s.name_subjects IN('навигационный и экологический дизайн', 'индивидуальный проект', 
'ТЗ на графический дизайн', 'дизайн-проектирование', 'дизайн интерьера', 
'многостраничный дизайн', 'сборка дизайна');

INSERT INTO Teachers_subjects(teachers_id,subjects_id) VALUES
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Данил' AND s.name_subjects IN('zbrush', 'adobe premier')



INSERT INTO Schedules(groups_id, subjects_id, teachers_id,days_of_week,number_par,week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects ='математика'),
    (SELECT id_teach FROM Teachers WHERE full_name ='Бунед'),
    1,1,0
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id,days_of_week,number_par,week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects ='Индивидуальный проект'),
    (SELECT id_teach FROM Teachers WHERE full_name ='Парвиз'),
    1,2,2
);

INSERT INTO Schedules (groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type)
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Конфигурация Windows'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Парвиз'),
    1, 3, 1
);
INSERT INTO Schedules(groups_id, subjects_id, teachers_id,days_of_week,number_par,week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'физика'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Бунед'),
    2,1,0
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id,days_of_week,number_par,week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Информатика'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Максим'),
    2,2,2
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id,days_of_week,number_par,week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'литература'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Тамара'),
    2,3,0
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id,days_of_week,number_par,week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'литература'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Тамара'),
    2,3,0
);
-- Дополнение для группы РПО1-1 (1 курс)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES 
-- Среда (день 3)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'русский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Тамара'),
    3, 1, 0
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'химия'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия Вячеславовна'),
    3, 2, 0
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    3, 3, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    3, 3, 2
),
-- Четверг (день 4)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'история'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Марина'),
    4, 1, 0
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'физ-ра'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Вера'),
    4, 2, 0
),
-- Пятница (день 5)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'география'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Марина'),
    5, 1, 0
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'интернет-маркетинг'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Ольшанская'),
    5, 2, 0
);

-- 3 курс РПО (РПО1, РПО2, РПО3)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES 
-- Понедельник (день 1)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 2, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 3, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 3, 2
),
-- Вторник (день 2)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'физ-ра'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Вера'),
    2, 1, 0
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'физ-ра'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Вера'),
    2, 2, 0
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'физ-ра'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Вера'),
    2, 3, 0
),
-- Среда (день 3)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'html-css-js'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    3, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'html-css-js'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    3, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'html-css-js'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    3, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'html-css-js'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    3, 2, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'html-css-js'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    3, 3, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'html-css-js'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    3, 3, 2
),
-- Четверг (день 4)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'разработка программного обеспечения'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Артемий'),
    4, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'разработка программного обеспечения'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Артемий'),
    4, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'инструментальные средства разработки'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    4, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'инструментальные средства разработки'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    4, 2, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'мат.моделирование'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Бунед'),
    4, 3, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'мат.моделирование'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Бунед'),
    4, 3, 2
),
-- Пятница (день 5)
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'поддержка комп.систем'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    5, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО3-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'поддержка комп.систем'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    5, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Обеспечение качества функционирования компьютерных систем'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Артемий'),
    5, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Обеспечение качества функционирования компьютерных систем'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Артемий'),
    5, 2, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Обеспечение качества функционирования компьютерных систем'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    5, 3, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Обеспечение качества функционирования компьютерных систем'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Влад'),
    5, 3, 2
);

-- 3 курс ГД (ГД1, ГД2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES 
-- Понедельник (день 1)
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
    1, 2, 2
),
-- Вторник (день 2)
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'многостраничный дизайн'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    2, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'многостраничный дизайн'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    2, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'многостраничный дизайн'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    2, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'многостраничный дизайн'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    2, 2, 2
),
-- Среда (день 3)
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'дизайн упаковки'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    3, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'дизайн упаковки'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    3, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'дизайн упаковки'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    3, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'дизайн упаковки'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    3, 2, 2
),
-- Четверг (день 4)
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Maya 3d'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Ольшанская'),
    4, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'Maya 3d'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Ольшанская'),
    4, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'zbrush'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Данил'),
    4, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'zbrush'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Данил'),
    4, 2, 2
),
-- Пятница (день 5)
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'adobe premier'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Данил'),
    5, 1, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД2-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'adobe premier'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Данил'),
    5, 1, 2
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'сборка дизайна'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    5, 2, 1
),
(
    (SELECT id_group FROM Groups WHERE name_group = 'ГД1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'сборка дизайна'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия'),
    5, 2, 2
);