public class Logger {

    public static subscript(_ name: String) -> Logger {
        return LoggingCamp.getDefaulLoggerPool().getLogger(name);
    }

    public static var `default`: Logger {
        return LoggingCamp.getDefaultLogger();
    }

    private var id: String
    private var correspondingPool: String?

    private var enabledHandlers: [String]?

    private var loggingLevel: LogLevel = LoggingCamp.getGlobalLoggingLevel();

    public init(_ id: String? = nil, _ enabledHandlers: [String]? = nil, correspondingPool: String? = nil) {
        self.id = id ?? "UNKNOWN";
        self.enabledHandlers = enabledHandlers;
        self.correspondingPool = correspondingPool;
    }

    public func getId() -> String {
        return id;
    }

    public func enableHandler(_ id: String) {
        if (enabledHandlers == nil) {
            enabledHandlers = [];
        }
        enabledHandlers!.append(id);
    }

    public func disableHandler(_ id: String) {
        if (enabledHandlers == nil) {
            enabledHandlers = [];
        }
        enabledHandlers!.removeAll(where: { $0 == id });
    }

    public func isHandlerEnabled(_ id: String) -> Bool {
        if (enabledHandlers == nil) {
            return true;
        }
        return enabledHandlers!.contains(id);
    }

    public func setEnabledHandlers(_ enabled: [String]?) {
        enabledHandlers = enabled;
    }

    public func getEnabledHandlers() -> [String]? {
        return enabledHandlers;
    }

    public func log(_ level: LogLevel, _ message: String, _ cause: Error? = nil) {
        if (loggingLevel.rawValue <= level.rawValue) {
            let entry = LogEntry(level, message, handlers: enabledHandlers, cause: cause, callerId: "\(self.id)", callerPool: correspondingPool)
            LogDispatcher.shared.dispatchLogEntry(entry)
        }
    }

    public func log(_ level: LogLevel, _ message: Any, _ cause: Error? = nil) {
        log(level, String(describing: message), cause)
    }

    public func debug(_ message: Any, _ cause: Error? = nil) {
        if (loggingLevel.rawValue <= LogLevel.debug.rawValue) {
            log(LogLevel.debug, message, cause)
        }
    }

    public func info(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.info, message, cause)
    }

    public func warn(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.warn, message, cause)
    }

    public func error(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.error, message, cause)
    }

    public func fatal(_ message: Any, _ cause: Error? = nil) {
        log(LogLevel.fatal, message, cause)
    }

    public func setLoggingLevel(_ level: LogLevel) {
        self.loggingLevel = level
    }

}