package app

import (
	"log"
	"log/slog"

	"gopkg.in/natefinch/lumberjack.v2"
)

const defaultLogFilename = "/var/log/scaffold-api/app.log"

func ConfigureLogger(logLevel slog.Level) {
	slog.SetLogLoggerLevel(logLevel)

	log.SetOutput(&lumberjack.Logger{
		Filename:   defaultLogFilename,
		MaxSize:    500, // MB
		MaxBackups: 3,
		MaxAge:     28, //days
		Compress:   true,
	})
}
