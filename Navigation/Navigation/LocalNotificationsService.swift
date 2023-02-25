//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Андрей Васильев on 21.02.2023.
//

import Foundation
import UserNotifications
import UIKit


class LocalNotificationsService: NSObject, UNUserNotificationCenterDelegate {

    let center = UNUserNotificationCenter.current()

    func registerForLatestUpdatesIfPossible() {

        registerUpdatesCategory()
        
        let identifier = UUID().uuidString
        print(identifier)
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { granted, error in

            if granted == true {

                let contentRequest: UNMutableNotificationContent = {
                    
                    let content = UNMutableNotificationContent()
                    content.title = "localNotificationsServiceContentTitle".localized
                    content.body = "localNotificationsServiceContentTitle".localized
                    content.sound = .defaultRingtone
                    DispatchQueue.main.sync {
                        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
                    }
                    content.categoryIdentifier = "updates"
                    content.userInfo = ["CustomData": "qwerty"]
                    return content
                }()

                let dateComponents: DateComponents = {
                    var components = DateComponents()
                    components.hour = 19
                    components.minute = 00
                    return components
                }()
                //                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: identifier, content: contentRequest, trigger: trigger)
                self.center.delegate = self
                self.center.add(request)
            }

            if let error = error {
                print(error.localizedDescription)
            }
            
        }

    }

    func registerUpdatesCategory() {

        let actionHide = UNNotificationAction(identifier: "Hide", title: "localNotificationsServiceContentActionHide".localized, options: .foreground)
        let category = UNNotificationCategory(identifier: "updates", actions: [actionHide], intentIdentifiers: [])
        let categories: Set<UNNotificationCategory> = [category]
        center.setNotificationCategories(categories)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let customData = userInfo["CustomData"] as? String {
            print("Custom data received: \(customData)")
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Default Identifier")
            case "Hide":
                UIApplication.shared.applicationIconBadgeNumber = 0
                print("Скидышь")
            default:
                break
            }
        }
        completionHandler()
    }

}
