//
//  EditViewController.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/08.
//
//

import UIKit
import Alamofire

class EditViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items: [Summary] = []
    
    let defaults = UserDefaults.standard
    var kimpLoaded = false

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "즐겨찾기"
        
        setupTableView()
        
        NotificationCenter.default.addObserver(self,selector: #selector(updateTable),name: NSNotification.Name(rawValue: "UpdateTable"),object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        kimpLoaded = false
        setData()
    }
    
    @objc func updateTable(){
        print("update!")
        items = []
        setData()
        tableView.reloadData()
    }
    
    func setData(){
        let starred = defaults.array(forKey: "star-index")
        print("starred: \(starred)")
        for ticker in starred! {
            getData(ticker: ticker as! String)
        }
    }
    
    func getData(ticker: String){
        let client = ApiClient3(controller: self)
        
        if(ticker == "USDKRW") {
            let param_usdkrw: Parameters = [
                "base": "KRW",
                "code": "USD"
            ]
            client.getDataFromManana(name: "USDKRW", parameters: param_usdkrw)
        }
        
        else if(ticker == "JPYKRW") {
            let param_jpykrw: Parameters = [
                "base": "KRW",
                "code": "JPY"
            ]
            client.getDataFromManana(name: "JPYKRW", parameters: param_jpykrw)
        }
        
        else if(ticker == "EURKRW") {
            let param_eurkrw: Parameters = [
                "base": "KRW",
                "code": "EUR"
            ]
            client.getDataFromManana(name: "EURKRW", parameters: param_eurkrw)
        }
        
        else if(ticker == "BTCUSD"){
            client.getDataFromBitfinex(name: ticker)
        }
        
        else if(ticker.prefix(3) == "KRW"){
            let param_upbit: Parameters = [
                "markets": ticker
            ]
            client.getDataFromUpbit(parameters: param_upbit)
        }
        
        else if(ticker == "금(GOLD)" || ticker == "은(SILVER)") {
            client.getDataFromGoldAPI(name: ticker)
        }
        
        
        else if(ticker == "김치프리미엄"){
            if !kimpLoaded{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                    client.getKorPremium(name: "김치프리미엄", kimp: client.kimp)
                    self.kimpLoaded = true
                }
            }
        }
        
        else if ticker.suffix(3) == ".KS"{
            client.getKstock(tickers: ticker)
        }
        
        else {
            client.getDataFromFinancialModeling(tickers:ticker)
        }
    }
}

extension EditViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath) as! EditCell
        
        
        let title = items[indexPath.row].title
        cell.cellTitle.text = title.count < 20 ? title : shortify(title)
        cell.cellTicker = items[indexPath.row].ticker
        
        return cell
    }
    
    func shortify(_ str: String) -> String{
        let endIdx: String.Index = str.index(str.startIndex, offsetBy: 19)
        return String(str[...endIdx]) + ".."
    }
}

extension EditViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
