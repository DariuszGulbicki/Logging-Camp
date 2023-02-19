# Logging Camp

Logging Camp is a simple and customizable logging library written in Swift, designed to make it easy to add logging to your iOS, macOS, or tvOS application.

## Features

    Simple and lightweight
    Customizable logging levels
    Customizable log format
    Support for logging to console and file
    Thread-safe
    Open source and free to use

## Requirements

    iOS 10.0+ / macOS 10.12+ / tvOS 10.0+
    Xcode 11+
    Windows 10+
    Linux
    Swift 5.4+

## Installation

Logging Camp can be installed using Swift Package Manager.

In Xcode, go to File > Swift Packages > Add Package Dependency and enter the following URL:

```
https://github.com/yourusername/Logging-Camp.git
```

Alternatively, you can add the following to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/DariuszGulbicki/Logging-Camp.git", from: "1.0.0")
]
```

## Usage

Using Logging Camp is very simple. Here's an example:

```swift
import LoggingCamp

let logger = Logger(String(describing: type(of: self))

logger.debug("This is a debug message.")
logger.info("This is an info message.")
logger.warn("This is a warning message.")
logger.error("This is an error message.")
logger.fatal("This is a fatal message.")
```

The above code will create a new logger and log messages to the console.

You can customize the logging level and log format like this:

```swift
let logger = Logger()

logger.setLoggingLevel(.DEBUG)

logger.log(.DEBUG, "This is a debug message.")
```

Use different handlers and change application-wide logging level:

```swift
// Set global logging level
// This will only affect NEW loggers
// Calling logger.setLoggingLevel() will override this
LoggingCamp.setGlobalLoggingLevel(.DEBUG)

// Add handler
// Handlers are used to log messages to different destinations
// Logging Camp comes with a PrintLogHandler that logs to the console
// and ColorPrintLogHandler that logs to the console with colors
LoggingCamp.loadHandler("name", PrintLogHandler())

// Disable handler
// In this case, the default handler will be disabled
LoggingCamp.disableHandler("default")
```

You can also set enabled handlers with Logger itself:

```swift
// Set enabled loggers
let logger = Logger(String(describing: type(of: self), ["default", "myLogger"])

// Replace class name with custom name
let namedLogger = Logger("Example debug logger")
```

Custom log handlers can be created by subclassing Logger:

```swift
class MyLogHandler: LogHandler {
    
    public func log(_ level: LogLevel, _ message: String, _ caller: String, _ cause: Error?) {
        // Log message
    }

}
```

## Contributing

Logging Camp is open source and contributions are welcome. If you find a bug or have a feature request, please open an issue or submit a pull request.

## License

Logging Camp is released under the MIT license. See LICENSE for details.
