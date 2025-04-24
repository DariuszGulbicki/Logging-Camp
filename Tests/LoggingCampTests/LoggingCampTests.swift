import Testing
import Foundation
@testable import LoggingCamp

struct LoggingCampTests {

    @Test
    func loggerInitializationAndHandlers() {
        LoggingConfig.setDefaultLoggingLevel(.debug)
        let logger = Logger("test")
        logger.setEnabledHandlers(["default"])

        #expect(logger.getId() == "test", "Logger ID should match the initialized value.")
        #expect(logger.getEnabledHandlers() == ["default"], "Enabled handlers should match the set value.")
    }

    @Test
    func loggerLoggingMethods() {
        let logger = Logger("test")
        logger.setEnabledHandlers(["default"])

        logger.debug("This is a debug message")
        logger.info("This is an info message")
        logger.warn("This is a warning message")
        logger.error("This is an error message")
        logger.fatal("This is a fatal message")

        // Add assertions or mock handler checks if applicable
    }

    @Test
    func loggingPool() {
        let logger = Logger("test")
        let loggingPool = LoggerPool("new")

        loggingPool.addLogger(logger)

        #expect(loggingPool.getLoggers().count == 1)
        #expect(loggingPool["test"].getId() == "test")

        loggingPool["newLogger"].info("New logger created")

        loggingPool.loggingLevel = .debug

        #expect(loggingPool.loggingLevel == .debug)
        #expect(loggingPool.getLoggers().count == 2)

        loggingPool.debug("This is a debug message")
        loggingPool.info("This is an info message")
        loggingPool.warn("This is a warning message")
        loggingPool.error("This is an error message")
        loggingPool.fatal("This is a fatal message")

        loggingPool.removeAll()

        #expect(loggingPool.getLoggers().count == 0)
    }

    @Test
    func operators() {
        let logger = Logger("test")
        logger.setEnabledHandlers(["default"])

        let message = "This is a test message"
        let error = NSError(domain: "TestError", code: 1, userInfo: nil)

        <<<(message)
        <<<(error)
        <<<(message, error)

        ?<<<(message)
        ?<<<(error)
        ?<<<(message, error)

        *<<<(message)
        *<<<(error)
        *<<<(message, error)

        !<<<(message)
        !<<<(error)
        !<<<(message, error)

        !!!<<<(message)
        !!!<<<(error)
        !!!<<<(message, error)
    }
}
