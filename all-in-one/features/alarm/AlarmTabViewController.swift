//
//  alarmTabViewController.swift
//  all-in-one
//
//  Created by 구본규 on 2022/05/26.
//

import UIKit

class AlarmTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {    
    @IBOutlet weak var allOnOff: UISwitch!
    @IBOutlet weak var alarmTableView: UITableView!
    @IBOutlet weak var plusButton: UIImageView!
    
    override func viewDidLoad() {
        //sendLocalNotification(seconds: 1.0, data: alarmList[0])
        super.viewDidLoad()
        //sendLocalNotification(seconds: 1.0, data: alarmList[0])
        // Do any additional setup after loading the view.
        let tapPlusButton = UITapGestureRecognizer(target: self, action: #selector(plusButtonAction(tapPlusButton:)))
        plusButton.isUserInteractionEnabled = true
        plusButton.addGestureRecognizer(tapPlusButton)
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        //getData()
        self.registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alarmTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            cell.title.text = alarmDataList[indexPath.row].name
            cell.mainMessage.text = alarmDataList[indexPath.row].time
            
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
        isNew = indexPath.row
        self.present(datePicker, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let action = UIContextualAction(style: .normal, title: "삭제") { (action, view, completion) in
           tableView.deleteRows(at: [indexPath], with: .automatic)
           completion(true)
        }
        
        action.backgroundColor = .red
        //action.image = #imageLiteral(resourceName: "DeleteIcon")
        
        //delete data
        
        removeAlarmData(num: indexPath.row)
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    @objc func plusButtonAction(tapPlusButton :UITapGestureRecognizer) {
        requestNotificationAuthorization()
        // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
        guard let datePicker = storyboard?.instantiateViewController(identifier: "DatePicker") else {
            return
        }
        
        isNew = -1
        self.present(datePicker, animated: true)
        alarmTableView.reloadData()
    }

    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.alarmTableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
    @IBAction func allOnOff(_ sender: UISwitch){
        if allOnOff.isOn{
            allAlarmOnFunc()
        }
        else{
            allAlarmOff()
        }
    }
   
}

