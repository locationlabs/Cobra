import UIKit
import PushKit


/**
 The VoIPAppDelegate is VIPER app delegate that supports push notifications via PushKit. Your application must be
 configured to receive VoIP pushes in order to leverage this app delegate
*/
public class VoIPAppDelegate: AppDelegate {
    
    private var voipRegistry: PKPushRegistry!
    
    // MARK: ViperAppDelegate overrides
    
    override public func registerViperForRemoteNotifications(application: UIApplication) {
        registerVoIP()
        application.registerForRemoteNotifications()
    }
    
    /**
     Will reigster for VoIP push notifications
     */
    private func registerVoIP() {
        voipRegistry = PKPushRegistry(queue: dispatch_get_main_queue())
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = Set(arrayLiteral: PKPushTypeVoIP)
        logDebug("Application will use VoIP when push notifications are registered")
    }
    
}

// MARK: - PKPushRegistryDelegate
extension VoIPAppDelegate: PKPushRegistryDelegate {
    
    public func pushRegistry(registry: PKPushRegistry!, didUpdatePushCredentials credentials: PKPushCredentials!, forType type: String!) {
        let token = Token(token: credentials.token, origin: .PushKit)
        deviceTokenRegistered(token)
    }
    
    public func pushRegistry(registry: PKPushRegistry!, didReceiveIncomingPushWithPayload payload: PKPushPayload!, forType type: String!) {
        handleRemoveNotification(payload.dictionaryPayload) { _ in
            // no-op
        }
    }
    
    public func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        // called on simulator or if app is not signed properly, nothing to handle at run time
        logError("Application failed to register for remove notifications, error=\(error)")
    }
}