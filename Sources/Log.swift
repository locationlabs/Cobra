

final public class Log {
    public static var enableDebugging = false
}

func logDebug(_ message: @autoclosure () -> String) {
    if Log.enableDebugging {
        NSLog("[Cobra] \(message())")
    }
}
