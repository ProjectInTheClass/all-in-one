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
    @IBOutlet var cellValue: UILabel!
    @IBOutlet var cellUnit: UILabel!
    var cellTicker: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func saveStatus(_ sender: UIButton) {
        sender.isSelected.toggle()
        UserDefaults.standard.set(sender.isSelected, forKey:cellTicker)
    }
}
