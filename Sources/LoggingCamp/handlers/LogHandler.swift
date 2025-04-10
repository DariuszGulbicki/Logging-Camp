public protocol LogHandler: Sendable {

    func log(_ entry: LogEntry);

}