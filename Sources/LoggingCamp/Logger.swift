public class Logger {

    private var logClass: String

    private var enabledLoggers: [String]?

    private var loggingLevel: LogLevel = LoggingCamp.getGlobalLoggingLevel();

    public init(_ lcls: String? = nil, _ enabledLoggers: [String]? = nil) {
        self.logClass = lcls ?? "UNKNOWN";
        self.enabledLoggers = enabledLoggers;
    }

    public func log(_ level: LogLevel, _ message: String, _ cause: Error? = nil) {
        if (loggingLevel.rawValue <= level.rawValue) {
            let loggers = LoggingCamp.getEnabledHandlers(enabledLoggers);
            for logger in loggers {
                logger.log(level, message, logClass, cause);
            }
        }
    }

    public func debug(_ message: String, _ cause: Error? = nil) {
        if (loggingLevel.rawValue <= LogLevel.DEBUG.rawValue) {
            log(LogLevel.DEBUG, message, cause);
        }
    }

    public func info(_ message: String, _ cause: Error? = nil) {
        log(LogLevel.INFO, message, cause);
    }

    public func warn(_ message: String, _ cause: Error? = nil) {
        log(LogLevel.WARN, message, cause);
    }

    public func error(_ message: String, _ cause: Error? = nil) {
        log(LogLevel.ERROR, message, cause);
    }

    public func fatal(_ message: String, _ cause: Error? = nil) {
        log(LogLevel.FATAL, message, cause);
    }

    public func setLoggingLevel(_ level: LogLevel) {
        self.loggingLevel = level;
    }

}