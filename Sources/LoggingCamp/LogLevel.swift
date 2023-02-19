public enum LogLevel: UInt8 {
    case DEBUG = 0
    case INFO = 1
    case WARN = 2
    case ERROR = 3
    case FATAL = 4

    func toString() -> String {
        switch self {
        case .DEBUG:
            return "DEBUG"
        case .INFO:
            return "INFO"
        case .WARN:
            return "WARN"
        case .ERROR:
            return "ERROR"
        case .FATAL:
            return "FATAL"
        }
    }
}
