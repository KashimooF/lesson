FROM golang:1.24-bookworm AS builder 

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main_app ./cmd/api/main.go
RUN go build -o migrate_tool ./cmd/migrate/main.go 

FROM alpine:latest 

COPY --from=builder /build/main_app .
COPY --from=builder /build/migrate_tool .

COPY db/migrations ./db/migrations

CMD ["EXPOSE 5050" "./main_app"]