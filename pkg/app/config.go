package app

import (
	"log/slog"
	"os"
	"strconv"
	"strings"

	"github.com/joho/godotenv"
)

type Config struct {
	LogLevel slog.Level
	Port     int
	DB       DBConfig
}

type DBConfig struct {
	Name string
	Url  string
}

func LoadConfig() (*Config, error) {
	err := godotenv.Load()

	if err != nil {
		return nil, err
	}

	logLevel := parseLogLevel(os.Getenv("LOG_LEVEL"))

	port, err := parsePort(os.Getenv("PORT"))

	if err != nil {
		return nil, err
	}

	return &Config{LogLevel: logLevel, Port: port, DB: dbConfig()}, nil
}

func dbConfig() DBConfig {
	return DBConfig{Name: os.Getenv("DB_NAME"), Url: os.Getenv("DB_URL")}
}

func parseLogLevel(osLogLevel string) slog.Level {
	var logLevel slog.Level

	switch strings.ToUpper(osLogLevel) {
	case "DEBUG":
		logLevel = slog.LevelDebug
	case "INFO":
		logLevel = slog.LevelInfo
	case "WARN":
		logLevel = slog.LevelWarn
	case "ERROR":
		logLevel = slog.LevelError
	default:
		logLevel = slog.LevelInfo
	}

	return logLevel
}

func parsePort(envPort string) (int, error) {
	return strconv.Atoi(envPort)
}
