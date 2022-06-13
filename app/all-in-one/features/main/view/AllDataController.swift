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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items: [Summary] = []
    var backups: [Summary] = []
    
    let defaults = UserDefaults.standard

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = "종목 검색"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "모든 데이터"
        
        setupTableView()
        
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
        
        //Coins
        let param_upbit: Parameters = [
            "markets": "KRW-BTC,KRW-ETH,KRW-XRP,KRW-SOL,KRW-ADA,KRW-WEMIX,KRW-SAND,KRW-AXS,KRW-EOS,KRW-FLOW,KRW-MTL,KRW-ETC,KRW-NEO,KRW-WAVES,KRW-GAS,KRW-REP,KRW-STEEM,KRW-BTG"
        ]
        client.getDataFromUpbit(parameters: param_upbit)
        
        //Gold & Silver
        client.getDataFromGoldAPI(name: "금(GOLD)")
        client.getDataFromGoldAPI(name: "은(SILVER)")
        
        //Index
        client.getDataFromFinancialModeling(tickers:"index")
        
        //Stocks
        client.getDataFromFinancialModeling(tickers:"AAPL,MSFT,GOOG,AMZN,FB,TSLA,NVDA,PYPL")
        
        //Korean Stocks
        client.getKstock(tickers: "005930.KS,000660.KS,051915.KS,035420.KS,005380.KS,035720.KS,000270.KS,068270.KS,005490.KS,259960.KS,112040.KS")
        client.getKstock(tickers: "068400.KS,015760.KS,000990.KS,032830.KS")
        
        
        // BTC Korean Premium
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            client.getKorPremium(name: "김치프리미엄", kimp: client.kimp)
            if(self.backups.isEmpty){
                self.backups = self.items
            }
            self.setupSearchBar()
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
        
        if sender.cellTicker.prefix(4) == "KRW-" {
            let arr = sender.cellTicker.components(separatedBy: "-")
            chartViewController.ticker = arr[1] + "KRW"
        }
        
        if sender.cellTicker.suffix(3) == ".KS" {
            let arr = sender.cellTicker.components(separatedBy: ".")
            chartViewController.ticker = arr[0]
        }
    }
}

extension AllDataController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryTableViewCell
        
        
        let title = items[indexPath.row].title
        cell.cellTitle.text = title.count < 20 ? title : shortify(title)
        cell.cellTicker = items[indexPath.row].ticker
        cell.cellStar.isSelected = defaults.bool(forKey: cell.cellTicker)
        
        return cell
    }
    
    func shortify(_ str: String) -> String{
        let endIdx: String.Index = str.index(str.startIndex, offsetBy: 19)
        return String(str[...endIdx]) + ".."
    }
}

extension AllDataController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension AllDataController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        searchBarSearchButtonClicked(searchBar)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.searchBar.text == "" {
            items = backups
            tableView.reloadData()
        }
        else{
            items = backups.filter{
                ($0.title.range(of: self.searchBar.text!, options: .caseInsensitive) != nil)
            } + backups.filter{($0.titleKr.range(of: self.searchBar.text!, options: .caseInsensitive) != nil)
            }
            tableView.reloadData()
        }
    }
}
