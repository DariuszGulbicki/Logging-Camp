import Foundation

public struct LogEntry: Sendable {

    public let handlers: [String]?

    public let level: LogLevel
    public let message: String
    public let cause: Error?
    public let timestamp: Date = Date()
    public let caller: String

    public init(_ level: LogLevel, _ message: String, _ handlers: [String]? = nil, _ cause: Error? = nil, _ caller: String = #function) {
        self.level = level
        self.message = message
        self.cause = cause
        self.caller = caller
        self.handlers = handlers
    }

}