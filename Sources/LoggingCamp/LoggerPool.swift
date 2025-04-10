import Foundation

public class LoggerPool {
    
    nonisolated(unsafe) private static var _pools: [String:LoggerPool] = [:]
    private static let poolQueue = DispatchQueue(label: "pl.dariuszgulbicki.loggingcamp.poolqueue")

    public static var pools: [String:LoggerPool] {
        get {
            poolQueue.sync {
                return _pools
            }
        }
    }

    public static func getPool(_ id: String) -> LoggerPool {
        poolQueue.sync {
            if let pool = _pools[id] {
                return pool
            }
            let pool = LoggerPool(id)
            _pools[id] = pool
            return pool
            }
    }

    public static subscript(poolId: String) -> LoggerPool {
        poolQueue.sync {
            if let pool = _pools[poolId] {
                return pool
            }
            let newPool = LoggerPool(poolId)
            _pools[poolId] = newPool
            return newPool
        }
    }

    public let poolId: String

    public init (_ poolId: String) {
        self.poolId = poolId
    }

    private var loggers: [Logger] = []

    private var _loggingLevel: LogLevel = LoggingCamp.getGlobalLoggingLevel()

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
        @discardableResult
        get {
            return getLogger(name)
        }
        set {
            loggers.removeAll(where: { $0.getId() == name })
            loggers.append(newValue)
        }
    }
    
    @discardableResult
    public func getLogger(_ name: String) -> Logger {
        for logger in loggers {
            if logger.getId() == name {
                return logger
            }
        }
        let logger = Logger(name, _enabledHandlers, correspondingPool: self.poolId)
        logger.setLoggingLevel(loggingLevel)
        loggers.append(logger)
        return logger
    }

    public func getLoggers() -> [Logger] {
        return loggers
    }

    public func addLogger(_ logger: Logger) {
        loggers.append(logger)
    }

    public func addLoggers(_ loggers: [Logger]) {
        for logger in loggers {
            addLogger(logger)
        }
    }

    public func addLoggers(_ loggers: Logger...) {
        for logger in loggers {
            addLogger(logger)
        }
    }

    public func removeAll() {
        loggers.removeAll()
    }

    public func remove(_ logger: Logger) {
        loggers.removeAll(where: { $0.getId() == logger.getId() })
    }

    public func remove(_ name: String) {
        loggers.removeAll(where: { $0.getId() == name })
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