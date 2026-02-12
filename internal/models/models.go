package models

type Group struct {
	ID        int    `db:"id_group"`
	NameGroup string `db:"name_group"`
	Course    int    `db:"course"`
}

type Subject struct {
	ID           int    `db:"id_subjects"`
	NameSubjects string `db:"name_subjects"`
}
type Teacher struct {
	ID       int    `db:"id_teach"`
	FullName string `db:"full_name"`
}

type Schedule struct {
	ID         int `db:"id_schedule"`
	GroupsId   int `db:"groups_id"`
	SubjectsId int `db:"subjects_id"`
	TeachersId int `db:"teachers_id"`
	DaysOfWeek int `db:"days_of_week"`
	NumberPar  int `db:"number_par"`
	WeekType   int `db:"week_type"`
}
type Teachers_subject struct {
	ID         int `db:"id"`
	TeachersId int `db:"teachers_id"`
	SubjectsId int `db:"subjects_id"`
}

type ScheduleWithDetails struct {
	Schedule
	NameGroup    string `db:"name_group"`
	NameSubjects string `db:"name_subjects"`
	FullName     string `db:"full_name"`
}
