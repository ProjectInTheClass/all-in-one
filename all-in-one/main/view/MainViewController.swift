//
//  ViewController.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/03.
//

import UIKit
import Toast_Swift

class MainViewController: UIViewController {
    var items: [Summary] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Btn_All: UIButton!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFirstTime() {
            self.view.makeToast("즐겨찾기 종목을 등록하면 바로 확인할 수 있어요!", duration: 1.0, position: .center)
        }
        
        Btn_All.layer.cornerRadius = 10
        Btn_All.layer.borderWidth = 1.5
        Btn_All.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let starred = defaults.array(forKey: "star-index")
        for ticker in starred! {
            print(ticker)
            getData(ticker: ticker as! String)
        }
    }
    
    func isFirstTime() -> Bool {
            if defaults.object(forKey: "star-index") == nil {
                defaults.set([], forKey:"star-index")
                return true
            } else {
                return false
            }
        }
    
    func getData(ticker: String){
        let client = ApiClient2(controller: self)
        client.getDataFromBitfinex(name: ticker)
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarredCell", for: indexPath) as! StarredCell
        
        cell.starTitle.text = items[indexPath.row].title
        cell.starUnit.text = items[indexPath.row].unit
        cell.starPrice.text = items[indexPath.row].value
        cell.cellTicker = items[indexPath.row].ticker
        
        return cell
    }
}

extension MainViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
