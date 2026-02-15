package api

import (
	"encoding/json"
	"log"
	"net/http"

	"marsh/internal/models"
	"marsh/internal/repository"

	"github.com/go-chi/chi/v5"
)

type Handler struct {
	Repo      repository.SchedulesCollegeGroup
	RepoTwo   repository.SchedulesCollegeSubjects
	RepoThree repository.SchedulesCollegeTeacher
	RepoFour  repository.SchedulesCollege
}

func (h *Handler) GetGroups(w http.ResponseWriter, r *http.Request) {

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

func (h *Handler) GetSchedule(w http.ResponseWriter, r *http.Request) {

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
	schedule, err := h.RepoFour.GetSchedelesFileredByWeek(ctx, groupID, weekType)
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
