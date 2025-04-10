public actor LoggingCamp {

    private static let defaultLoggerPool = LoggerPool("default");

    private static var _defaultLogHandlerId: String = "Main";
    public static var defaultLogHandlerId: String {
        get {
            return _defaultLogHandlerId;
        }
        set {
            _defaultLogHandlerId = newValue;
        }
    }

    private static var handlers: [String:LogHandler] = ["default":ColoredPrintLogHandler()];
    private static var disabledHandlers: [String] = [];

    private static var loggingLevel: LogLevel = .info;

    public static func getDefaulLoggerPool() -> LoggerPool {
        return defaultLoggerPool;
    }

    public static func getDefaultLogger() -> Logger {
        return defaultLoggerPool.getLogger(LoggingCamp.defaultLogHandlerId)
    }

    public static func loadHandler(_ handlerId: String, _ handler: LogHandler) {
        handlers[handlerId] = handler;
    }

    public static func getHandlers() -> [String:LogHandler] {
        return handlers;
    }

    public static func disableHandler(_ handlerId: String) {
        disabledHandlers.append(handlerId);
    }

    public static func enableHandler(_ handlerId: String) {
        disabledHandlers.removeAll(where: { $0 == handlerId });
    }

    public static func isHandlerEnabled(_ handlerId: String) -> Bool {
        return !disabledHandlers.contains(handlerId);
    }

    public static func getEnabledHandlers(_ enabled: [String]? = nil) -> [LogHandler] {
        var enabledHandlers: [LogHandler] = [];
        for (handlerId, handler) in handlers {
            if isHandlerEnabled(handlerId) && (enabled == nil || enabled!.contains(handlerId)) {
                enabledHandlers.append(handler);
            }
        }
        return enabledHandlers;
    }

    public static func getIdEnabledHandlers(_ enabled: [String]? = nil) -> [(String, LogHandler)] {
        var enabledHandlers: [(String, LogHandler)] = [];
        for (handlerId, handler) in handlers {
            if isHandlerEnabled(handlerId) && (enabled == nil || enabled!.contains(handlerId)) {
                enabledHandlers.append((handlerId, handler));
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