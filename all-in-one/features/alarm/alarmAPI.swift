//
//  alarmAPI.swift
//  all-in-one
//
//  Created by 구본규 on 2022/05/26.
//
import UserNotifications
import UIKit

let notificationCenter = UNUserNotificationCenter.current()

func requestNotificationAuthorization() {
    let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
    initData()
    notificationCenter.requestAuthorization(options: authOptions) { success, error in
        if let error = error {
            print(error)
        }
    }
}

func sendLocalNotification(data :alarmData) {
//    notificationCenter.removeAllPendingNotificationRequests()

    //알림이 허가되었는지 확인
    notificationCenter.getNotificationSettings() {setting in
        if setting.authorizationStatus == UNAuthorizationStatus.authorized {
            let content = UNMutableNotificationContent()
            content.title = data.name
            content.subtitle = "지금 정보를 확인해보세요"
            
            content.body = data.time + "알림입니다."
            //content.userInfo
            //title, subtitle, body, badge, sound
            
            
            let timeDate = DateFormatter()
            timeDate.dateFormat = "HH-mm"
            let convertDate = data.time
            //let timeList = convertDate.split(separator: "-")
            
            var date = DateComponents()
            date.hour = Int(convertDate.prefix(2))
            date.minute = Int(convertDate.suffix(2))
            //let date = Calendar.current.dateComponents([.hour, .minute], from: convertDate ?? <#default value#>!)

            //date = convertDate
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

            let request = UNNotificationRequest(identifier: data.name, content: content, trigger: trigger)

//            if UserDefaults.standard.bool(forKey: "wantAlarm") {
//                notificationCenter.add(request) { (error) in
//                    if error != nil {
//                        // handle errors
//                    }
//                }
//            }
            notificationCenter.add(request)
        }
    }
}

//alarm struct
struct alarmData {
    var isOn :Bool
    var name :String
    var time :String
}

var isNew :Int = -1
var allAlarmOn :Bool = true
let userdefault = UserDefaults.standard

var alarmDataList :[alarmData] = []//default = 0

func initData() {
    userdefault.set([], forKey: "alarmIsOn")
    userdefault.set([], forKey: "alarmTime")
    userdefault.set([], forKey: "alarmName")
    //userdefault.set([], forKey: "alarmList")
}

func getData() {
    let boolList = userdefault.array(forKey: "alarmIsOn") as! [Bool]
    let nameList = userdefault.array(forKey: "alarmName") as! [String]
    let timeList = userdefault.array(forKey: "alarmTime") as! [String]
   
    let maxNum = boolList.count
    var tempDataList :[alarmData] = []
    for num in 0..<maxNum {
        let tempData = alarmData(isOn: boolList[num], name: nameList[num], time: timeList[num])
        tempDataList.append(tempData)
    }
    alarmDataList = tempDataList
}

func saveData() {
    var boolList :[Bool] = []
    var nameList :[String] = []
    var timeList :[String] = []
    for data in alarmDataList {
        boolList.append(data.isOn)
        nameList.append(data.name)
        timeList.append(data.time)
    }
    userdefault.set(boolList, forKey: "alarmIsOn")

    userdefault.set(timeList, forKey: "alarmTime")

    userdefault.set(nameList, forKey: "alarmName")
}

//func arraySaveToUserDefaults() {
//    //encoding
//    var userDefaults = UserDefaults.standard
//    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: alarmDataList)
//    userDefaults.set(encodedData, forKey: "alarmList")
//    userDefaults.synchronize()
//
//    let decoded  = userDefaults.data(forKey: "alarmList")
//    let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [alarmData]
//}
//

func newAlarmData(isOn :Bool, name :String, time :String) {
    //viewwillappear에서 동작하도록 설정
    let newAlarmData = alarmData(isOn: isOn, name: name, time: time)
    if isNew<0 {
        alarmDataList.append(newAlarmData)
        saveData()
    } else {
        alarmDataList[isNew] = newAlarmData
        saveData()
    }
    sendLocalNotification(data: newAlarmData)
}

func removeAlarmData(num: Int) {
    //alarmDataList[num] delete
    
    //let tempAlarm = alarmDataList[num]
//    var i = num
//    while i<alarmDataList.count-2 {
//        alarmDataList[i] = alarmDataList[i+1]
//        i+=1
//    }
    alarmDataList.remove(at: num)
    //removePendingNotificationRequests(tempAlarm.name)
}

func allAlarmChange() ->Bool {
    if allAlarmOn {
        allAlarmOn = true
        return allAlarmOn
    } else {
        allAlarmOn = false
        return allAlarmOn
    }
}

func allAlarmOnFunc() {

}

func allAlarmOff() {
    //cancelAllLocalNotifications()
}
