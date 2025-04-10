import Foundation
import Colorizer

public final class ColoredPrintLogHandler: LogHandler {

    private let template: String
    private let timeFormat: String

    public init(_ template: String = "@time @level @caller @message @cause", _ timeFormat: String = "HH:mm:ss.SSS") {
        self.template = template
        self.timeFormat = timeFormat
    }

    public func log(_ entry: LogEntry) {
        let time = prepareTime(Date())
        let level = prepareLevel(entry.level)
        let message = prepareMessage(entry.message)
        let cause = prepareCause(entry.cause)
        let caller = prepareCaller(entry.callerId, entry.callerPool)
        let output = template
            .replacing("@time", with: time)
            .replacing("@level", with: level)
            .replacing("@message", with: message)
            .replacing("@cause", with: cause)
            .replacing("@caller", with: caller)
        print(output)
    }

    private func prepareLevel(_ level: LogLevel) -> String {
        switch level {
            case .DEBUG:
                return "[DEBUG]".white().greenBackground()
            case .INFO:
                return "[INFO]".white().blueBackground()
            case .WARN:
                return "[WARN]".white().yellowBackground()
            case .ERROR:
                return "[ERROR]".bold().white().redBackground()
            case .FATAL:
                return "!!! FATAL !!!".bold().underline().red().blackBackground()
        }
    }

    private func prepareTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
        return "(\(formatter.string(from: time)))".dim()
    }

    private func prepareMessage(_ message: String) -> String {
        return message
    }

    private func prepareCause(_ cause: Error?) -> String {
        if let cause = cause {
            return "{".red() + "Caused by: \(cause)".red().italic() + "}".red()
        }
        return ""
    }

    private func prepareCaller(_ caller: String, _ callerPool: String?) -> String {
        var callerString = ""
        if let callerPool = callerPool {
            callerString += "(\(callerPool)) "
        }
        callerString += "\(caller):"
        return callerString.magenta()
    }

}