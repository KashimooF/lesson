package database

import (
	"context"
	"fmt"

	"github.com/jackc/pgx/v5"
)

func ConnectionDb() error {

	ctx := context.Background()

	conn, err := pgx.Connect(ctx, "postgres://postgres:100@localhost:5432/postgres")

	if err != nil {

		fmt.Println("Не удалось подкючиться к базе данных", err)
	}

	//проверка запросов к базе данных
	if err := conn.Ping(ctx); err != nil {

		return err
	}

	fmt.Println("Подключение к базе данных прошло успешно")

	return nil
}
