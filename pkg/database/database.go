package database

import (
	"context"
	"fmt"
	"os"

	"github.com/jackc/pgx/v5"
)

func CloseDb(conn *pgx.Conn) {
	conn.Close(context.Background())
}

func ConnectionDb() (*pgx.Conn, error) {

	dsn := os.Getenv("DATABASE_URL")

	if dsn == "" {
		return nil, fmt.Errorf("DATABASE_URL environment variable is not set")
	}

	ctx := context.Background()

	conn, err := pgx.Connect(ctx, dsn)

	if err != nil {
		return nil, err
	}

	//проверка запросов к базе данных
	if err := conn.Ping(ctx); err != nil {

		return nil, err
	}

	fmt.Println("Подключение к базе данных прошло успешно")

	return conn, nil
}
