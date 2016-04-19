import UIKit


/**
 The APNSAppDelegate is a VIPER app delegate that supports standard push via APNS. Your application must be configured
 to receive standard APNS push in order to use this app delegate properly
*/
public class APNSAppDelegate: AppDelegate {
    
    override public func registerViperForRemoteNotifications(application: UIApplication) {
        application.registerForRemoteNotifications()
        logDebug("Application will use APNS when push notifications are registered")
    }
}

// MARK: - APNS
extension APNSAppDelegate {
    
    public func application(application: UIApplication,
        didReceiveRemoteNotification userInfo: [NSObject : AnyObject],
        fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void)
    {
        handleRemoveNotification(userInfo, completion: completionHandler)
    }
    
    public func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let token = Token(token: deviceToken, origin: .APNS)
        deviceTokenRegistered(token)
    }
    
    public func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        // called on simulator or if app is not signed properly, nothing to handle at run time
        logDebug("Application failed to register for remove notifications, error=\(error)")
    }
}