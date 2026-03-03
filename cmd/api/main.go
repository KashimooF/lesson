package main

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"os"
	"strconv"

	"marsh/internal/models"
	"marsh/internal/repository"

	"github.com/go-chi/chi/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
)

type Handler struct {
	Repo repository.SchedulesCollege
}

func (h *Handler) HandlerGetGroups(w http.ResponseWriter, r *http.Request) {

	ctx := r.Context()

	groups, err := h.Repo.GetAllGroup(ctx)

	if err != nil {
		http.Error(w, "Failed to get groups", http.StatusInternalServerError)
		return
	}

	if groups == nil {
		groups = []models.Group{}
	}

	w.Header().Set("Content-type", "application/json")

	w.WriteHeader(http.StatusOK)

	if err := json.NewEncoder(w).Encode(groups); err != nil {
		log.Printf("Error encoding groups: %v", err)
	}

}
func (h *Handler) DeleteGroup(w http.ResponseWriter, r *http.Request) {

	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Group", http.StatusBadRequest)
		return
	}

	ctx := r.Context()

	if err := h.Repo.DeleteGroup(ctx, id); err != nil {
		http.Error(w, "Fail to delete group", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusNoContent)
}
func (h *Handler) CreateGroup(w http.ResponseWriter, r *http.Request) {

	var reqData struct {
		Name   string `json:"name"`
		Course int    `json:"course"`
	}
	if err := json.NewDecoder(r.Body).Decode(&reqData); err != nil {
		http.Error(w, "Invalid Json", http.StatusBadRequest)
		return
	}
	defer r.Body.Close()

	if reqData.Name == "" || reqData.Course < 1 || reqData.Course > 3 {
		http.Error(w, "Invalid group data", http.StatusBadRequest)
		return
	}
	ctx := r.Context()
	id, err := h.Repo.CreateGroup(ctx, reqData.Name, reqData.Course)
	if err != nil {
		http.Error(w, "Failed to create group", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]int{"id": id})

}
func (h *Handler) GetAllSubjects(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	subjects, err := h.Repo.GetAllSubjects(ctx)
	if err != nil {
		http.Error(w, "Failed to get subjects", http.StatusInternalServerError)
		return
	}

	if subjects == nil {
		subjects = []models.Subject{}
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(subjects)
}
func (h *Handler) CreateSubject(w http.ResponseWriter, r *http.Request) {
	var requestData struct {
		Name string `json:"name"`
	}

	if err := json.NewDecoder(r.Body).Decode(&requestData); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}
	defer r.Body.Close()

	if requestData.Name == "" {
		http.Error(w, "Subject name is required", http.StatusBadRequest)
		return
	}

	ctx := r.Context()
	id, err := h.Repo.CreateSubjects(ctx, requestData.Name)
	if err != nil {
		http.Error(w, "Failed to create subject", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]int{"id": id})
}
func (h *Handler) DeleteSubject(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid subject ID", http.StatusBadRequest)
		return
	}

	ctx := r.Context()
	if err := h.Repo.DeleteSubject(ctx, id); err != nil {
		http.Error(w, "Failed to delete subject", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
func (h *Handler) GetAllTeachers(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	teachers, err := h.Repo.GetAllTeachers(ctx)
	if err != nil {
		http.Error(w, "Failed to get teachers", http.StatusInternalServerError)
		return
	}

	if teachers == nil {
		teachers = []models.Teacher{}
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(teachers)
}
func (h *Handler) GetTeacherSubjects(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	teacherID, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid teacher ID", http.StatusBadRequest)
		return
	}

	ctx := r.Context()
	subjects, err := h.Repo.GetTeacherSubjects(ctx, teacherID)
	if err != nil {
		http.Error(w, "Failed to get teacher subjects", http.StatusInternalServerError)
		return
	}

	if subjects == nil {
		subjects = []models.Subject{}
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(subjects)
}
func (h *Handler) CreateTeacher(w http.ResponseWriter, r *http.Request) {
	var requestData struct {
		FullName string `json:"full_name"`
	}

	if err := json.NewDecoder(r.Body).Decode(&requestData); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}
	defer r.Body.Close()

	if requestData.FullName == "" {
		http.Error(w, "Teacher name is required", http.StatusBadRequest)
		return
	}

	ctx := r.Context()
	id, err := h.Repo.CreateTeacherName(ctx, requestData.FullName)
	if err != nil {
		http.Error(w, "Failed to create teacher", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]int{"id": id})
}
func (h *Handler) GetScheduleByTeacher(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	teacherID, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid teacher ID", http.StatusBadRequest)
		return
	}

	ctx := r.Context()
	schedule, err := h.Repo.GetScheduleByTeacher(ctx, teacherID)
	if err != nil {
		http.Error(w, "Failed to get teacher schedule", http.StatusInternalServerError)
		return
	}

	if schedule == nil {
		schedule = []models.ScheduleWithDetails{}
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(schedule)
}
func (h *Handler) HandlerGetSchedule(w http.ResponseWriter, r *http.Request) {

	groupName := chi.URLParam(r, "groupName")

	weekParam := r.URL.Query().Get("week")

	var weekType int

	switch weekParam {
	case "even":
		weekType = 1
	case "odd":
		weekType = 2
	case "all":
		weekType = 0
	case "":
		weekType = 0
	default:
		http.Error(w, "Invalid week parametr", http.StatusBadRequest)
		return
	}

	ctx := r.Context()
	allGroups, err := h.Repo.GetAllGroup(ctx)
	if err != nil {
		http.Error(w, "Failed to get groups", http.StatusInternalServerError)
		return
	}
	var groupID int
	var found bool

	for _, group := range allGroups {
		if group.NameGroup == groupName {
			groupID = group.ID
			found = true
			break
		}
	}
	if !found {
		http.Error(w, "Group not found", http.StatusNotFound)
		return
	}
	schedule, err := h.Repo.GetSchedulesFilteredByWeek(ctx, groupID, weekType)
	if err != nil {
		http.Error(w, "Failed to get schedule", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	if err := json.NewEncoder(w).Encode(schedule); err != nil {
		log.Printf("Error encoding schedule: %v", err)
	}
}
func (h *Handler) GetAllSchedules(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	schedule, err := h.Repo.GetAllSchedules(ctx)
	if err != nil {
		http.Error(w, "Failed to get schedules", http.StatusInternalServerError)
		return
	}

	if schedule == nil {
		schedule = []models.ScheduleWithDetails{}
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(schedule)
}

func (h *Handler) HandlerCreateSchedule(w http.ResponseWriter, r *http.Request) {

	var requestData struct {
		GroupName   string `json:"group_name"`
		SubjectName string `json:"subject_name"`
		TeacherName string `json:"teacher_name"`
		DaysOfWeek  int    `json:"days_of_week"`
		NumberPar   int    `json:"number_par"`
		WeekType    int    `json:"week_type"`
	}

	if err := json.NewDecoder(r.Body).Decode(&requestData); err != nil {

		log.Println("Error decoding JSON:", err)
		http.Error(w, "Invalid JSON encoding", http.StatusBadRequest)
		return
	}
	defer r.Body.Close()

	ctx := context.Background()

	searhGroup, err := h.Repo.GetGroupByName(ctx, requestData.GroupName)
	if err != nil {
		log.Println("Group not found", requestData.GroupName, err)
		http.Error(w, "Group not found", http.StatusNotFound)
		return
	}

	searchSubjects, err := h.Repo.GetSubjectByName(ctx, requestData.SubjectName)
	if err != nil {
		log.Println("Subjects dont found", requestData.SubjectName, err)
		http.Error(w, "Group dont found", http.StatusNotFound)
		return
	}

	searchTeachers, err := h.Repo.GetTeacherByName(ctx, requestData.TeacherName)
	if err != nil {
		log.Println("teacher dont found", requestData.TeacherName, err)
		http.Error(w, "Teaher dont found", http.StatusNotFound)
		return
	}

	NewSchedule := models.Schedule{
		GroupsId:   searhGroup.ID,
		SubjectsId: searchSubjects.ID,
		TeachersId: searchTeachers.ID,
		DaysOfWeek: requestData.DaysOfWeek,
		NumberPar:  requestData.NumberPar,
		WeekType:   requestData.WeekType,
	}

	id, err := h.Repo.AddSchedules(ctx, NewSchedule)

	if err != nil {

		log.Println("Failed to create schedule:", err)
		http.Error(w, "Failed to create schedule:", http.StatusInternalServerError)
		return
	}
	NewSchedule.ID = id

	w.Header().Set("content-type", "application/json")

	w.WriteHeader(http.StatusCreated)

	response := map[string]interface{}{
		"id":      NewSchedule.ID,
		"message": "Schedule created successfully",
	}
	if err := json.NewEncoder(w).Encode(response); err != nil {
		log.Println("Error Encoding response", err)
	}

}

func main() {

	ctx := context.Background()
	if err := godotenv.Load(); err != nil {
		log.Println("Предупреждение: .env файл не найден, используются системные переменные")
	}
	dbUrl := os.Getenv("DATABASE_URL")
	if dbUrl == "" {
		log.Fatal("DATABASE_URL не установлена!")
	}

	db, err := pgxpool.New(ctx, dbUrl)

	if err != nil {
		log.Fatal("Ошибка открытия БД")
	}

	defer db.Close()

	if err := db.Ping(ctx); err != nil {
		log.Fatal("База не отвечает", err)
	}

	userRepo := repository.NewPostgresRepo(db)

	handler := &Handler{
		Repo: userRepo,
	}

	router := chi.NewRouter()

	// CORS middleware
	router.Use(func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			// Разрешаем запросы с любого источника
			w.Header().Set("Access-Control-Allow-Origin", "*")
			w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
			w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

			// Обрабатываем preflight запросы
			if r.Method == "OPTIONS" {
				w.WriteHeader(http.StatusOK)
				return
			}

			next.ServeHTTP(w, r)
		})
	})

	router.Get("/api/groups", handler.HandlerGetGroups)
	router.Post("/api/groups", handler.CreateGroup)
	router.Delete("/api/groups/{id}", handler.DeleteGroup)

	router.Get("/api/subjects", handler.GetAllSubjects)
	router.Post("/api/subjects", handler.CreateSubject)
	router.Delete("/api/subjects/{id}", handler.DeleteSubject)

	router.Get("/api/teachers", handler.GetAllTeachers)
	router.Post("/api/teachers", handler.CreateTeacher)
	router.Get("/api/teachers/{id}/subjects", handler.GetTeacherSubjects)

	router.Get("/api/schedule", handler.GetAllSchedules)
	router.Post("/api/schedule", handler.HandlerCreateSchedule)
	router.Get("/api/schedule/{groupName}", handler.HandlerGetSchedule)
	router.Get("/api/schedule/teacher/{id}", handler.GetScheduleByTeacher)

	port := os.Getenv("PORT")

	if port == "" {
		port = "5050"
	}

	addr := ":" + port

	log.Printf("Server starting on http://localhost%s\n", addr)

	log.Fatal(http.ListenAndServe(addr, router))

}
