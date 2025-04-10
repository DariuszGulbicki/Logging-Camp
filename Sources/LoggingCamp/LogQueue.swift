import Foundation
import Colorizer

public class LogDispatcher {

    public static let shared = LogDispatcher()
    
    private init() {
        atexit {
            LogDispatcher.shared.flushLogs()
        }
    }

    private var handlerQueues: [String: DispatchQueue] = [:]
    private let dispatchGroup = DispatchGroup()

    private func getQueueForHandler(_ handler: String) -> DispatchQueue {
        if let queue = handlerQueues[handler] {
            return queue
        }
        let queue = DispatchQueue(label: handler, qos: .background)
        handlerQueues[handler] = queue
        return queue
    }

    public func dispatchLogEntry(_ entry: LogEntry) {   
        let handlers = LoggingCamp.getNamedEnabledHandlers(entry.handlers)
        for (handlerId, handler) in handlers {
            dispatchGroup.enter()
            let queue = getQueueForHandler(handlerId)
            queue.async(flags: .barrier) {
                handler.log(entry.level, entry.message, entry.caller, entry.cause)
                self.dispatchGroup.leave()
            }
        }
    }

    private func flushLogs() {
        let result = dispatchGroup.wait(timeout: .now() + 10)
        if result == .timedOut {
            print("⚠️ Log flushing incomplete! Timeout waiting for logs to finish.")
        }
    }

}