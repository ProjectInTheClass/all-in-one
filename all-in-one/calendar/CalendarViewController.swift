//
//  CalendarViewController.swift
//  all-in-one
//
//  Created by 강민성_소스 on 2022/06/06.
//

import UIKit
import EventKit
import EventKitUI

class CalendarViewController: UIViewController, EKEventViewDelegate {
    
    let store = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd(){
        /*
         let vc = EKCalendarChooser()
         vc.showCancelButton = true
         present(UINavigationController(rootViewController: vc), animated: true)
         */
        
        store.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil{
                DispatchQueue.main.async {
                    guard let store = self?.store else { return }
                    
                    let newEvent  = EKEvent(eventStore: store)
                    newEvent.title = "Events add1"
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
                    
                    let otherVC = EKEventEditViewController()
                    otherVC.eventStore = store
                    otherVC.event = newEvent
                    self?.present(otherVC,
                                  animated: true,
                                completion: nil)
//
//                    let vc = EKEventViewController()
//                    vc.delegate = self
//                    vc.event = newEvent
//                    let navVC = UINavigationController(rootViewController: vc)
//                    self?.present(navVC, animated: true)
//
                }
            }
        }
    
    }

    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        controller.dismiss(animated: false,completion: nil)
        
    }

}


