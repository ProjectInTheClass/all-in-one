//
//  Stock.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/04.
//

import Foundation

struct StockElement: Codable {
    let symbol, name: String
    let price, changesPercentage, change, dayLow: Double
    let dayHigh, yearHigh, yearLow: Double
    let marketCap: Int
    let priceAvg50, priceAvg200: Double
    let volume, avgVolume: Int
    let exchange: String
    let stockOpen, previousClose, eps, pe: Double
    let earningsAnnouncement: String?
    let sharesOutstanding, timestamp: Int

    enum CodingKeys: String, CodingKey {
        case symbol, name, price, changesPercentage, change, dayLow, dayHigh, yearHigh, yearLow, marketCap, priceAvg50, priceAvg200, volume, avgVolume, exchange
        case stockOpen = "open"
        case previousClose, eps, pe, earningsAnnouncement, sharesOutstanding, timestamp
    }
}

typealias Stock = [StockElement]
