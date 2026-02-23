package repository

import (
	"context"
	"marsh/internal/models"
)

type SchedulesCollege interface {
	CreateGroup(ctx context.Context, name string, course int) (int, error)
	GetGroupByID(ctx context.Context, id int) (models.Group, error)
	GetGroupByName(ctx context.Context, name string) (models.Group, error)
	GetAllGroup(ctx context.Context) ([]models.Group, error)

	CreateSubjects(ctx context.Context, name string) (int, error)
	GetSubjectByName(ctx context.Context, name string) (models.Subject, error)
	GetAllSubjects(ctx context.Context) ([]models.Subject, error)

	CreateTeacherName(ctx context.Context, fullname string) (int, error)
	GetAllTeachers(ctx context.Context) ([]models.Teacher, error)
	GetTeacherByName(ctx context.Context, fullname string) (models.Teacher, error)
	LinkTeacherToSubject(ctx context.Context, teacherID int, subjectsID int) error

	AddSchedules(ctx context.Context, schedule models.Schedule) (int, error)
	GetSchedulesFilteredByWeek(ctx context.Context, groupID int, weektype int) ([]models.ScheduleWithDetails, error)
}
