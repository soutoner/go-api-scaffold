CREATE TABLE IF NOT EXISTS offices (
	id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT offices_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS languages (
	id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT languages_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS employees (
	id serial NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NULL,
	email varchar(255) NOT NULL,
	picture_url varchar(255) NULL,
	office_id int NOT NULL,
	position varchar(255) NOT NULL,
	birthday varchar(255) NULL,
	created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT employees_pkey PRIMARY KEY (id),
	CONSTRAINT employees_email_unique UNIQUE (email),
	CONSTRAINT employees_office_id_foreign FOREIGN KEY (office_id) REFERENCES offices(id) ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS employees_languages (
	id serial NOT NULL,
	user_id int NOT NULL,
	language_id int NOT NULL,
	created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT employees_languages_pkey PRIMARY KEY (id),
	CONSTRAINT employees_languages_language_id_foreign FOREIGN KEY (language_id) REFERENCES languages(id) ON DELETE CASCADE,
	CONSTRAINT employees_languages_user_id_foreign FOREIGN KEY (user_id) REFERENCES employees(id) ON DELETE CASCADE
);