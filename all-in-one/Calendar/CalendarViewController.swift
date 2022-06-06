//
//  CalendarViewController.swift
//  all-in-one
//
//  Created by 강민성_소스 on 2022/06/06.
//

import UIKit
import EventKit
import EventKitUI
import SafariServices

class CalendarViewController: UIViewController, EKEventEditViewDelegate {
    
    @IBOutlet weak var economyTable: UITableView!
    var ecoItems: [News] = []
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        controller.dismiss(animated: false,completion: nil)
    }
    
    let store = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "뉴스 캘린더"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        self.economyTable.delegate = self
        self.economyTable.dataSource = self
        
        NewsApi(controller: self).getDataFromNewsApi()
        
    }
    @objc func didTapAdd(){
        store.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil{
                DispatchQueue.main.async {
                    guard let store = self?.store else { return }
                    
                    let newEvent  = EKEvent(eventStore: store)
                    newEvent.title = "이벤트1"
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
                    
                    let eventView = EKEventEditViewController()
                    eventView.editViewDelegate = self
                    eventView.eventStore = store
                    eventView.event = newEvent
                    
                    self?.present(eventView, animated: true, completion: nil)
                }
            }
        }
    }
}

extension CalendarViewController : UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ecoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCellTableViewCell
        
        cell.cellTitle.text = ecoItems[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsUrl = URL(string: ecoItems[indexPath.row].url)   else { return }

        let safariViewController = SFSafariViewController(url: newsUrl)
        safariViewController.delegate = self
        safariViewController.modalPresentationStyle = .automatic
        self.present(safariViewController, animated: true, completion: nil)
    }
}
