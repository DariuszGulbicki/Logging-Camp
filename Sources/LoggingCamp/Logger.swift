public class Logger {

    public static subscript(_ name: String) -> Logger {
        return LoggingCamp.getDefaulLoggerPool().getLogger(name);
    }

    public static var `default`: Logger {
        return LoggingCamp.getDefaultLogger();
    }

    private var name: String

    private var enabledHandlers: [String]?

    private var loggingLevel: LogLevel = LoggingCamp.getGlobalLoggingLevel();

    public init(_ lcls: String? = nil, _ enabledHandlers: [String]? = nil) {
        self.name = lcls ?? "UNKNOWN";
        self.enabledHandlers = enabledHandlers;
    }

    public func getName() -> String {
        return name;
    }

    public func enableHandler(_ name: String) {
        if (enabledHandlers == nil) {
            enabledHandlers = [];
        }
        enabledHandlers!.append(name);
    }

    public func disableHandler(_ name: String) {
        if (enabledHandlers == nil) {
            enabledHandlers = [];
        }
        enabledHandlers!.removeAll(where: { $0 == name });
    }

    public func isHandlerEnabled(_ name: String) -> Bool {
        if (enabledHandlers == nil) {
            return true;
        }
        return enabledHandlers!.contains(name);
    }

    public func setEnabledHandlers(_ enabled: [String]?) {
        enabledHandlers = enabled;
    }

    public func getEnabledHandlers() -> [String]? {
        return enabledHandlers;
    }

    public func log(_ level: LogLevel, _ message: String, _ cause: Error? = nil) {
        if (loggingLevel.rawValue <= level.rawValue) {
            let handlers = LoggingCamp.getEnabledHandlers(enabledHandlers)
            for handler in handlers {
                handler.log(level, message, name, cause)
            }
        }
    }

    public func log(_ level: LogLevel, _ message: Any, _ cause: Error? = nil) {
        log(level, String(describing: message), cause)
    }

    public func debug(_ message: Any, _ cause: Error? = nil) {
        if (loggingLevel.rawValue <= LogLevel.DEBUG.rawValue) {
            log(LogLevel.DEBUG, message, cause)
        }
    }

    public func info(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.INFO, message, cause)
    }

    public func warn(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.WARN, message, cause)
    }

    public func error(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.ERROR, message, cause)
    }

    public func fatal(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.FATAL, message, cause)
    }

    public func setLoggingLevel(_ level: LogLevel) {
        self.loggingLevel = level
    }

}