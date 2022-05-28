//
//  alarmTabViewController.swift
//  all-in-one
//
//  Created by 구본규 on 2022/05/26.
//

import UIKit

class AlarmTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var alarmTableView: UITableView!
    
    override func viewDidLoad() {
        sendLocalNotification(seconds: 1.0, data: alarmList[1])
        super.viewDidLoad()
        //sendLocalNotification(seconds: 1.0, data: alarmList[0])
        // Do any additional setup after loading the view.
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        self.registerTableViewCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //보여줄 행의 개수
        return alarmList.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = alarmTableView.dequeueReusableCell(withIdentifier: "alarmTableViewCell") else {
//            fatalError("unknown cell!\n")
//        }
//        cell.textLabel?.text = String(alarmList[indexPath.row].name) + String(alarmList[indexPath.row].range) + "변동했습니다."
//
//        return cell
//    }
//
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.alarmTableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
}

