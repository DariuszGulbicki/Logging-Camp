public enum LogLevel: UInt8, Sendable {
    case debug = 0
    case info = 1
    case warn = 2
    case error = 3
    case fatal = 4

    func toString() -> String {
        switch self {
        case .debug:
            return "debug"
        case .info:
            return "info"
        case .warn:
            return "warn"
        case .error:
            return "error"
        case .fatal:
            return "fatal"
        }
    }
}
