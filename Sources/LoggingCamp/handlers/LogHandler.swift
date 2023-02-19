public protocol LogHandler {

    func log(_ level: LogLevel, _ message: String, _ caller: String, _ cause: Error?);

}