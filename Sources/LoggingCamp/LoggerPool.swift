public class LoggerPool {
    
    private static var _pools: [String:LoggerPool] = [:]

    public static var pools: [String:LoggerPool] {
        get {
            return _pools
        }
    }

    public static func getPool(_ name: String) -> LoggerPool {
        if let pool = _pools[name] {
            return pool
        }
        let pool = LoggerPool()
        _pools[name] = pool
        return pool
    }

    public static subscript(name: String) -> LoggerPool {
        get {
            return getPool(name)
        }
        set {
            _pools[name] = newValue
        }
    }

    private var loggers: [Logger] = []

    private var _loggingLevel: LogLevel = .INFO

    public var loggingLevel: LogLevel {
        get {
            return _loggingLevel
        }
        set {
            _loggingLevel = newValue
            forEach({ logger in
                logger.setLoggingLevel(newValue)
            })
        }
    }

    private var _enabledHandlers: [String]? = nil
    
    public var enabledHandlers : [String]? {
        get {
            return _enabledHandlers
        }
        set {
            _enabledHandlers = newValue
            forEach({ logger in
                logger.setEnabledHandlers(newValue)
            })
        }
    }

    public subscript(_ name: String) -> Logger {
        get {
            return getLogger(name)
        }
        set {
            loggers.removeAll(where: { $0.getName() == name })
            loggers.append(newValue)
        }
    }
    
    @discardableResult
    public func getLogger(_ name: String) -> Logger {
        for logger in loggers {
            if logger.getName() == name {
                return logger
            }
        }
        let logger = Logger(name, _enabledHandlers)
        logger.setLoggingLevel(loggingLevel)
        loggers.append(logger)
        return logger
    }

    public func getLoggers() -> [Logger] {
        return loggers
    }

    public func forEach(_ action: (Logger) -> Void) {
        loggers.forEach(action)
    }

    public func log(_ level: LogLevel, _ message: Any, _ cause: Error? = nil) {
        forEach({ logger in
            logger.log(level, message, cause)
        })
    }

    public func debug(_ message: Any, _ cause: Error? = nil) {
        forEach({ logger in
            logger.debug(message, cause)
        })
    }

    public func info(_ message: Any, _ cause: Error? = nil) {
        forEach({ logger in
            logger.info(message, cause)
        })
    }

    public func warn(_ message: Any, _ cause: Error? = nil) {
        forEach({ logger in
            logger.warn(message, cause)
        })
    }

    public func error(_ message: Any, _ cause: Error? = nil) {
        forEach({ logger in
            logger.error(message, cause)
        })
    }

    public func fatal(_ message: Any, _ cause: Error? = nil) {
        forEach({ logger in
            logger.fatal(message, cause)
        })
    }

}