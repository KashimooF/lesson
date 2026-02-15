TRUNCATE Schedules, Teachers_subjects, Teachers, Subjects, Groups RESTART IDENTITY CASCADE;


-- CASCADE удалит данные во всех связанных таблицах
-- RESTART IDENTITY сбросит счетчики ID, чтобы при следующем UP всё началось с 1
