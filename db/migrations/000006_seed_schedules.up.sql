INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'математика'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Бунед'),
    1, 1, 0
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'индивидуальный проект'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Парвиз'),
    1, 2, 2
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type)
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'конфигурация виндовс'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Парвиз'),
    1, 3, 1
);
-- +2
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'физика'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Бунед'),
    2, 1, 0
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'информатика'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Максим'),
    2, 2, 2
);
-- ++2
INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'литература'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Тамара'),
    2, 3, 0
);

INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
VALUES (
    (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
    (SELECT id_subjects FROM Subjects WHERE name_subjects = 'русский'),
    (SELECT id_teach FROM Teachers WHERE full_name = 'Тамара'),
    3, 1, 0
);
-- ++2

-- INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
-- VALUES (
--     (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
--     (SELECT id_subjects FROM Subjects WHERE name_subjects = 'химия'),
--     (SELECT id_teach FROM Teachers WHERE full_name = 'Юлия Вячеславовна'),
--     3, 2, 0
-- );

-- INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
-- VALUES (
--     (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
--     (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
--     (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
--     3, 3, 1
-- );

-- INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
-- VALUES (
--     (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
--     (SELECT id_subjects FROM Subjects WHERE name_subjects = 'английский'),
--     (SELECT id_teach FROM Teachers WHERE full_name = 'Татьяна'),
--     3, 3, 2
-- );

-- INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
-- VALUES (
--     (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
--     (SELECT id_subjects FROM Subjects WHERE name_subjects = 'история'),
--     (SELECT id_teach FROM Teachers WHERE full_name = 'Марина'),
--     4, 1, 0
-- );

-- INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
-- VALUES (
--     (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
--     (SELECT id_subjects FROM Subjects WHERE name_subjects = 'физ-ра'),
--     (SELECT id_teach FROM Teachers WHERE full_name = 'Вера'),
--     4, 2, 0
-- );

-- INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
-- VALUES (
--     (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
--     (SELECT id_subjects FROM Subjects WHERE name_subjects = 'география'),
--     (SELECT id_teach FROM Teachers WHERE full_name = 'Марина'),
--     5, 1, 0
-- );

-- INSERT INTO Schedules(groups_id, subjects_id, teachers_id, days_of_week, number_par, week_type) 
-- VALUES (
--     (SELECT id_group FROM Groups WHERE name_group = 'РПО1-1'),
--     (SELECT id_subjects FROM Subjects WHERE name_subjects = 'интернет-маркетинг'),
--     (SELECT id_teach FROM Teachers WHERE full_name = 'Ольшанская'),
--     5, 2, 0
-- );