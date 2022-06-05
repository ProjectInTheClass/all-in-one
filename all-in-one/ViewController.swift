//
//  ViewController.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/03.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var Btn_All: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Btn_All.layer.cornerRadius = 10
        Btn_All.layer.borderWidth = 1.5
        Btn_All.layer.borderColor = UIColor.black.cgColor
    }
}
