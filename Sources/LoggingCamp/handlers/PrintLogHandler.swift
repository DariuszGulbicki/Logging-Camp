import Foundation

public class PrintLogHandler: LogHandler {

    private var template: String
    private var timeFormat: String

    public init(template: String = "[@time] (@caller) @level: @message @cause", timeFormat: String = "HH:mm:ss") {
        self.template = template;
        self.timeFormat = timeFormat;
    }

    public func log(_ level: LogLevel, _ message: String, _ caller: String, _ cause: Error?) {
        var output = template;
        let df = DateFormatter()
        df.dateFormat = timeFormat;
        output = output.replacingOccurrences(of: "@time", with: df.string(from: Date()));
        output = output.replacingOccurrences(of: "@level", with: level.toString());
        output = output.replacingOccurrences(of: "@caller", with: caller);
        output = output.replacingOccurrences(of: "@message", with: message);
        output = output.replacingOccurrences(of: "@cause", with: cause?.localizedDescription ?? "");
        print(output);
    }

    private func prepareCause(_ cause: Error?) -> String {
        if (cause == nil) {
            return ""
        }
        return "{\(cause?.localizedDescription ?? "UNKNOWN")}"
    }

}