//
//  AddViewController.swift
//  all-in-one
//
//  Created by 강민성_소스 on 2022/05/28.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var addTitle: UITextField!
    
    @IBOutlet weak var addSub: UITextField!
    
    var date : String!
    var dataArr :Array<AddData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func buttonAdd( _sender: UIButton){
        let addData : AddData = AddData(
            date: date,
            title: addTitle.text!,
            sub: addSub.text!
        )
        dataArr.append(addData)
        
        //버튼 누르면 창닫기
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
