//
//  SummaryTableViewCell.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/22.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet var cellStar: UIButton!
    @IBOutlet var cellTitle: UILabel!
    var cellTicker: String!
    
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func saveStatus(_ sender: UIButton) {
        sender.isSelected.toggle()
        defaults.set(sender.isSelected, forKey:cellTicker)
        
        var starred: [String] = defaults.array(forKey: "star-index")! as! [String]

        if sender.isSelected {
            starred.append(cellTicker)
        }
        else {
            for (index,star) in starred.enumerated() {
                if star == cellTicker {
                    starred.remove(at: index)
                    break
                }
            }
        }
        
        defaults.set(starred, forKey:"star-index")
    }
}
