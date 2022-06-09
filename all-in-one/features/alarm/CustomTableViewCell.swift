//
//  CustomTableViewCell.swift
//  all-in-one
//
//  Created by 구본규 on 2022/05/26.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var thisIndexPathRow :Int = -1

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var mainMessage: UILabel!
    
    @IBOutlet weak var deleteCell: UIImageView!
    
    @IBAction func cellOnOffSwitch(_ sender: UISwitch) {
        //cell on/off switch
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapDeleteButton = UITapGestureRecognizer(target: self, action: #selector(deleteButtonAction(tapDeleteButton:)))
        deleteCell.isUserInteractionEnabled = true
        deleteCell.addGestureRecognizer(tapDeleteButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    
    }
    
    @objc func deleteButtonAction(tapDeleteButton :UITapGestureRecognizer) {
        removeAlarmData(num: thisIndexPathRow)
        reloadPageSignal()
    }
    
}
