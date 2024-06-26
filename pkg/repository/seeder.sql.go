// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.25.0
// source: seeder.sql

package repository

import (
	"context"
)

const truncateAllTables = `-- name: TruncateAllTables :exec
TRUNCATE TABLE languages, offices, partners, employees CASCADE
`

func (q *Queries) TruncateAllTables(ctx context.Context) error {
	_, err := q.db.Exec(ctx, truncateAllTables)
	return err
}
