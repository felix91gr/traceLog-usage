import Foundation
import TraceLog

TraceLog.configure(writers: [FileWriter(forFile: "./wololo.txt")!], environment: ["LOG_ALL": "TRACE4"])

print("Hello!")

for _ in 0..<5 {
	logError { "Hey, I'm logging stuff! :D" }
}

print("Goodbye!")

sleep(1)