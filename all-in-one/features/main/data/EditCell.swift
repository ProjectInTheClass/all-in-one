//
//  EditCell.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/08.
//

import UIKit

class EditCell : UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    var cellTicker: String!
    let defaults = UserDefaults.standard
    
    @IBAction func deleteStar(_ sender: Any) {
        defaults.set(false, forKey: cellTicker)
        
        var starred: [String] = defaults.array(forKey: "star-index") as! [String]
        
        for (index,star) in starred.enumerated() {
            if star == cellTitle.text {
                starred.remove(at: index)
                defaults.set(starred, forKey: "star-index")
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTable"), object: "message")
                
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
