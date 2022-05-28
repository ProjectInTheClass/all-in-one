//
//  ViewController.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/03.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [Summary] = []
    
    var kimp = [
        "btcusd": 0.0,
        "btckrw": 0.0,
        "rate": 0.0
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // USDKRW
        let param_usdkrw: Parameters = [
            "base": "KRW",
            "code": "USD"
        ]
        getDataFromManana(name: "USD/KRW", parameters: param_usdkrw)
        
        // JPYKRW
        let param_jpykrw: Parameters = [
            "base": "KRW",
            "code": "JPY"
        ]
        getDataFromManana(name: "JPY/KRW", parameters: param_jpykrw)
        
        // EURKRW
        let param_eurkrw: Parameters = [
            "base": "KRW",
            "code": "EUR"
        ]
        getDataFromManana(name: "EUR/KRW", parameters: param_eurkrw)

        //BTCUSD
        getDataFromBitfinex(name: "BTC/USD")
        
        //BTCKRW
        let param_upbit: Parameters = [
            "markets": "KRW-BTC"
        ]
        getDataFromUpbit(name: "BTC/KRW", parameters: param_upbit)
        
        //Gold & Silver
        getDataFromGoldAPI(name: "금")
        getDataFromGoldAPI(name: "은")
        
        // BTC Korean Premium
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            self.getKorPremium(name: "김치프리미엄", kimp: self.kimp)
        }
    }
    
    func getDataFromManana(name: String, parameters: Parameters = [:]){
        Network.shared.getAPIData(url: "https://api.manana.kr/exchange/rate.json", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(Manana.self, from : data)
                if name == "USD/KRW"{
                    self.kimp["rate"] = res[0].rate
                }
                self.items.append(Summary(name, String(format: "%.2f", res[0].rate)))
                self.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }
    
    func getDataFromBitfinex(name: String, parameters: Parameters = [:]){
        Network.shared.getAPIData(url: "https://api.bitfinex.com/v1/pubticker/btcusd", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(BTCUSD.self, from : data)
                self.kimp["btcusd"] = Double(res.lastPrice)!
                self.items.append(Summary(name, res.lastPrice))
                self.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }
    
    func getDataFromUpbit(name: String, parameters: Parameters = [:]){
        Network.shared.getAPIData(url: "https://api.upbit.com/v1/ticker", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(BTCKRW.self, from : data)
                self.kimp["btckrw"] = Double(res[0].tradePrice)
                self.items.append(Summary(name, String(res[0].tradePrice)))
                self.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }
    
    func getDataFromGoldAPI(name: String, parameters: Parameters = [:]){
        let ticker = name == "금" ? "XAU" : "XAG"
        Network.shared.getAPIData(url: "https://www.goldapi.io/api/\(ticker)/KRW/", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(Gold.self, from : data)
                self.items.append(Summary(name, String(format: "%.2f", res.price)))
                self.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }
    
    func getKorPremium(name: String, kimp: [String:Double]){
        print("kimp: \(self.kimp)")
        let global = kimp["btcusd"]!
        let kor = kimp["btckrw"]!
        let rate = kimp["rate"]!
        
        let premium = (kor / global / rate) * 100 - 100
        
        self.items.append(Summary(name, String(format: "%.2f", premium)))
        self.tableView.reloadData()
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryTableViewCell
        
        
        cell.cellTitle.text = items[indexPath.row].title
        cell.cellUnit.text = items[indexPath.row].unit
        cell.cellValue.text = items[indexPath.row].value
        
        return cell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
