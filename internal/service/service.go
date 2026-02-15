package service

import "time"

func GetCurrentWeekType() int {
	now := time.Now()

	startTerm := time.Date(2026, time.February, 1, 0, 0, 0, 0, time.Local)

	_, startWeek := startTerm.ISOWeek()
	_, currentWeek := now.ISOWeek()

	yearsDiff := now.Year() - startTerm.Year()

	actualCurrentWeek := currentWeek + (yearsDiff * 52)

	weeksPassed := actualCurrentWeek - startWeek

	if weeksPassed%2 == 0 {
		return 2
	}
	return 1

}
