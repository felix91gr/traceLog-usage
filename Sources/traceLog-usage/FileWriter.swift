import TraceLog
import Foundation

public class FileWriter : Writer {

	let loggingFile : String

	private let myFileHandle : FileHandle

	public init?(forFile loggingFile: String) {

		self.loggingFile = loggingFile

		guard let newFileHandle = FileHandle(forWritingAtPath: loggingFile) else {
			return nil
		}

		self.myFileHandle = newFileHandle
	}

	deinit {
		myFileHandle.closeFile()
	}

	public func log(
		_ timestamp: Double, 
		level: LogLevel, 
		tag: String, 
		message: String, 
		runtimeContext: RuntimeContext, 
		staticContext: StaticContext
		) {

		let uppercasedLevel = "\(level)".uppercased()
        let levelString     = "\(String(repeating: " ", count: 7 - uppercasedLevel.count))\(uppercasedLevel)"
        let date            = Date(timeIntervalSince1970: timestamp)
        
        let newLine 		= "\n"

        let message         = "\(self.dateFormatter.string(from: date)) \(runtimeContext.processName)[\(runtimeContext.processIdentifier):\(runtimeContext.threadIdentifier)] \(levelString): <\(tag)> \(message)" + newLine
    	
		myFileHandle.seekToEndOfFile()
	    myFileHandle.write(message.data(using: .utf8)!)        
	}

	///
    /// Internal date formatter for this logger
    ///
    private let dateFormatter: DateFormatter = {

        var formatter = DateFormatter()

        /// 2016-04-23 10:34:26.849 Fields[39068:5120468]
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

        return formatter
	}()

}
