import XCTest
@testable import LoggingCamp

final class LoggingCampTests: XCTestCase {

    func testLogger() throws {
        LoggingConfig.setDefaultLoggingLevel(.debug)
        let logger = Logger("test")
        logger.setEnabledHandlers(["default"])

        XCTAssertEqual(logger.getId(), "test")
        XCTAssertEqual(logger.getEnabledHandlers(), ["default"])

        logger.debug("This is a debug message")
        logger.info("This is an info message")
        logger.warn("This is a warning message")
        logger.error("This is an error message")
        logger.fatal("This is a fatal message")
    }

    func testLoggingPool() throws {
        let logger = Logger("test")
        let loggingPool = LoggerPool("new")

        loggingPool.addLogger(logger)

        XCTAssertEqual(loggingPool.getLoggers().count, 1)
        XCTAssertEqual(loggingPool["test"].getId(), "test")

        loggingPool["newLogger"].info("New logger created")

        loggingPool.loggingLevel = .debug

        XCTAssertEqual(loggingPool.loggingLevel, .debug)
        XCTAssertEqual(loggingPool.getLoggers().count, 2)

        loggingPool.debug("This is a debug message")
        loggingPool.info("This is an info message")
        loggingPool.warn("This is a warning message")
        loggingPool.error("This is an error message")
        loggingPool.fatal("This is a fatal message")

        loggingPool.removeAll()

        XCTAssertEqual(loggingPool.getLoggers().count, 0)
    }

    func testOperators() throws {
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
