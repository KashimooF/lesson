package repository

import (
	"context"
	"marsh/internal/models"
)

type SchedulesCollegeGroup interface {
	CreateGroup(ctx context.Context, name string, course int) (int, error)
	GetGroupByID(ctx context.Context, id int) (models.Group, error)
	GetAllGroup(ctx context.Context) ([]models.Group, error)
}
type SchedulesCollegeSubjects interface {
	CreateSubjects(ctx context.Context, name string) (int, error)
	GetAllSubjects(ctx context.Context) ([]models.Subject, error)
}
type SchedulesCollegeTeacher interface {
	CreateTeacherName(ctx context.Context, fullname string) (int, error)
	GetAllTeachers(ctx context.Context) ([]models.Teacher, error)
	LinkTeacherToSubject(ctx context.Context, teacherID int, subjectsID int) error
}
type SchedulesCollege interface {
	AddSchedules(ctx context.Context, schedule models.Schedule) ([]models.Schedule, error)
	GetSchedelesFileredByWeek(ctx context.Context, groupID int, weektype int) (models.ScheduleWithDetails, error)
}
