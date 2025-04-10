public protocol LogHandler: Sendable {

    func log(_ level: LogLevel, _ message: String, _ caller: String, _ cause: Error?);

}