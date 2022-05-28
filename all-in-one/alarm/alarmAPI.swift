//
//  alarmAPI.swift
//  all-in-one
//
//  Created by 구본규 on 2022/05/26.
//
import UserNotifications

let notificationCenter = UNUserNotificationCenter.current()

func requestNotificationAuthorization() {
    let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]

    notificationCenter.requestAuthorization(options: authOptions) { success, error in
        if let error = error {
            print(error)
        }
    }
}

func sendLocalNotification(seconds :Double, data :EconomyIndex) {
//    notificationCenter.removeAllPendingNotificationRequests()

    //알림이 허가되었는지 확인
    notificationCenter.getNotificationSettings() {setting in
        if setting.authorizationStatus == UNAuthorizationStatus.authorized {
            let content = UNMutableNotificationContent()
            content.title = data.name
            content.subtitle = String(data.time.hour!) + ":" + String(data.time.minute!)
            content.body = "변동 폭:" + String(data.range)
            //content.userInfo
            //title, subtitle, body, badge, sound

            let trigger = UNTimeIntervalNotificationTrigger( timeInterval: seconds, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        //    if UserDefaults.standard.bool(forKey: "wantAlarm") {
        //        notificationCenter.add(request) { (error) in
        //            if error != nil {
        //                // handle errors
        //            }
        //        }
        //    }
            notificationCenter.add(request)
        }
    }
}
