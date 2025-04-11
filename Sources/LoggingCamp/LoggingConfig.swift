import Foundation

public final class LoggingConfig {

    nonisolated(unsafe) private static var defaultLoggingLevel: LogLevel = .info
    nonisolated(unsafe) private static var defaultLoggerPoolId: String = "default"
    nonisolated(unsafe) private static var defaultLoggerId: String = "Main"

    private static let configQueue = DispatchQueue(label: "LoggingCamp.LoggingConfig", attributes: .concurrent)

    public static func setDefaultLoggingLevel(_ level: LogLevel) {
        configQueue.sync(flags: .barrier) {
            defaultLoggingLevel = level
            LoggerPool.pools.values.forEach { $0.loggingLevel = level }
        }
    }

    public static func getDefaultLoggingLevel() -> LogLevel {
        return configQueue.sync {
            defaultLoggingLevel
        }
    }

    public static func setDefaultLoggerPoolId(_ poolId: String) {
        configQueue.sync(flags: .barrier) {
            defaultLoggerPoolId = poolId
        }
    }

    public static func getDefaultLoggerPoolId() -> String {
        return configQueue.sync {
            defaultLoggerPoolId
        }
    }

    public static func setDefaultLoggerId(_ loggerId: String) {
        configQueue.sync(flags: .barrier) {
            defaultLoggerId = loggerId
        }
    }

    public static func getDefaultLoggerId() -> String {
        return configQueue.sync {
            defaultLoggerId
        }
    }
}
