# Go REST API scaffold

Example of minimal Go REST API. It includes:

- REST Server (chi)
  - [x] JSON serialization
  - [x] Request logging
  - [ ] Authorization middleware (client credentails check)
  - [ ] Request corrrelation
- Database
  - [x] Potgres connection (pgx)
  - [x] Generated queries (sqlc)
  - [x] Migrations (golang-migrate)
  - [x] Dockerized inspection app (CloudBeaver)
    - [ ] Provision configuration
- Testing
  - [x] Unit testing
  - [ ] Integration tests
  - [ ] k6 tests
- Logs
  - [x] Logs rotation (lumberkack)
  - [ ] Loki + Grafana log indexing
- Metrics
  - [x] Prometheus + Grafana connection
  - [x] Postgres metrics (postgres-exporter)
  - [ ] Custom metrics
- Dev experience
  - [x] Fully dockerized
  - [x] Live reloading (air)
  - [ ] VSCode seamless integration

## Outline

- Go REST API `http://localhost:8080`
- Postgres DB
  - CloudBeaver `http://localhost:8979`
  - Postgres-exporter `http://localhost:9187`
- Prometheus `http://localhost:9090`
- Grafana `http://localhost:3000`

## Quick Start (Docker)

```shell
$ cp .env.example .env
$ make docker/start
```

## Starting locally

```shell
$ make run/local
```

## Debug mode

```shell
$ make docker/start         # Ensure that needed containers (e.g. DB) are available
$ docker compose stop api   # Stop dockerized app so ports are not conflicting
```

Use the VSCode launch configuration for debug mode. It will first build the app for debug, and then run it with a debugger session attached.

## References

### CloudBeaver

Until default configuration is added, first time you access the server in `http://localhost:8979/` you need to configurate the main settings and create the admin account.

Afterwards:

1. Login with admin account
2. Go to `http://localhost:8979/`
3. `[+] > Find Local Database` and write `db`. Select the source that pops up and configure accordingly.

### Database migrations

- Create new migration

`$ MIGRATION_NAME='example_name' make migration/create`

- Run migrations up/down

`$ make migrate/[up|down]`

### Useful commands

- Reset all docker containers (removes volumes)

`$ make docker/reset`
