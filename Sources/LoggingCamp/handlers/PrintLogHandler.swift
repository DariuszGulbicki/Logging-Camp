import Foundation

public final class PrintLogHandler: LogHandler {

    private let template: String
    private let timeFormat: String

    public init(template: String = "[@time] (@caller) @level: @message @cause", timeFormat: String = "HH:mm:ss") {
        self.template = template;
        self.timeFormat = timeFormat;
    }

    public func log(_ entry: LogEntry) {
        var output = template;
        let df = DateFormatter()
        df.dateFormat = timeFormat;
        output = output.replacingOccurrences(of: "@time", with: df.string(from: entry.timestamp));
        output = output.replacingOccurrences(of: "@level", with: entry.level.toString());
        output = output.replacingOccurrences(of: "@caller", with: "\(entry.callerPool != nil ? "(\(entry.callerPool!)) " : "")\(entry.callerId)");
        output = output.replacingOccurrences(of: "@message", with: entry.message);
        output = output.replacingOccurrences(of: "@cause", with: entry.cause?.localizedDescription ?? "");
        print(output);
    }

    private func prepareCause(_ cause: Error?) -> String {
        if let cause = cause {
            return "{Caused by: \(cause)}"
        }
        return ""
    }

}