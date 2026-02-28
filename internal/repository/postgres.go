package repository

import (
	"context"
	"marsh/internal/models"

	"github.com/jackc/pgx/v5/pgxpool"
)

type PostgresRepo struct {
	db *pgxpool.Pool
}

func NewPostgresRepo(pool *pgxpool.Pool) *PostgresRepo {
	return &PostgresRepo{db: pool}
}

func (p *PostgresRepo) CreateGroup(ctx context.Context, name string, course int) (int, error) {
	var id int

	query := "INSERT INTO Groups(name_group,course) VALUES($1,$2) RETURNING id_group"

	if err := p.db.QueryRow(ctx, query, name, course).Scan(&id); err != nil {

		return 0, err
	}

	return id, nil
}
func (p *PostgresRepo) GetGroupByName(ctx context.Context, name string) (models.Group, error) {
	var nameGr models.Group

	query := "SELECT id_group, name_group, course FROM Groups WHERE name_group = $1"

	if err := p.db.QueryRow(ctx, query, name).Scan(&nameGr.ID, &nameGr.NameGroup, &nameGr.Course); err != nil {

		return models.Group{}, err
	}

	return nameGr, nil
}
func (p *PostgresRepo) GetGroupByID(ctx context.Context, id int) (models.Group, error) {

	var gr models.Group

	query := "SELECT id_group, name_group,course FROM Groups WHERE id_group = $1"

	if err := p.db.QueryRow(ctx, query, id).Scan(&gr.ID, &gr.NameGroup, &gr.Course); err != nil {
		return models.Group{}, err

	}
	return gr, nil

}
func (p *PostgresRepo) GetAllGroup(ctx context.Context) ([]models.Group, error) {

	var groups []models.Group

	query := "SELECT id_group, name_group, course FROM Groups"

	rows, err := p.db.Query(ctx, query)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var gr models.Group

		if err := rows.Scan(&gr.ID, &gr.NameGroup, &gr.Course); err != nil {

			return nil, err
		}

		groups = append(groups, gr)

	}

	return groups, rows.Err()
}

func (p *PostgresRepo) CreateSubjects(ctx context.Context, name string) (int, error) {

	var id int

	query := "INSERT INTO Subjects(name_subjects) VALUES($1) RETURNING id_subjects"
	err := p.db.QueryRow(ctx, query, name).Scan(&id)
	return id, err
}
func (p *PostgresRepo) GetSubjectByName(ctx context.Context, name string) (models.Subject, error) {

	var nameSub models.Subject

	query := "SELECT id_subjects, name_subjects  FROM Subjects WHERE id_subjects = $1"

	if err := p.db.QueryRow(ctx, query, name).Scan(&nameSub.ID, &nameSub.NameSubjects); err != nil {

		return models.Subject{}, err
	}
	return nameSub, nil
}
func (p *PostgresRepo) GetAllSubjects(ctx context.Context) ([]models.Subject, error) {

	var sub []models.Subject

	query := "SELECT id_subjects, name_subjects FROM Subjects"

	rows, err := p.db.Query(ctx, query)

	if err != nil {
		return []models.Subject{}, err
	}
	defer rows.Close()

	for rows.Next() {

		var s models.Subject

		if err := rows.Scan(&s.ID, &s.NameSubjects); err != nil {
			return nil, err
		}
		sub = append(sub, s)
	}

	return sub, rows.Err()
}
func (p *PostgresRepo) CreateTeacherName(ctx context.Context, fullname string) (int, error) {

	var id int

	query := "INSERT INTO Teachers(full_name) VALUES($1) RETURNING id_teach"
	err := p.db.QueryRow(ctx, query, fullname).Scan(&id)
	return id, err
}
func (p *PostgresRepo) GetTeacherByName(ctx context.Context, name string) (models.Teacher, error) {

	var nameTeach models.Teacher

	query := "SELECT id_teach, full_name FROM Teachers WHERE id_teach = $1"

	if err := p.db.QueryRow(ctx, query, name).Scan(&nameTeach.ID, &nameTeach.FullName); err != nil {

		return models.Teacher{}, err
	}
	return nameTeach, nil
}
func (p *PostgresRepo) GetAllTeachers(ctx context.Context) ([]models.Teacher, error) {

	var tech []models.Teacher

	query := "SELECT id_teach, full_name FROM Teachers"

	rows, err := p.db.Query(ctx, query)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {

		var t models.Teacher

		if err := rows.Scan(&t.ID, &t.FullName); err != nil {
			return nil, err
		}
		tech = append(tech, t)
	}

	return tech, rows.Err()
}

func (p *PostgresRepo) LinkTeacherToSubject(ctx context.Context, teacherID int, subjectsID int) error {

	query := `INSERT INTO Teachers_subjects(teachers_id,subjects_id) 
	VALUES($1,$2) 
	ON CONFLICT DO NOTHING`

	_, err := p.db.Exec(ctx, query, teacherID, subjectsID)
	if err != nil {
		return err
	}
	return nil
}

func (p *PostgresRepo) AddSchedules(ctx context.Context, schedule models.Schedule) (int, error) {
	var id int

	query := `INSERT INTO Schedules(groups_id,subjects_id,teachers_id,days_of_week,number_par,week_type) 
		VALUES($1,$2,$3,$4,$5,$6) RETURNING id_schedule`

	err := p.db.QueryRow(ctx, query, schedule.GroupsId, schedule.SubjectsId,
		schedule.TeachersId, schedule.DaysOfWeek,
		schedule.NumberPar, schedule.WeekType).Scan(&id)

	if err != nil {
		return 0, err

	}
	return id, nil
}
func (p *PostgresRepo) GetSchedulesFilteredByWeek(ctx context.Context, groupID int, weektype int) ([]models.ScheduleWithDetails, error) {

	var schedule []models.ScheduleWithDetails

	query := `SELECT s.id_schedule, s.groups_id, s.subjects_id, s.teachers_id,
	 s.days_of_week,s.number_par,s.week_type, g.name_group, sub.name_subjects,t.full_name
	FROM Schedules s
	JOIN Groups g ON s.groups_id = g.id_group
	JOIN Subjects sub ON s.subjects_id = sub.id_subjects
	JOIN Teachers t ON s.teachers_id = t.id_teach
	WHERE s.groups_id = $1 AND (s.week_type = $2 OR s.week_type = 0)
	ORDER BY s.days_of_week, s.number_par;`

	rows, err := p.db.Query(ctx, query, groupID, weektype)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {

		var sc models.ScheduleWithDetails

		if err := rows.Scan(&sc.ID, &sc.GroupsId, &sc.SubjectsId,
			&sc.TeachersId, &sc.DaysOfWeek, &sc.NumberPar, &sc.WeekType,
			&sc.NameGroup, &sc.NameSubjects, &sc.FullName); err != nil {

			return []models.ScheduleWithDetails{}, err
		}
		schedule = append(schedule, sc)

	}

	return schedule, rows.Err()

}
