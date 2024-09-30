//
//  AppDelegate.swift
//  DodamDodam
//
//  Created by dgsw8th61 on 9/19/24.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import DIContainer
import Domain

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    // 앱이 켜졌을 때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // Setting Up Notifications...
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // Setting Up Cloud Messaging...
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("✅ AppDelegate.application.didRegisterForRemoteNotificationsWithDeviceToken - apnsToken \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
}

// Cloud Messaging...
extension AppDelegate: MessagingDelegate {
    
    // fcm 등록 토큰이 갱신되었을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken else {
            print("❌ AppDelegate.messaging.didReceiveRegistrationToken - FCM token is nil")
            return
        }
        print("✅ AppDelegate.Fmessaging.didReceiveRegistrationToken - fcmToken \(fcmToken)")
    }
}

// User Notifications...[AKA InApp Notification...]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져 있을 때 나올 때
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        
        // Do Something With MSG Data...
        if let messageID = userInfo[gcmMessageIDKey] {
            print("✅ AppDelegate.userNotificationCenter.didReceive - Message ID: \(messageID)")
        }
        print("✅ AppDelegate.userNotificationCenter.didReceive - \(userInfo)")
        
        return if #available(iOS 14.0, *) {
            [[.list, .banner, .sound]]
        } else {
            [[.alert, .sound]]
        }
    }
    
    // 푸시메세지를 받았을 떄
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        let userInfo = response.notification.request.content.userInfo
        
            // Do Something With MSG Data...
        if let messageID = userInfo[gcmMessageIDKey] {
            print("✅ AppDelegate.userNotificationCenter.didReceive - Message ID: \(messageID)")
        }
        print("✅ AppDelegate.userNotificationCenter.didReceive - \(response)")
    }
}
