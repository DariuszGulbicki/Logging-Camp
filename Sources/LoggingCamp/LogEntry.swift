import Foundation

public struct LogEntry: Sendable, CustomStringConvertible {

    public let handlers: [String]?

    public let level: LogLevel
    public let message: String
    public let cause: Error?
    public let timestamp: Date = Date()
    public let callerId: String
    public let callerPool: String?

    public init(_ level: LogLevel, _ message: String, handlers: [String]? = nil, cause: Error? = nil, callerId: String = #function, callerPool: String? = nil) {
        self.level = level
        self.message = message
        self.cause = cause
        self.callerId = callerId
        self.callerPool = callerPool
        self.handlers = handlers
    }

    public var description: String {
        get {
            return "\(handlers?.description ?? "ALL") \(level) \(timestamp) [\(callerPool ?? "none")/\(callerId)]: \(message) caused by \(cause?.localizedDescription ?? "unknown")";
        }
    }

}