public actor LoggingCamp {

    private static let defaultLoggerPool = LoggerPool();

    private static var _defaultLoggerName: String = "Main";
    public static var defaultLoggerName: String {
        get {
            return _defaultLoggerName;
        }
        set {
            _defaultLoggerName = newValue;
        }
    }

    private static var handlers: [String:LogHandler] = ["default":ColoredPrintLogHandler()];
    private static var disabledHandlers: [String] = [];

    private static var loggingLevel: LogLevel = .INFO;

    public static func getDefaulLoggerPool() -> LoggerPool {
        return defaultLoggerPool;
    }

    public static func getDefaultLogger() -> Logger {
        return defaultLoggerPool.getLogger(LoggingCamp.defaultLoggerName)
    }

    public static func loadHandler(_ name: String, _ handler: LogHandler) {
        handlers[name] = handler;
    }

    public static func getHandlers() -> [String:LogHandler] {
        return handlers;
    }

    public static func disableHandler(_ name: String) {
        disabledHandlers.append(name);
    }

    public static func enableHandler(_ name: String) {
        disabledHandlers.removeAll(where: { $0 == name });
    }

    public static func isHandlerEnabled(_ name: String) -> Bool {
        return !disabledHandlers.contains(name);
    }

    public static func getEnabledHandlers(_ enabled: [String]? = nil) -> [LogHandler] {
        var enabledHandlers: [LogHandler] = [];
        for (name, handler) in handlers {
            if isHandlerEnabled(name) && (enabled == nil || enabled!.contains(name)) {
                enabledHandlers.append(handler);
            }
        }
        return enabledHandlers;
    }

    public static func setGlobalLoggingLevel(_ level: LogLevel) {
        loggingLevel = level;
        defaultLoggerPool.loggingLevel = level;
    }

    public static func getGlobalLoggingLevel() -> LogLevel {
        return loggingLevel;
    }

}