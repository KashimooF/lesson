-- Бунед
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Бунед' AND s.name_subjects IN ('физика', 'математика', 'мат.моделирование');

-- Влад
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Влад' AND s.name_subjects IN ('с++', 'html-css-js', 'поддержка комп.систем', 'Обеспечение качества функционирования компьютерных систем');

-- Артемий
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Артемий' AND s.name_subjects IN ('разработка программных модулей', 'разработка мобильных приложений', 'тестирование', 'поддержка комп.систем', 'Обеспечение качества функционирования компьютерных систем');

-- Максим
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Максим' AND s.name_subjects IN ('информатика');

-- Али
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Али' AND s.name_subjects IN ('биология');

-- Татьяна
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Татьяна' AND s.name_subjects IN ('английский');

-- Ольшанская
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Ольшанская' AND s.name_subjects IN ('интернет-маркетинг', 'Maya 3d', 'zbrush', 'adobe premier');

-- Тамара
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Тамара' AND s.name_subjects IN ('русский', 'литература');

-- Юлия Вячеславовна
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Юлия Вячеславовна' AND s.name_subjects IN ('химия');

-- Марина
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Марина' AND s.name_subjects IN ('история', 'обществознание', 'география');

-- Парвиз
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Парвиз' AND s.name_subjects IN ('индивидуальный проект', 'конфигурация виндовс');

-- Вера
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Вера' AND s.name_subjects IN ('физ-ра');

-- Анна
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Анна' AND s.name_subjects IN ('Illustrator', 'основы рисунка');

-- Юлия
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Юлия' AND s.name_subjects IN ('навигационный и экологический дизайн', 'индивидуальный проект', 'ТЗ на графический дизайн', 'дизайн-проектирование', 'дизайн интерьера', 'многостраничный дизайн', 'сборка дизайна');

-- Данил
INSERT INTO Teachers_subjects(teachers_id, subjects_id) 
SELECT t.id_teach, s.id_subjects FROM Teachers t, Subjects s
WHERE t.full_name = 'Данил' AND s.name_subjects IN ('zbrush', 'adobe premier');