import Foundation

public final class LogHandlerManager {

    nonisolated(unsafe) private static var handlers: [String: LogHandler] = ["default": ColoredPrintLogHandler()]
    nonisolated(unsafe) private static var disabledHandlers: [String] = []
    private static let handlerQueue = DispatchQueue(label: "LoggingCamp.LogHandlerManager", attributes: .concurrent)

    public static func loadHandler(_ handlerId: String, _ handler: LogHandler) {
        handlerQueue.sync(flags: .barrier) {
            handlers[handlerId] = handler
        }
    }

    public static func getHandlers() -> [String: LogHandler] {
        return handlerQueue.sync {
            handlers
        }
    }

    public static func disableHandler(_ handlerId: String) {
        handlerQueue.sync(flags: .barrier) {
            disabledHandlers.append(handlerId)
        }
    }

    public static func enableHandler(_ handlerId: String) {
        handlerQueue.sync(flags: .barrier) {
            disabledHandlers.removeAll(where: { $0 == handlerId })
        }
    }

    public static func isHandlerEnabled(_ handlerId: String) -> Bool {
        return handlerQueue.sync {
            !disabledHandlers.contains(handlerId)
        }
    }

    public static func getEnabledHandlers(_ enabled: [String]? = nil) -> [LogHandler] {
        return handlerQueue.sync {
            handlers.filter { isHandlerEnabled($0.key) && (enabled == nil || enabled!.contains($0.key)) }.map { $0.value }
        }
    }

    public static func getIdEnabledHandlers(_ enabled: [String]? = nil) -> [(String, LogHandler)] {
        return handlerQueue.sync {
            handlers.filter { isHandlerEnabled($0.key) && (enabled == nil || enabled!.contains($0.key)) }
        }
    }
}
