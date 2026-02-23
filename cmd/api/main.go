package api

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"os"

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
		log.Fatal("Ошибка занрузки .env файла")
	}
	dbUrl := os.Getenv("DATABASE_URL")

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

	router.Post("/api/schedule", handler.HandlerCreateSchedule)
	router.Get("/api/groups", handler.HandlerGetGroups)
	router.Get("/api/schedule/{groupName}", handler.HandlerGetSchedule)

	port := os.Getenv("PORT")

	if port == "" {
		port = "8080"
	}

	addr := ":" + port

	log.Printf("Server starting on http://localhost%s\n", addr)

	log.Fatal(http.ListenAndServe(addr, router))

}
