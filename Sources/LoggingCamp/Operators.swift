infix operator <<<
infix operator ?<<<
infix operator *<<<
infix operator !<<<
infix operator !!!<<<

prefix operator <<<
prefix operator ?<<<
prefix operator *<<<
prefix operator !<<<
prefix operator !!!<<<

prefix operator <<
postfix operator >>

public func <<<(lhs: Logger, rhs: Any) {
    lhs.debug(rhs)
}

public func <<<(lhs: String, rhs: Any) {
    Logger[lhs].debug(rhs)
}

public func <<<(lhs: Logger, rhs: Error) {
    lhs.debug("Application has encountered an error", rhs)
}

public func <<<(lhs: String, rhs: Error) {
    Logger[lhs].debug("Application has encountered an error", rhs)
}

public func <<<(lhs: Logger, rhs: (Any, Error)) {
    lhs.debug(rhs.0, rhs.1)
}

public func <<<(lhs: String, rhs: (Any, Error)) {
    Logger[lhs].debug(rhs.0, rhs.1)
}

public func ?<<<(lhs: Logger, rhs: Any) {
    lhs.info(rhs)
}

public func ?<<<(lhs: String, rhs: Any) {
    Logger[lhs].info(rhs)
}

public func ?<<<(lhs: Logger, rhs: Error) {
    lhs.info("Application has encountered an error", rhs)
}

public func ?<<<(lhs: String, rhs: Error) {
    Logger[lhs].info("Application has encountered an error", rhs)
}

public func ?<<<(lhs: Logger, rhs: (Any, Error)) {
    lhs.info(rhs.0, rhs.1)
}

public func ?<<<(lhs: String, rhs: (Any, Error)) {
    Logger[lhs].info(rhs.0, rhs.1)
}

public func *<<<(lhs: Logger, rhs: Any) {
    lhs.warn(rhs)
}

public func *<<<(lhs: String, rhs: Any) {
    Logger[lhs].warn(rhs)
}

public func *<<<(lhs: Logger, rhs: Error) {
    lhs.warn("Application has encountered an error", rhs)
}

public func *<<<(lhs: String, rhs: Error) {
    Logger[lhs].warn("Application has encountered an error", rhs)
}

public func *<<<(lhs: Logger, rhs: (Any, Error)) {
    lhs.warn(rhs.0, rhs.1)
}

public func *<<<(lhs: String, rhs: (Any, Error)) {
    Logger[lhs].warn(rhs.0, rhs.1)
}

public func !<<<(lhs: Logger, rhs: Any) {
    lhs.error(rhs)
}

public func !<<<(lhs: String, rhs: Any) {
    Logger[lhs].error(rhs)
}

public func !<<<(lhs: Logger, rhs: Error) {
    lhs.error("Application has encountered an error", rhs)
}

public func !<<<(lhs: String, rhs: Error) {
    Logger[lhs].error("Application has encountered an error", rhs)
}

public func !<<<(lhs: Logger, rhs: (Any, Error)) {
    lhs.error(rhs.0, rhs.1)
}   

public func !<<<(lhs: String, rhs: (Any, Error)) {
    Logger[lhs].error(rhs.0, rhs.1)
}

public func !!!<<<(lhs: Logger, rhs: Any) {
    lhs.fatal(rhs)
}

public func !!!<<<(lhs: String, rhs: Any) {
    Logger[lhs].fatal(rhs)
}

public func !!!<<<(lhs: Logger, rhs: Error) {
    lhs.fatal("Application has encountered an error", rhs)
}

public func !!!<<<(lhs: String, rhs: Error) {
    Logger[lhs].fatal("Application has encountered an error", rhs)
}

public func !!!<<<(lhs: Logger, rhs: (Any, Error)) {
    lhs.fatal(rhs.0, rhs.1)
}

public func !!!<<<(lhs: String, rhs: (Any, Error)) {
    Logger[lhs].fatal(rhs.0, rhs.1)
}

public prefix func <<<(rhs: Any) {
    Logger.default.debug(rhs)
}

public prefix func <<<(rhs: Error) {
    Logger.default.debug("Application has encountered an error", rhs)
}

public prefix func <<<(rhs: (Any, Error)) {
    Logger.default.debug(rhs.0, rhs.1)
}

public prefix func ?<<<(rhs: Any) {
    Logger.default.info(rhs)
}

public prefix func ?<<<(rhs: Error) {
    Logger.default.info("Application has encountered an error", rhs)
}

public prefix func ?<<<(rhs: (Any, Error)) {
    Logger.default.info(rhs.0, rhs.1)
}

public prefix func *<<<(rhs: Any) {
    Logger.default.warn(rhs)
}

public prefix func *<<<(rhs: Error) {
    Logger.default.warn("Application has encountered an error", rhs)
}

public prefix func *<<<(rhs: (Any, Error)) {
    Logger.default.warn(rhs.0, rhs.1)
}

public prefix func !<<<(rhs: Any) {
    Logger.default.error(rhs)
}

public prefix func !<<<(rhs: Error) {
    Logger.default.error("Application has encountered an error", rhs)
}

public prefix func !<<<(rhs: (Any, Error)) {
    Logger.default.error(rhs.0, rhs.1)
}

public prefix func !!!<<<(rhs: Any) {
    Logger.default.fatal(rhs)
}

public prefix func !!!<<<(rhs: Error) {
    Logger.default.fatal("Application has encountered an error", rhs)
}

public prefix func !!!<<<(rhs: (Any, Error)) {
    Logger.default.fatal(rhs.0, rhs.1)
}

public prefix func <<(rhs: Any) {
    print(rhs)
}

public postfix func >>(lhs: Any) -> String {
    print(lhs, terminator: ": ")
    return readLine() ?? ""
}