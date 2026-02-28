-- Удаляем индексы сначала (они зависят от таблиц)
DROP INDEX IF EXISTS idx_teachers;
DROP INDEX IF EXISTS idx_subjects;
DROP INDEX IF EXISTS idx_groups;

-- Удаляем таблицы в правильном порядке (сначала зависимые)
DROP TABLE IF EXISTS Schedules CASCADE;
DROP TABLE IF EXISTS Teachers_subjects CASCADE;
DROP TABLE IF EXISTS Teachers CASCADE;
DROP TABLE IF EXISTS Subjects CASCADE;
DROP TABLE IF EXISTS Groups CASCADE;

-- Таблицу миграций удаляем последней
DROP TABLE IF EXISTS schema_migrations CASCADE;