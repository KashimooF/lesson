package service

import (
	"context"
	"fmt"
	"log"
	"marsh/internal/models"
	"os"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
)

type SubjectRequirement struct {
	SubjectID int

	TeacherID int

	TimesPerWeek int

	WeekType int
}
type GroupScheduleRequest struct {
	GroupID  int
	Subjects []SubjectRequirement
}
type SlotKey struct {
	Day       int
	NumberPar int
	WeekType  int
}

func ConnectionDB(ctx context.Context) *pgxpool.Pool {

	if err := godotenv.Load(); err != nil {

		log.Fatal("Не удалось открыть .env файл")
	}

	dbUrl := os.Getenv("DATABASE_URL")

	db, err := pgxpool.New(ctx, dbUrl)

	if err != nil {
		log.Fatal("Не удалось подключиться к базе данных")
	}
	if err := db.Ping(ctx); err != nil {

		log.Fatal("База не отвечает")
	}
	return db
}

func GetEmploymentGroup(ctx context.Context, db *pgxpool.Pool, groupID int) (map[SlotKey]bool, error) {

	busySlots := make(map[SlotKey]bool)

	query := `SELECT days_of_week,number_par,week_type FROM Schedules WHERE groups_id = $1`

	rows, err := db.Query(ctx, query, groupID)

	if err != nil {
		return busySlots, err

	}
	defer rows.Close()

	for rows.Next() {

		var d, n, w int

		if err := rows.Scan(&d, &n, &w); err != nil {
			return busySlots, err
		}
		key := SlotKey{Day: d, NumberPar: n, WeekType: w}

		busySlots[key] = true
	}
	return busySlots, nil
}

func GetEmploymentTeachers(ctx context.Context, db *pgxpool.Pool, teacherID []int) (map[int]map[SlotKey]bool, error) {

	teacherBusy := make(map[int]map[SlotKey]bool)

	if len(teacherID) == 0 {
		return teacherBusy, nil
	}
	query := `SELECT teachers_id, days_of_week, number_par, week_type
	FROM Schedules 
	WHERE teachers_id = ANY($1)`

	rows, err := db.Query(ctx, query, teacherID)
	if err != nil {
		return teacherBusy, err
	}
	defer rows.Close()

	for rows.Next() {

		var tID, d, n, w int

		if err := rows.Scan(&tID, &d, &n, &w); err != nil {
			return teacherBusy, err
		}
		if teacherBusy[tID] == nil {
			teacherBusy[tID] = make(map[SlotKey]bool)
		}
		teacherBusy[tID][SlotKey{Day: d, NumberPar: n, WeekType: w}] = true
	}
	return teacherBusy, nil
}
func GenerateGroupSchedule(ctx context.Context, db *pgxpool.Pool, req GroupScheduleRequest) error {

	var teacherIds []int
	var res []models.Schedule

	if len(teacherIds) == 0 {
		return fmt.Errorf("нет преподавателей для генерации расписания")
	}

	for _, s := range req.Subjects {
		teacherIds = append(teacherIds, s.TeacherID)
	}
	busySlots, _ := GetEmploymentGroup(ctx, db, req.GroupID)

	busyTeachers, _ := GetEmploymentTeachers(ctx, db, teacherIds)

	for _, sub := range req.Subjects {
		placeCount := 0
		for day := 1; day <= 7; day++ {
			for para := 1; para <= 7; para++ {
				if placeCount >= sub.TimesPerWeek {
					break
				}

				key := SlotKey{Day: day, NumberPar: para, WeekType: sub.WeekType}
				keyEveryWeek := SlotKey{Day: day, NumberPar: para, WeekType: 0}

				if !busySlots[key] && !busySlots[keyEveryWeek] &&
					!busyTeachers[sub.TeacherID][key] && !busyTeachers[sub.TeacherID][keyEveryWeek] {

					busySlots[key] = true
					if busyTeachers[sub.TeacherID] == nil {
						busyTeachers[sub.TeacherID] = make(map[SlotKey]bool)
					}
					busyTeachers[sub.TeacherID][key] = true

					res = append(res, models.Schedule{
						GroupsId:   req.GroupID,
						SubjectsId: sub.SubjectID,
						TeachersId: sub.TeacherID,
						DaysOfWeek: day,
						NumberPar:  para,
						WeekType:   sub.WeekType,
					})

					placeCount++

				}

			}
		}
		if placeCount < sub.TimesPerWeek {
			return fmt.Errorf("не хватило места для предмета %d", sub.SubjectID)
		}
	}
	tx, err := db.Begin(ctx)
	if err != nil {
		return err
	}
	for _, s := range res {
		query := `INSERT INTO Schedules(groups_id,subjects_id, teachers_id,  
		days_of_week, number_par,week_type)
	 	VALUES($1, $2, $3, $4, $5, $6)`
		if _, err := tx.Exec(ctx, query, s.GroupsId, s.SubjectsId, s.TeachersId, s.DaysOfWeek, s.NumberPar, s.WeekType); err != nil {
			tx.Rollback(ctx)
			return err
		}
	}
	tx.Commit(ctx)

	return nil
}

func GetCurrentWeekType() int {
	now := time.Now()

	startTerm := time.Date(2026, time.February, 1, 0, 0, 0, 0, time.Local)

	_, startWeek := startTerm.ISOWeek()
	_, currentWeek := now.ISOWeek()

	yearsDiff := now.Year() - startTerm.Year()

	actualCurrentWeek := currentWeek + (yearsDiff * 52)

	weeksPassed := actualCurrentWeek - startWeek

	if weeksPassed%2 == 0 {
		return 1
	}
	return 2
	// Возвращает:
	// 1 - чётная неделя
	// 2 - нечётная неделя

}
