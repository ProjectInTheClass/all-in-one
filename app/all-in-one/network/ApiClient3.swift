//
//  ApiClient3.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/08.
//
import Foundation
import Alamofire
import UIKit

class ApiClient3 {
    let controller: EditViewController
    
    var kimp = [
        "btcusd": 0.0,
        "btckrw": 0.0,
        "rate": 0.0
    ]
    
    init(controller: EditViewController){
        self.controller = controller
    }
    
    func getDataFromManana(name: String, parameters: Parameters = [:]){
        Network.shared.getAPIData(url: "https://api.manana.kr/exchange/rate.json", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(Manana.self, from : data)
                if name == "USDKRW"{
                    self.kimp["rate"] = res[0].rate
                }
                self.controller.items.append(Summary(name, String(format: "%.2f", res[0].rate)))
                self.controller.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }

    func getDataFromBitfinex(name: String, parameters: Parameters = [:]){
        Network.shared.getAPIData(url: "https://api.bitfinex.com/v1/pubticker/btcusd", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(BTCUSD.self, from : data)
                let price = Double(res.lastPrice)!
                self.kimp["btcusd"] = price
                self.controller.items.append(Summary(name, String(format: "%.2f", price)))
                self.controller.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }

    func getDataFromUpbit(parameters: Parameters){
        Network.shared.getAPIData(url: "https://api.upbit.com/v1/ticker", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(Coin.self, from : data)
                for i in res{
                    if i.market == "KRW-BTC"{
                        self.kimp["btckrw"] = Double(i.tradePrice)
                    }
                    var summary = Summary(i.market, String(i.tradePrice))
                    summary.unit = "₩"
                    self.controller.items.append(Summary(i.market, String(i.tradePrice)))
                }
                self.controller.tableView.reloadData()
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
                self.controller.items.append(Summary(name, String(format: "%.2f", res.price)))
                self.controller.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }

    func getDataFromYahooFinance(parameters: Parameters = [:]){
        Network.shared.getAPIData(url: "https://yfapi.net/v6/finance/quote", parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(Yf.self, from : data)
                
                for i in res.quoteResponse.result{
                    let summary = Summary(i.shortName, String(i.regularMarketPrice), "₩")
                    summary.unit = "₩"
                    self.controller.items.append(summary)
                }
                
                self.controller.tableView.reloadData()
            }catch {
                print(error)
            }
        })
    }

    func getDataFromFinancialModeling(tickers: String) {
        let params = [
            "apikey" : "3c3226f489553d666ffcc4f26938fcdb"
        ]
                
        if "^HSI^DJT^IXIC^KS11".contains(tickers) {
            Network.shared.getAPIData(url: "https://financialmodelingprep.com/api/v3/quotes/index", parameters: params, completion: { (data) -> (Void) in
                do {
                    let res = try JSONDecoder().decode(Index.self, from : data)
                    
                    for i in res {
                        if(i.symbol == tickers){
                            let summary = Summary(i.name, String(format: "%.2f", i.price), i.symbol)
                            summary.unit = "point"
                            self.controller.items.append(summary)
                        }
                    }
                    
                    self.controller.tableView.reloadData()
                }catch {
                    print(error)
                }
            })
        }
        else {
            Network.shared.getAPIData(url: "https://financialmodelingprep.com/api/v3/quote/\(tickers)", parameters: params, completion: { (data) -> (Void) in
                do {
                    let res = try JSONDecoder().decode(Stock.self, from : data)
                    
                    for i in res {
                        let summary = Summary(i.name, String(format: "%.2f", i.price), i.symbol)
                        summary.unit = "$"
                        self.controller.items.append(summary)
                    }
                    self.controller.tableView.reloadData()
                }catch {
                    print(error)
                }
            })
        }
    }
    
    func getKstock(tickers: String) {
        let params = [
            "apikey" : "3c3226f489553d666ffcc4f26938fcdb"
        ]
            
        Network.shared.getAPIData(url: "https://financialmodelingprep.com/api/v3/quote/\(tickers)", parameters: params, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode(KStock.self, from : data)
                
                for i in res {
                    let summary = Summary(i.name, String(i.price), i.symbol)
                    summary.unit = "₩"
                    self.controller.items.append(summary)
                }
                self.controller.tableView.reloadData()
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
        
        self.controller.items.append(Summary(name, String(format: "%.2f", premium)))
        self.controller.tableView.reloadData()
    }
}

