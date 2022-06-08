//
//  DatePickerViewController.swift
//  all-in-one
//
//  Created by 구본규 on 2022/06/07.
//

import UIKit

class DatePickerController:UIViewController {

    // selector 생성하기!!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    //    let timeSelector: Selector = #selector(DatePickerController.updateTime)
//    let interval = 1.0
    
    
    var name = "kospi"
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
        newAlarmData(isOn: true, name: name, time: dateTime)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
