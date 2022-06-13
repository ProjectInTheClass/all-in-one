//
//  alarmTabViewController.swift
//  all-in-one
//
//  Created by 구본규 on 2022/05/26.
//

import UIKit

class AlarmTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var alarmTableView: UITableView!
    @IBOutlet weak var allOnOff: UISwitch!
    @IBOutlet weak var addAlarmButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveReloadNotification(_:)), name: NSNotification.Name("ReloadPage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveAlarmNotification(_:)), name: NSNotification.Name("AllAlarmOn"), object: nil)
        getData()
        //알림 누를 경우 main page open
        NotificationCenter.default.addObserver(self, selector: #selector(didMainPageOpen(_:)), name: NSNotification.Name("MainPage"), object: nil)

        allOnOff.isOn = allAlarmOn
        self.registerTableViewCells()
    }
    
    @objc func didMainPageOpen(_ notification: Notification) {
        // 스토리 보드 객체 가져오기 (인자 : 이름, 읽어들일 위치)
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
        guard let main = storyboard?.instantiateViewController(withIdentifier: "Main") else {
            return
        }
        self.present(main, animated: true)
    }
    
//    @objc func didTabAddButton() {
//        notificationCenter.getNotificationSettings() {setting in
//                    if setting.authorizationStatus == UNAuthorizationStatus.authorized {
//
//                    } else {
//                        requestNotificationAuthorization()
//                    }
//                }
//                // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
//                guard let datePicker = storyboard?.instantiateViewController(identifier: "DatePicker") else {
//                    return
//                }
//
//                isNewOrRowNumber = -1
//                self.present(datePicker, animated: true)
//    }
//
    @objc func didRecieveAlarmNotification(_ notification: Notification) {
        let getValue = notification.object as! Int
        let alert = UIAlertController(title: "알람", message: "모든 알람이 꺼져있습니다.\n 모든 알람을 켜시겠습니까?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
           
            allAlarmOnFunc()
            allAlarmOn = true
            self.allOnOff.isOn = allAlarmOn
            alarmOnFunc(num: getValue)
            self.alarmTableView.reloadData()
        }
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
    
    
    @objc func didRecieveReloadNotification(_ notification: Notification) {
        alarmTableView.reloadData()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        allOnOff.isOn = allAlarmOn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            //cell.title.text = alarmDataList[indexPath.row].name
            cell.mainMessage.text = alarmDataList[indexPath.row].time
            cell.thisIndexPathRow = indexPath.row
            if allAlarmOn {
                cell.cellOnOffSwitch.isOn = alarmDataList[indexPath.row].isOn
            } else {
                cell.cellOnOffSwitch.isOn = allAlarmOn
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //cell 높이
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //보여줄 행의 개수
        return alarmDataList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 스토리 보드 객체 가져오기 (인자 : 이름, 읽어들일 위치)
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
        guard let datePicker = storyboard?.instantiateViewController(withIdentifier: "DatePicker") else {
            return
        }
        isNewOrRowNumber = indexPath.row
        self.present(datePicker, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//       let action = UIContextualAction(style: .normal, title: "삭제") { (action, view, completion) in
//           tableView.deleteRows(at: [indexPath], with: .automatic)
//           completion(true)
//        }
//
//        action.backgroundColor = .red
//        //action.image = #imageLiteral(resourceName: "DeleteIcon")
//
//        //delete data
//
//        removeAlarmData(num: indexPath.row)
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//        configuration.performsFirstActionWithFullSwipe = false
//        return configuration
//    }
//
    
    @IBAction func addButtonAction(_ sender: Any) {
        notificationCenter.getNotificationSettings() {setting in
                    if setting.authorizationStatus == UNAuthorizationStatus.authorized {

                    } else {
                        requestNotificationAuthorization()
                    }
                }
                // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
                guard let datePicker = storyboard?.instantiateViewController(identifier: "DatePicker") else {
                    return
                }

                isNewOrRowNumber = -1
                self.present(datePicker, animated: true)
    }
    
//    @IBAction func plusButtonAction(_ sender: Any) {
        
//    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.alarmTableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    @IBAction func allOnOff(_ sender: UISwitch){
        if allAlarmOn{
            allAlarmOn = false
            allAlarmOffFunc()
        }
        else{
            allAlarmOn = true
            allAlarmOnFunc()
        }
        alarmTableView.reloadData()
    }
   
}

func reloadPageSignal() {
    NotificationCenter.default.post(name: NSNotification.Name("ReloadPage"), object: nil, userInfo: nil)
}

func alertPageSignal(num :Int) {
    NotificationCenter.default.post(name: NSNotification.Name("AllAlarmOn"), object: num, userInfo: nil)
}
