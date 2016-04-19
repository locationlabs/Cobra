

final public class Cobra {
    public static var enableDebugging = false
}

func logDebug(@autoclosure message: () -> String) {
    if Cobra.enableDebugging {
        NSLog("[Cobra] \(message())")
    }
}