# Go REST API scaffold

Example of minimal Go REST API scaffold. It includes:

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
  - [ ] VsCode seamless integration

## Outline

- Go REST API `http://localhost:8080`
- Postgres DB
  - CloudBeaver `http://localhost:8979`
  - Postgres-exporter `http://localhost:9187`
- Prometheus `http://localhost:9090`
- Grafana `http://localhost:3000`

## Required tools

- Docker Engine - https://docs.docker.com/engine/install/
- Go version >= 1.22 https://go.dev/doc/install
- `migrate` CLI - https://github.com/golang-migrate/migrate/tree/master/cmd/migrate#migrate-cli
- `sqlc` CLI - https://docs.sqlc.dev/en/stable/overview/install.html

## Quick Start

```shell
$ make init run/dev           # If it's the first time
$ make docker/start run/dev   # Otherwise (no migrations to run)
```

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

- Reset all docker containers

`$ make docker/reset`
