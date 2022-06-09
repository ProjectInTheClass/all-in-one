//
//  ViewController.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/03.
//

import UIKit
import Alamofire
import Toast_Swift

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var Btn_All: UIButton!
    
    var items: [Summary] = []
    let defaults = UserDefaults.standard
    
    override func viewWillDisappear(_ animated: Bool) {
        items = []
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
            getData(ticker: ticker as! String)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let chartViewController: ChartViewController = segue.destination as? ChartViewController else {
            return
        }
        
        guard let sender: StarredCell = sender as? StarredCell else {
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
        
        if sender.cellTicker.prefix(4) == "KRW-" {
            let arr = sender.cellTicker.components(separatedBy: "-")
            chartViewController.ticker = arr[1] + "KRW"
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
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                client.getKorPremium(name: "김치프리미엄", kimp: client.kimp)
            }
        }
        
        else {
            client.getDataFromFinancialModeling(tickers:ticker)
        }
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
