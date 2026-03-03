.PHONY: migrate-up migrate-down run docker-up docker-down build clean  

migrate-up:
	go run cmd/migrate/main.go -command up

migrate-down:
	go run cmd/migrate/main.go -command down

run:
	go run cmd/api/main.go

docker-up:
	docker compose up 

docker-down:
	docker compose down

build:
	go build -o bin/main_app cmd/api/main.go
	go build -o bin/migrate_tool cmd/migrate/main.go

clean:
	rm -rf bin/
	docker-compose down -v
	docker system prune -f

rebuild: clean docker-up