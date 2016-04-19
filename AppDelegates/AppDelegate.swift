import UIKit



/**
 The AppDelegate is the base application delegate for a VIPER application. This delegate provides NO push support
*/
public class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// The base window will be a tweak able window when it is configured by the -D Production flag
    //public var window: UIWindow? =  UIWindow() // TweakitShakeWindow(frame: UIScreen.mainScreen().bounds)

}

// MARK: - Application Lifecycle
public extension AppDelegate {
    
    // NOTE: You MUST call this after you bootstrap in your app delegate
    public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        logDebug("Application did Finish launching with options, options=\(launchOptions)")
        for daemon in DaemonManager.sharedInstance.daemonsForType(ApplicationDaemonType.self) {
            daemon.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
    
    public func applicationWillResignActive(application: UIApplication) {
        logDebug("Application will resign active")
        for daemon in DaemonManager.sharedInstance.daemonsForType(ApplicationDaemonType.self) {
            daemon.applicationWillResignActive(application)
        }
    }
    
    public func applicationDidEnterBackground(application: UIApplication) {
        logDebug("Application did enter background")
        for daemon in DaemonManager.sharedInstance.daemonsForType(ApplicationDaemonType.self) {
            daemon.applicationDidEnterBackground(application)
        }
    }
    
    public func applicationWillEnterForeground(application: UIApplication) {
        logDebug("Application will enter foreground")
        for daemon in DaemonManager.sharedInstance.daemonsForType(ApplicationDaemonType.self) {
            daemon.applicationWillEnterForeground(application)
        }
    }
    
    public func applicationDidBecomeActive(application: UIApplication) {
        logDebug("Application did become active")
        for daemon in DaemonManager.sharedInstance.daemonsForType(ApplicationDaemonType.self) {
            daemon.applicationDidBecomeActive(application)
        }
    }
    
    public func applicationWillTerminate(application: UIApplication) {
        logDebug("Application will terminate")
        for daemon in DaemonManager.sharedInstance.daemonsForType(ApplicationDaemonType.self) {
            daemon.applicationWillTerminate(application)
        }
    }
}

// MARK: - URL
public extension AppDelegate {
    public func application(application: UIApplication, openURL url: NSURL,
                            sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        logDebug("Application open url, url=\(url.path), query=\(url.query), scheme=\(url.scheme),"
            + " host=\(url.host), path=\(url.path), sourceApplication=\(sourceApplication)")
        
        let _url = Url(url: url, sourceApplication: sourceApplication)
        for daemon in DaemonManager.sharedInstance.daemonsForType(UrlDaemonType.self) {
            if let fragments = _url.matchUrlPathAndBuildFragments(daemon.urlHost, path: daemon.urlPath) {
                return daemon.handleUrl(url, fragments: fragments, queryParams: _url.paramsForQueryString())
            }
        }
        return false
    }
}

// MARK: - Local Notifications
public extension AppDelegate {
    
    public func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        guard let category = notification.category else {
            logWarn("Application did receive location notification without category")
            return
        }
        logDebug("Application did receive local notification, category=\(category),"
            + " userInfo=\(notification.userInfo)")
        
        for daemon in DaemonManager.sharedInstance.daemonsForType(LocalNotificationDaemonType.self) {
            if daemon.category == category {
                daemon.handleNotification(notification.userInfo as? [String:AnyObject])
                return
            }
        }
        logWarn("Application local notification daemon not found, category=\(category),"
            + " userInfo=\(notification.userInfo)")
    }
    
    public func application(application: UIApplication, handleActionWithIdentifier identifier: String?,
        forLocalNotification notification: UILocalNotification, completionHandler: () -> Void)
    {
        guard let category = notification.category else {
            logWarn("Application did receive local notification handle action with identifer without category")
            return
        }
        logDebug("Application did receive local notification handle action with identifer, category=\(category),"
            + " userInfo=\(notification.userInfo), identifier=\(identifier)")
        
        for daemon in DaemonManager.sharedInstance.daemonsForType(LocalActionNotificationDaemonType.self) {
            if daemon.category == category {
                daemon.handleActionWithIdentifier(identifier,
                                                  userInfo: notification.userInfo as? [String:AnyObject],
                                                  completionHandler: completionHandler)
                return
            }
        }

        logWarn("Application local notification daemon not found for action handler, category=\(category),"
            + " userInfo=\(notification.userInfo), identifier=\(identifier)")
        completionHandler()
    }
}

extension AppDelegate {
    
    /**
     This will be called by the app bootstrap which allows Viper to only know about AppDelegate
     and not the VoIP or RemoteNotification delegates. This is the easily solution of not including
     APNS implements by default in LocoViper2
     
     - parameter application: the application we are bootstrapping
     */
    func registerViperForRemoteNotifications(application: UIApplication) {
        // no-op
    }
    
    /**
     Will be invoked from either APNS or VoIP delegates when the push token has been delivered
     
     - parameter token: the push token
     */
    func deviceTokenRegistered(token: Token) {
        logDebug("Application device token registered, token=\(token)")
        for daemon in DaemonManager.sharedInstance.daemonsForType(DeviceDaemonType.self) {
            daemon.deviceTokenRegistered(token)
        }
    }
    
    /**
     Will be invoked by the APNS or VoIP delegates when a push notification is handled by the application. This will
     look up the correct daemon to handle the push notification
     
     - parameter userInfo:   the payload of the push
     - parameter completion: the completion callback
     */
    func handleRemoveNotification(userInfo: [NSObject:AnyObject], completion: (UIBackgroundFetchResult) -> Void) {
        
        if let userInfo = userInfo as? [String:AnyObject], let aps = userInfo["aps"] as? [String:AnyObject] {
            // Pushes from legacy systems may not have a category.  We support them
            // with this constant.  Only one daemon can have no category.
            var category = kRemoteNotificationNoCategory
            
            if let categoryFromPush = aps["category"] as? String {
                logDebug("Application did receive remove notification, category=\(category), userInfo=\(userInfo)")
                category = categoryFromPush
            } else {
                logDebug("Application did receive remove notification without category, userInfo=\(userInfo)")
            }
            // find daemon to handle push
            for daemon in DaemonManager.sharedInstance.daemonsForType(RemoteNotificationDaemonType.self) {
                if daemon.category == category {
                    daemon.handleNotification(userInfo, completion: completion)
                    return
                }
            }
        }
        logDebug("Application unable to handle remove notification, userInfo=\(userInfo)")
        completion(.NoData)
    }
}