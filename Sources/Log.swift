

final public class Log {
    public static var enableDebugging = false
}

func logDebug(@autoclosure message: () -> String) {
    if Log.enableDebugging {
        NSLog("[Cobra] \(message())")
    }
}
