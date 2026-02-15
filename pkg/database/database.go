package database

import (
	"context"
	"fmt"
	"os"

	"github.com/jackc/pgx/v5/pgxpool"
)

func CloseDb(pool *pgxpool.Pool) {
	pool.Close()
}

func ConnectionDb() (*pgxpool.Pool, error) {

	dsn := os.Getenv("DATABASE_URL")

	if dsn == "" {
		return nil, fmt.Errorf("DATABASE_URL environment variable is not set")
	}

	ctx := context.Background()

	pool, err := pgxpool.New(ctx, dsn)

	if err != nil {
		return nil, err
	}

	//проверка запросов к базе данных
	if err := pool.Ping(ctx); err != nil {

		return nil, err
	}

	fmt.Println("Подключение к базе данных прошло успешно")

	return pool, nil
}
