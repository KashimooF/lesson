package main

import (
	"context"
	"flag"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
)

type MigrationsType struct {
	Version int
	Up      string
	Down    string
}

func ConnectionDataMigrate(ctx context.Context) *pgxpool.Pool {

	if err := godotenv.Load(); err != nil {

		log.Println("Ошибка загрузки .env файла")
	}

	dbUrl := os.Getenv("DATABASE_URL")
	if dbUrl == "" {
		log.Fatal("DATABASE_URL не установлена!")
	}

	db, err := pgxpool.New(ctx, dbUrl)

	if err != nil {
		log.Fatal("Не удалось подключиться к базе данных")
	}
	if err := db.Ping(ctx); err != nil {

		log.Fatal("База не отвечает")
	}

	query := "CREATE TABLE IF NOT EXISTS schema_migrations(version INTEGER PRIMARY KEY, applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);"

	_, err = db.Exec(ctx, query)
	if err != nil {
		log.Fatalf("Не удалось создать таблицу миграций: %v", err)
	}

	return db
}

func main() {
	ctx := context.Background()

	var command string

	flag.StringVar(&command, "command", "up", "migrations command: up or down ")
	flag.Parse()

	db := ConnectionDataMigrate(ctx)

	defer db.Close()

	migrations := getMigrations("db/migrations")

	applied := getApplied(ctx, db)

	switch command {
	case "up":
		runUp(ctx, db, migrations, applied)
	case "down":
		runDown(ctx, db, migrations, applied)
	default:
		log.Fatalf("Не известная команда: %s", command)
	}
}
func getMigrations(path string) []MigrationsType {
	entries, err := os.ReadDir(path)

	if err != nil {
		log.Fatal("Ошибка чтения дуриктории", err)
	}

	mMap := make(map[int]*MigrationsType)

	for _, ent := range entries {

		if ent.IsDir() || !strings.HasSuffix(ent.Name(), ".sql") {
			continue
		}

		parts := strings.Split(ent.Name(), "_")

		vInt, err := strconv.Atoi(parts[0])
		if err != nil {
			continue
		}
		if mMap[vInt] == nil {
			mMap[vInt] = &MigrationsType{Version: vInt}
		}
		if strings.Contains(ent.Name(), ".up.") {
			mMap[vInt].Up = path + "/" + ent.Name()
		}
		if strings.Contains(ent.Name(), ".down.") {
			mMap[vInt].Down = path + "/" + ent.Name()
		}
	}
	var list []MigrationsType

	for _, m := range mMap {
		list = append(list, *m)
	}

	sort.Slice(list, func(i, j int) bool {
		return list[i].Version < list[j].Version
	})
	return list
}

func getApplied(ctx context.Context, db *pgxpool.Pool) map[int]bool {

	query := "SELECT version FROM schema_migrations"

	rows, err := db.Query(ctx, query)

	if err != nil {
		log.Fatalf("Ошибка получения примененных миграций: %v", err)
	}
	defer rows.Close()
	applied := make(map[int]bool)

	for rows.Next() {

		var v int
		if err := rows.Scan(&v); err == nil {
			applied[v] = true
		}
	}
	return applied

}

func runUp(ctx context.Context, db *pgxpool.Pool, migrations []MigrationsType, applied map[int]bool) {

	for _, m := range migrations {
		if applied[m.Version] {
			continue
		}
		log.Printf("Применение миграций %d", m.Version)

		content, err := os.ReadFile(m.Up)
		if err != nil {
			log.Fatalf("Ошибка чтения файла %s: %v", m.Up, err)
		}

		tx, err := db.Begin(ctx)

		if err != nil {
			log.Fatal(err)
		}
		if _, err := tx.Exec(ctx, string(content)); err != nil {
			tx.Rollback(ctx)
			log.Fatalf("Ошибка выполнения SQL (%d): %v", m.Version, err)
		}
		if _, err := tx.Exec(ctx, "INSERT INTO schema_migrations(version) VALUES($1) ON CONFLICT DO NOTHING", m.Version); err != nil {
			tx.Rollback(ctx)
			log.Fatalf("Ошибка записи версий %d: %v", m.Version, err)
		}
		tx.Commit(ctx)
		log.Println("Мигрции успешно применены", m.Version)
	}
}

func runDown(ctx context.Context, db *pgxpool.Pool, migrations []MigrationsType, applied map[int]bool) {

	var last *MigrationsType

	for i := len(migrations) - 1; i >= 0; i-- {
		if applied[migrations[i].Version] {
			last = &migrations[i]
			break
		}
	}
	if last == nil {
		log.Println("Нет миграций для отката")
		return
	}

	log.Printf("Откат миграций %d", last.Version)

	content, err := os.ReadFile(last.Down)
	if err != nil {
		log.Fatalf("Ошибка чтения файла %v", err)
	}

	tx, err := db.Begin(ctx)

	if err != nil {
		log.Fatal(err)
	}

	if _, err := tx.Exec(ctx, string(content)); err != nil {
		tx.Rollback(ctx)
		log.Fatalf("Ошибка отката миграций %d: %v", last.Version, err)

	}
	if _, err := tx.Exec(ctx, "DELETE FROM schema_migrations WHERE version = $1", last.Version); err != nil {
		tx.Rollback(ctx)
		log.Fatalf("Ошибка удаления версий %d :%v", last.Version, err)
	}
	tx.Commit(ctx)
	log.Printf("Миграция %d успешно откачена", last.Version)

}
