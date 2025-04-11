import Foundation
import Colorizer

public final class LogDispatcher: @unchecked Sendable {

    public static let shared = LogDispatcher()
    public static let instanceQueue = DispatchQueue(label: "LoggingCamp.LogDispatcher")
    
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
        let handlers = LogHandlerManager.getIdEnabledHandlers(entry.handlers)
        for (handlerId, handler) in handlers {
            dispatchGroup.enter()
            let queue = getQueueForHandler(handlerId)
            queue.async(flags: .barrier) {
                handler.log(entry)
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