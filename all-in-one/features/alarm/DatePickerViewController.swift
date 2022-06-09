//
//  DatePickerViewController.swift
//  all-in-one
//
//  Created by 구본규 on 2022/06/07.
//

import UIKit

class DatePickerController:UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    // selector 생성하기!!
//    let timeSelector: Selector = #selector(DatePickerController.updateTime)
//    let interval = 1.0
    
    func namedata() -> String {
        var name :String = ""
       
        let stroyBoard = MainViewController()
        let starArray = stroyBoard.items
        return name
    }
    
    var dateTime :String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
//        guard let alarmTab = storyboard?.instantiateViewController(withIdentifier: "AlarmTab") else {
//            return
//        }

    }

    @IBAction func datePickerView(_ sender: UIDatePicker) {
        let time = DateFormatter()
        time.dateFormat = "aa hh:mm"
        dateTime = time.string(from: sender.date)
    }

    @IBAction func saveButton(_ sender: UIButton) {
        newAlarmData(isOn: true, name: namedata(), time: dateTime)
        reloadPageSignal()
        dismiss(animated: true)
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

