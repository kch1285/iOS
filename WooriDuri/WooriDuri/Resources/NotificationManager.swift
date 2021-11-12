//
//  NotificationManager.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/12.
//

import Foundation
import UserNotifications
import UserNotifications

final class NotificationManager {
    static func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    static func sendNotification(_ title: String, subtitle: String, body: String, seconds: Double) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = title
        notificationContent.body = body
        notificationContent.subtitle = subtitle
        notificationContent.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
