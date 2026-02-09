package models

import (
	"database/sql"
)

type ScheduleWithDetails struct {
	db *sql.DB
}
