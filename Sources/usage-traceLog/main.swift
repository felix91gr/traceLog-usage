import TraceLog

TraceLog.configure(writers: [ConsoleWriter()], environment: ["LOG_ALL": "TRACE4"])

print("Hello!")

for _ in 0..<100 {
	logError { "Hey, I'm logging stuff! :D" }
}

print("Goodbye!")