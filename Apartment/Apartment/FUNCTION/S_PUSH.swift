//
//  S_PUSH.swift
//  Kkumnamu
//
//  Created by 장 제현 on 2021/10/16.
//

import UIKit
import UserNotifications
import FirebaseMessaging

// MARK: PUSH 설정
extension UIViewController {
    
    func LOCALPUSH(TITLE: String, BODY: String) {
        
        let CHECK_CONTENT = UNMutableNotificationContent()
        CHECK_CONTENT.title = TITLE; CHECK_CONTENT.body = BODY; CHECK_CONTENT.sound = .default
        
        let TRIGGER = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let REQUEST = UNNotificationRequest(identifier: "local_notification", content: CHECK_CONTENT, trigger: TRIGGER)
        UNUserNotificationCenter.current().add(REQUEST)
    }
}

// MARK: PUSH 알림 설정
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // PUSH 받음
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let USERINFO = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(USERINFO)
        
        if let MESSAGE_ID = USERINFO[GCM_MSG_ID_KEY] { print("알림 받음 MESSAGE ID: \(MESSAGE_ID)") }
        
        print("알림 받음 userNotificationCenter", USERINFO)
        
        completionHandler([.alert, .sound, .badge])
    }
    
    // PUSH 누름
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let USERINFO = response.notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(USERINFO)
        
        if let MESSAGE_ID = USERINFO[GCM_MSG_ID_KEY] { print("알림 받음 MESSAGE ID: \(MESSAGE_ID)") }
        
        print("알림 누름 userNotificationCenter", USERINFO)
        
        let VC = STORYBOARD.instantiateViewController(withIdentifier: "VC_LOADING") as! VC_LOADING
        VC.ONOFF = true; VC.UPDATE = false; VC.PUSH = true
        VC.BD_KEY = USERINFO["gcm.notification.board_key"] as? String ?? ""
        VC.BD_TYPE = USERINFO["gcm.notification.board_type"] as? String ?? ""
        VC.FC_TYPE = USERINFO["gcm.notification.function_type"] as? String ?? ""
        VC.FC_NAME = USERINFO["gcm.notification.function_name"] as? String ?? ""
        VC.AP_SEQ = USERINFO["gcm.notification.ap_seq"] as? String ?? ""
        VC.AP_MSG_GROUP = USERINFO["gcm.notification.ap_msg_group"] as? String ?? ""
        let NC = UINavigationController(rootViewController: VC)
        NC.setNavigationBarHidden(true, animated: true)
        WINDOW?.rootViewController = NC
        
//        if STATE == .LOGOUT { AUTH_VIEW.removeFromSuperview(); LOGIN_AUTH(MODE: "BACKGROUND"); LOGIN_AUTH(MODE: "FOREGROUND") }
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("Firebase registration token: \(fcmToken ?? "-")")
        
        UserDefaults.standard.setValue("\(fcmToken ?? "-")", forKey: "gcm_id")
        UserDefaults.standard.synchronize()

        let DATADICT: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: DATADICT)
    }
}

extension AppDelegate {

    // PUSH 누름
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        let VC = STORYBOARD.instantiateViewController(withIdentifier: "VC_LOADING") as! VC_LOADING
        VC.ONOFF = false; VC.UPDATE = false; VC.PUSH = true
        VC.BD_KEY = userInfo["gcm.notification.board_key"] as? String ?? ""
        VC.BD_TYPE = userInfo["gcm.notification.board_type"] as? String ?? ""
        VC.FC_TYPE = userInfo["gcm.notification.function_type"] as? String ?? ""
        VC.FC_NAME = userInfo["gcm.notification.function_name"] as? String ?? ""
        VC.AP_SEQ = userInfo["gcm.notification.ap_seq"] as? String ?? ""
        VC.AP_MSG_GROUP = userInfo["gcm.notification.ap_msg_group"] as? String ?? ""
        let NC = UINavigationController(rootViewController: VC)
        NC.setNavigationBarHidden(true, animated: true)
        WINDOW?.rootViewController = NC
        
        completionHandler(.newData)
    }
}
