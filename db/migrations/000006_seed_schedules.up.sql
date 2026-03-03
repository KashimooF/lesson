-- =====================================================
-- 1 КУРС
-- =====================================================

-- РПО1-1, РПО2-1, РПО3-1 (одинаковое расписание)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    day,
    para,
    week_type
FROM 
    (VALUES 
        ('РПО1-1'), ('РПО2-1'), ('РПО3-1')
    ) AS group_names(name_group)
    CROSS JOIN (
        VALUES 
            -- математика (2 раза)
            ('математика', 'Бунед', 1, 1, 0),
            ('математика', 'Бунед', 3, 2, 0),
            -- физика (2 раза)
            ('физика', 'Бунед', 1, 3, 0),
            ('физика', 'Бунед', 2, 1, 0),
            -- информатика (2 раза)
            ('информатика', 'Максим', 2, 2, 0),
            ('информатика', 'Максим', 3, 1, 0),
            -- литература (1 раз)
            ('литература', 'Тамара', 3, 2, 0),
            -- химия (1 раз)
            ('химия', 'Юлия Вячеславовна', 4, 1, 0),
            -- русский (1 раз)
            ('русский', 'Тамара', 4, 2, 0),
            -- английский (2 раза)
            ('английский', 'Татьяна', 2, 3, 0),
            ('английский', 'Татьяна', 4, 3, 0),
            -- история (1 раз)
            ('история', 'Марина', 5, 1, 0),
            -- физ-ра (1 раз)
            ('физ-ра', 'Вера', 5, 2, 0),
            -- география (1 раз)
            ('география', 'Марина', 5, 3, 0),
            -- индивидуальный проект (1 раз в 2 недели - нечётная)
            ('индивидуальный проект', 'Парвиз', 1, 4, 2),
            -- конфигурация виндовс (1 раз в 2 недели - чётная)
            ('конфигурация виндовс', 'Парвиз', 3, 4, 1),
            -- интернет-маркетинг (1 раз)
            ('интернет-маркетинг', 'Ольшанская', 2, 4, 0)
    ) AS subjects_data(subject_name, teacher_name, day, para, week_type)
    JOIN Groups g ON g.name_group = group_names.name_group
    JOIN Subjects s ON s.name_subjects = subjects_data.subject_name
    JOIN Teachers t ON t.full_name = subjects_data.teacher_name;

-- ГД1-1, ГД2-1, ГД3-1 (одинаковое расписание)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    day,
    para,
    week_type
FROM 
    (VALUES 
        ('ГД1-1'), ('ГД2-1'), ('ГД3-1')
    ) AS group_names(name_group)
    CROSS JOIN (
        VALUES 
            -- математика (1 раз)
            ('математика', 'Бунед', 1, 1, 0),
            -- физика (1 раз)
            ('физика', 'Бунед', 1, 2, 0),
            -- русский (1 раз)
            ('русский', 'Тамара', 1, 3, 0),
            -- литература (1 раз)
            ('литература', 'Тамара', 2, 1, 0),
            -- английский (2 раза)
            ('английский', 'Татьяна', 2, 2, 0),
            ('английский', 'Татьяна', 2, 3, 0),
            -- история (1 раз)
            ('история', 'Марина', 3, 1, 0),
            -- физ-ра (2 раза)
            ('физ-ра', 'Вера', 3, 2, 0),
            ('физ-ра', 'Вера', 3, 3, 0),
            -- биология (1 раз)
            ('биология', 'Али', 4, 1, 0),
            -- информатика (2 раза)
            ('информатика', 'Максим', 4, 2, 0),
            ('информатика', 'Максим', 4, 3, 0),
            -- обществознание (2 раза)
            ('обществознание', 'Марина', 5, 1, 0),
            ('обществознание', 'Марина', 5, 2, 0),
            -- индивидуальный проект (1 раз в 2 недели - нечётная)
            ('индивидуальный проект', 'Юлия', 5, 3, 2),
            -- Illustrator (1,5 раза = 3 раза в 2 недели)
            ('Illustrator', 'Анна', 1, 4, 1),
            ('Illustrator', 'Анна', 2, 4, 2),
            ('Illustrator', 'Анна', 3, 4, 0),
            -- навигационный и экологический дизайн (1 раз)
            ('навигационный и экологический дизайн', 'Юлия', 4, 4, 0)
    ) AS subjects_data(subject_name, teacher_name, day, para, week_type)
    JOIN Groups g ON g.name_group = group_names.name_group
    JOIN Subjects s ON s.name_subjects = subjects_data.subject_name
    JOIN Teachers t ON t.full_name = subjects_data.teacher_name;

-- =====================================================
-- 2 КУРС
-- =====================================================

-- РПО1-2, РПО2-2
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    day,
    para,
    week_type
FROM 
    (VALUES 
        ('РПО1-2'), ('РПО2-2')
    ) AS group_names(name_group)
    CROSS JOIN (
        VALUES 
            -- история (1 раз)
            ('история', 'Марина', 1, 1, 0),
            -- английский (2 раза)
            ('английский', 'Татьяна', 1, 2, 0),
            ('английский', 'Татьяна', 1, 3, 0),
            -- физ-ра (1 раз)
            ('физ-ра', 'Вера', 2, 1, 0),
            -- разработка программных модулей (4 раза)
            ('разработка программных модулей', 'Артемий', 2, 2, 0),
            ('разработка программных модулей', 'Артемий', 2, 3, 0),
            ('разработка программных модулей', 'Артемий', 3, 1, 0),
            ('разработка программных модулей', 'Артемий', 3, 2, 0),
            -- тестирование (1 раз)
            ('тестирование', 'Артемий', 3, 3, 0),
            -- разработка мобильных приложений (3 раза)
            ('разработка мобильных приложений', 'Артемий', 4, 1, 0),
            ('разработка мобильных приложений', 'Артемий', 4, 2, 0),
            ('разработка мобильных приложений', 'Артемий', 4, 3, 0),
            -- с++ (6 раз)
            ('с++', 'Влад', 5, 1, 0),
            ('с++', 'Влад', 5, 2, 0),
            ('с++', 'Влад', 5, 3, 0),
            ('с++', 'Влад', 5, 4, 0),
            ('с++', 'Влад', 5, 5, 0),
            ('с++', 'Влад', 5, 6, 0)
    ) AS subjects_data(subject_name, teacher_name, day, para, week_type)
    JOIN Groups g ON g.name_group = group_names.name_group
    JOIN Subjects s ON s.name_subjects = subjects_data.subject_name
    JOIN Teachers t ON t.full_name = subjects_data.teacher_name;

-- ГД1-2, ГД2-2
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    day,
    para,
    week_type
FROM 
    (VALUES 
        ('ГД1-2'), ('ГД2-2')
    ) AS group_names(name_group)
    CROSS JOIN (
        VALUES 
            -- основы рисунка (2 раза)
            ('основы рисунка', 'Анна', 1, 1, 0),
            ('основы рисунка', 'Анна', 1, 2, 0),
            -- дизайн интерьера (3 раза)
            ('дизайн интерьера', 'Юлия', 1, 3, 0),
            ('дизайн интерьера', 'Юлия', 2, 1, 0),
            ('дизайн интерьера', 'Юлия', 2, 2, 0),
            -- ТЗ на графический дизайн (6 раз)
            ('ТЗ на графический дизайн', 'Юлия', 2, 3, 0),
            ('ТЗ на графический дизайн', 'Юлия', 3, 1, 0),
            ('ТЗ на графический дизайн', 'Юлия', 3, 2, 0),
            ('ТЗ на графический дизайн', 'Юлия', 3, 3, 0),
            ('ТЗ на графический дизайн', 'Юлия', 4, 1, 0),
            ('ТЗ на графический дизайн', 'Юлия', 4, 2, 0),
            -- дизайн-проектирование (7 раз)
            ('дизайн-проектирование', 'Юлия', 4, 3, 0),
            ('дизайн-проектирование', 'Юлия', 5, 1, 0),
            ('дизайн-проектирование', 'Юлия', 5, 2, 0),
            ('дизайн-проектирование', 'Юлия', 5, 3, 0),
            ('дизайн-проектирование', 'Юлия', 5, 4, 0),
            ('дизайн-проектирование', 'Юлия', 5, 5, 0),
            ('дизайн-проектирование', 'Юлия', 5, 6, 0)
    ) AS subjects_data(subject_name, teacher_name, day, para, week_type)
    JOIN Groups g ON g.name_group = group_names.name_group
    JOIN Subjects s ON s.name_subjects = subjects_data.subject_name
    JOIN Teachers t ON t.full_name = subjects_data.teacher_name;

-- =====================================================
-- 3 КУРС
-- =====================================================

-- РПО-3
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    day,
    para,
    week_type
FROM 
    (VALUES ('РПО-3')) AS group_names(name_group)
    CROSS JOIN (
        VALUES 
            -- английский (2 раза)
            ('английский', 'Татьяна', 1, 1, 0),
            ('английский', 'Татьяна', 1, 2, 0),
            -- физ-ра (2 раза)
            ('физ-ра', 'Вера', 1, 3, 0),
            ('физ-ра', 'Вера', 2, 1, 0),
            -- html-css-js (6 раз)
            ('html-css-js', 'Влад', 2, 2, 0),
            ('html-css-js', 'Влад', 2, 3, 0),
            ('html-css-js', 'Влад', 3, 1, 0),
            ('html-css-js', 'Влад', 3, 2, 0),
            ('html-css-js', 'Влад', 3, 3, 0),
            ('html-css-js', 'Влад', 4, 1, 0),
            -- разработка программного обеспечения (2 раза)
            ('разработка программного обеспечения', 'Артемий', 4, 2, 0),
            ('разработка программного обеспечения', 'Артемий', 4, 3, 0),
            -- инструментальные средства разработки (2 раза)
            ('инструментальные средства разработки', 'Влад', 5, 1, 0),
            ('инструментальные средства разработки', 'Влад', 5, 2, 0),
            -- мат.моделирование (2 раза)
            ('мат.моделирование', 'Бунед', 5, 3, 0),
            ('мат.моделирование', 'Бунед', 5, 4, 0),
            -- поддержка комп.систем (2 раза)
            ('поддержка комп.систем', 'Влад', 5, 5, 0),
            ('поддержка комп.систем', 'Артемий', 5, 6, 0),
            -- Обеспечение качества (6 раз)
            ('Обеспечение качества функционирования компьютерных систем', 'Влад', 6, 1, 0),
            ('Обеспечение качества функционирования компьютерных систем', 'Влад', 6, 2, 0),
            ('Обеспечение качества функционирования компьютерных систем', 'Влад', 6, 3, 0),
            ('Обеспечение качества функционирования компьютерных систем', 'Артемий', 6, 4, 0),
            ('Обеспечение качества функционирования компьютерных систем', 'Артемий', 6, 5, 0),
            ('Обеспечение качества функционирования компьютерных систем', 'Артемий', 6, 6, 0)
    ) AS subjects_data(subject_name, teacher_name, day, para, week_type)
    JOIN Groups g ON g.name_group = group_names.name_group
    JOIN Subjects s ON s.name_subjects = subjects_data.subject_name
    JOIN Teachers t ON t.full_name = subjects_data.teacher_name;

-- ГД-3
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    day,
    para,
    week_type
FROM 
    (VALUES ('ГД-3')) AS group_names(name_group)
    CROSS JOIN (
        VALUES 
            -- английский (2 раза)
            ('английский', 'Татьяна', 1, 1, 0),
            ('английский', 'Татьяна', 1, 2, 0),
            -- многостраничный дизайн (3 раза)
            ('многостраничный дизайн', 'Юлия', 1, 3, 0),
            ('многостраничный дизайн', 'Юлия', 2, 1, 0),
            ('многостраничный дизайн', 'Юлия', 2, 2, 0),
            -- дизайн упаковки (5 раз)
            ('дизайн упаковки', 'Юлия', 2, 3, 0),
            ('дизайн упаковки', 'Юлия', 3, 1, 0),
            ('дизайн упаковки', 'Юлия', 3, 2, 0),
            ('дизайн упаковки', 'Юлия', 3, 3, 0),
            ('дизайн упаковки', 'Юлия', 4, 1, 0),
            -- Maya 3d (2 раза)
            ('Maya 3d', 'Ольшанская', 4, 2, 0),
            ('Maya 3d', 'Ольшанская', 4, 3, 0),
            -- zbrush (1 раз)
            ('zbrush', 'Ольшанская', 5, 1, 0),
            ('zbrush', 'Данил', 5, 2, 0),
            -- adobe premier (2 раза)
            ('adobe premier', 'Ольшанская', 5, 3, 0),
            ('adobe premier', 'Данил', 5, 4, 0),
            -- сборка дизайна (2 раза)
            ('сборка дизайна', 'Юлия', 5, 5, 0),
            ('сборка дизайна', 'Юлия', 5, 6, 0)
    ) AS subjects_data(subject_name, teacher_name, day, para, week_type)
    JOIN Groups g ON g.name_group = group_names.name_group
    JOIN Subjects s ON s.name_subjects = subjects_data.subject_name
    JOIN Teachers t ON t.full_name = subjects_data.teacher_name;

-- =====================================================
-- ЗАНЯТИЯ С ЧЁТНОСТЬЮ (week_type = 1 и 2)
-- =====================================================

-- РПО1-1: индивидуальный проект (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    1, 4, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'РПО1-1'
  AND s.name_subjects = 'индивидуальный проект'
  AND t.full_name = 'Парвиз';

-- РПО1-1: конфигурация виндовс (чётная - 1)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    3, 4, 1
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'РПО1-1'
  AND s.name_subjects = 'конфигурация виндовс'
  AND t.full_name = 'Парвиз';

-- РПО2-1: индивидуальный проект (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    1, 4, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'РПО2-1'
  AND s.name_subjects = 'индивидуальный проект'
  AND t.full_name = 'Парвиз';

-- РПО2-1: конфигурация виндовс (чётная - 1)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    3, 4, 1
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'РПО2-1'
  AND s.name_subjects = 'конфигурация виндовс'
  AND t.full_name = 'Парвиз';

-- РПО3-1: индивидуальный проект (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    1, 4, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'РПО3-1'
  AND s.name_subjects = 'индивидуальный проект'
  AND t.full_name = 'Парвиз';

-- РПО3-1: конфигурация виндовс (чётная - 1)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    3, 4, 1
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'РПО3-1'
  AND s.name_subjects = 'конфигурация виндовс'
  AND t.full_name = 'Парвиз';

-- =====================================================
-- ГД1-1, ГД2-1, ГД3-1
-- =====================================================

-- ГД1-1: индивидуальный проект (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    5, 3, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД1-1'
  AND s.name_subjects = 'индивидуальный проект'
  AND t.full_name = 'Юлия';

-- ГД1-1: Illustrator (чётная - 1)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    1, 4, 1
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД1-1'
  AND s.name_subjects = 'Illustrator'
  AND t.full_name = 'Анна';

-- ГД1-1: Illustrator (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    2, 4, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД1-1'
  AND s.name_subjects = 'Illustrator'
  AND t.full_name = 'Анна';

-- ГД2-1: индивидуальный проект (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    5, 3, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД2-1'
  AND s.name_subjects = 'индивидуальный проект'
  AND t.full_name = 'Юлия';

-- ГД2-1: Illustrator (чётная - 1)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    1, 4, 1
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД2-1'
  AND s.name_subjects = 'Illustrator'
  AND t.full_name = 'Анна';

-- ГД2-1: Illustrator (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    2, 4, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД2-1'
  AND s.name_subjects = 'Illustrator'
  AND t.full_name = 'Анна';

-- ГД3-1: индивидуальный проект (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    5, 3, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД3-1'
  AND s.name_subjects = 'индивидуальный проект'
  AND t.full_name = 'Юлия';

-- ГД3-1: Illustrator (чётная - 1)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    1, 4, 1
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД3-1'
  AND s.name_subjects = 'Illustrator'
  AND t.full_name = 'Анна';

-- ГД3-1: Illustrator (нечётная - 2)
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
SELECT 
    g.id_group,
    s.id_subjects,
    t.id_teach,
    2, 4, 2
FROM Groups g, Subjects s, Teachers t
WHERE g.name_group = 'ГД3-1'
  AND s.name_subjects = 'Illustrator'
  AND t.full_name = 'Анна';