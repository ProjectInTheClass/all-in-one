//
//  NewsCellTableViewCell.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/06.
//

import UIKit

class NewsCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
