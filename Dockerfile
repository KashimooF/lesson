FROM golang:1.24-bookworm AS builder 

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN  CGO_ENABLED=0 go build -o main_app ./cmd/api/main.go
RUN  CGO_ENABLED=0 go build -o migrate_tool ./cmd/migrate/main.go 

FROM alpine:latest 

RUN apk add --no-cache ca-certificates

COPY --from=builder /build/main_app .
COPY --from=builder /build/migrate_tool .

COPY db/migrations ./db/migrations

EXPOSE 5050

CMD ["./main_app"]
