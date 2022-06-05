//
//  AllDataController.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/02.
//

import UIKit
import Alamofire

class AllDataController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items: [Summary] = []
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "모든 데이터"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let client = ApiClient(controller: self)
        
        // USDKRW
        let param_usdkrw: Parameters = [
            "base": "KRW",
            "code": "USD"
        ]
        client.getDataFromManana(name: "USDKRW", parameters: param_usdkrw)
        
        // JPYKRW
        let param_jpykrw: Parameters = [
            "base": "KRW",
            "code": "JPY"
        ]
        client.getDataFromManana(name: "JPYKRW", parameters: param_jpykrw)
        
        // EURKRW
        let param_eurkrw: Parameters = [
            "base": "KRW",
            "code": "EUR"
        ]
        client.getDataFromManana(name: "EURKRW", parameters: param_eurkrw)

        //BTCUSD
        client.getDataFromBitfinex(name: "BTCUSD")
        
        //BTCKRW
        let param_upbit: Parameters = [
            "markets": "KRW-BTC"
        ]
        client.getDataFromUpbit(name: "BTCKRW", parameters: param_upbit)
        
        //Gold & Silver
        client.getDataFromGoldAPI(name: "금(GOLD)")
        client.getDataFromGoldAPI(name: "은(SILVER)")
        
        // Index
        client.getDataFromFinancialModeling(tickers:"index")
        client.getDataFromFinancialModeling(tickers:"AAPL,MSFT,GOOG,AMZN,FB,TSLA,NVDA,PYPL,ASML")

        
        // BTC Korean Premium
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            client.getKorPremium(name: "김치프리미엄", kimp: client.kimp)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let chartViewController: ChartViewController = segue.destination as? ChartViewController else {
            return
        }
        
        guard let sender: SummaryTableViewCell = sender as? SummaryTableViewCell else {
            return
        }
                
        switch (sender.cellTicker){
            case "^HSI":
                chartViewController.ticker = "HSI"
            case "^DJT":
                chartViewController.ticker = "DJI"
            case "^IXIC":
                chartViewController.ticker = "NASDAQ"
            case "^KS11":
                chartViewController.ticker = "KOSPI|12M"
            case "금(GOLD)":
                chartViewController.ticker = "GOLD"
            case "은(SILVER)":
                chartViewController.ticker = "SILVER"
            default:
                chartViewController.ticker = sender.cellTicker
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var starred: [String] = []
        
        for item in items {
            if defaults.bool(forKey: item.ticker) {
                starred.append(item.ticker)
            }
        }
        defaults.set(starred, forKey:"star-index")
    }
}

extension AllDataController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryTableViewCell
        
        
        cell.cellTitle.text = items[indexPath.row].title
        cell.cellUnit.text = items[indexPath.row].unit
        cell.cellValue.text = items[indexPath.row].value
        cell.cellTicker = items[indexPath.row].ticker
        cell.cellStar.isSelected = defaults.bool(forKey: cell.cellTicker)
        
        return cell
    }
}

extension AllDataController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
