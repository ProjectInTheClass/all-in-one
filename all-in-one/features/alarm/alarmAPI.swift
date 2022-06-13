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
          
            content.title = data.time + "알림입니다."
            
            content.body = "지금 정보를 확인해보세요"
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
            let dataKey = "Row:" + String(isNewOrRowNumber)
            //date = convertDate
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

            let request = UNNotificationRequest(identifier: dataKey, content: content, trigger: trigger)

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
struct alarmData :Codable {
    var isOn :Bool
    var name :String
    var time :String
}

var isNewOrRowNumber :Int = -1 // if it is first of list -1 or return IndexRowNumber
var allAlarmOn :Bool = true // remote all alarm on/off
let userdefault = UserDefaults.standard

var alarmDataList :[alarmData] = []

func initData() {
    userdefault.set([], forKey: "alarmIsOn")
    userdefault.set([], forKey: "alarmTime")
    userdefault.set([], forKey: "alarmName")
    //userdefault.set([], forKey: "alarmList")
}

func getData() {
    guard let boolList = userdefault.array(forKey: "alarmIsOn") else {
        return
    }
    let nameList = userdefault.array(forKey: "alarmName") as! [String]
    let timeList = userdefault.array(forKey: "alarmTime") as! [String]

    let maxNum = boolList.count
    var tempDataList :[alarmData] = []
    for num in 0..<maxNum {
        let tempData = alarmData(isOn: boolList[num] as! Bool, name: nameList[num], time: timeList[num])
        tempDataList.append(tempData)
    }
    alarmDataList = tempDataList
    
//    //json decode
//    if userdefault.object(forKey: "alarmList") != nil {
//        if let data = userdefault.value(forKey: "alarmList") as? Data {
//            let encodedData = try? PropertyListDecoder().decode(alarmDataList.self, from: data)
//
//        }
//    }
    
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
//    //json encoding
//    if let encodedData = try? PropertyListEncoder().encode(alarmDataList) {
//        userdefault.set(encodedData, forKey: "alarmList")
//    }
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
    getData()
    //viewwillappear에서 동작하도록 설정
    let newAlarmData = alarmData(isOn: isOn, name: name, time: time)
    if isNewOrRowNumber<0 {
        alarmDataList.append(newAlarmData)
        isNewOrRowNumber = alarmDataList.count-1
        saveData()
    } else {
        let identifier = ["Row:"+String(isNewOrRowNumber)]
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifier)
        alarmDataList[isNewOrRowNumber] = newAlarmData
        saveData()
    }
    sendLocalNotification(data: newAlarmData)
}

func removeAlarmData(num: Int) {
    getData()
    let identifier = ["Row:"+String(num)]
    alarmDataList.remove(at: num)
    notificationCenter.removePendingNotificationRequests(withIdentifiers: identifier)
    saveData()
}

func allAlarmOnFunc() {
    getData()
    allAlarmOn = true
    for data in alarmDataList {
        if data.isOn {
            sendLocalNotification(data: data)
        }
    }
}

func allAlarmOffFunc() {
    allAlarmOn = false
    notificationCenter.removeAllPendingNotificationRequests()
}

func alarmOnFunc(num :Int) {
    getData()
    alarmDataList[num].isOn = true
    sendLocalNotification(data: alarmDataList[num])
    saveData()
}

func alarmOffFunc(num :Int) {
    getData()
    let identifier = ["Row:"+String(num)]
    alarmDataList[num].isOn = false
    notificationCenter.removePendingNotificationRequests(withIdentifiers: identifier)
    saveData()
}
