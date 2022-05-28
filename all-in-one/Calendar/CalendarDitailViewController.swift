//
//  CalendarDitailViewController.swift
//  all-in-one
//
//  Created by 강민성_소스 on 2022/05/28.
//

import UIKit

class CalendarDitailViewController: UIViewController {
    var date: String!
    var myText: String!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
  //  @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateLabel.text = date
        self.titleLabel.text = myText
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
