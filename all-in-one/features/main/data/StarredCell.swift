//
//  StarredCell.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/05.
//

import UIKit

class StarredCell: UITableViewCell {
    
    @IBOutlet weak var starTitle: UILabel!
    @IBOutlet weak var starPrice: UILabel!
    @IBOutlet weak var starUnit: UILabel!
    
    var cellTicker: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top:3.0, left: 0.0, bottom: 5.0, right: 0.0))
    }
    
    @IBAction func saveStatus(_ sender: UIButton) {
        sender.isSelected.toggle()
        UserDefaults.standard.set(sender.isSelected, forKey:cellTicker)
    }
    
}
