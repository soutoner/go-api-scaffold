include .env

MAIN_CMD := cmd/server/main.go
MAIN_BIN := bin/main
START_SCRIPT := scripts/start.sh
MIGRATIONS_PATH := pkg/repository/migrations
MIGRATE_CLI := migrate -database ${DB_URL} -path ${MIGRATIONS_PATH}

## Init project
init: docker/start

## App
build:
	rm -f ${MAIN_BIN}
	go build -o ${MAIN_BIN} ${MAIN_CMD}

build/debug:
	rm -f ${MAIN_BIN}
	go build -gcflags=all="-N -l" -o ${MAIN_BIN} ${MAIN_CMD}

run: build
	${MAIN_BIN}

run/local: docker/start
	docker compose stop api
	go run ${MAIN_CMD}

test:
	go test ./...

## Docker
docker/start:
	docker compose --env-file .env --env-file .env.docker up -d

docker/stop:
	docker compose stop

docker/clean:
	docker compose down --remove-orphans --rmi local --volumes

docker/reset: docker/clean docker/start

## Database
migrate/up:
	@echo "Migrating database"
	@${MIGRATE_CLI} up

migrate/down:
	@echo "Rollback of the database in progress"
	@${MIGRATE_CLI} down

migration/create:
	migrate create -ext sql -dir migrations -seq ${MIGRATION_NAME}

db/generate:
	rm -f pkg/repository/*.go
	sqlc generate

seed:
	go run cmd/seeder/seeder.go