//
//  Index.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/02.
//
import Foundation

// MARK: - IndexElement
struct IndexElement: Codable {
    let symbol, name: String
    let price, changesPercentage, change, dayLow: Double
    let dayHigh, yearHigh, yearLow: Double
    let marketCap: JSONNull?
    let priceAvg50, priceAvg200: Double
    let volume, avgVolume: Int
    let exchange: Exchange1
    let indexOpen, previousClose: Double
    let eps, pe, earningsAnnouncement, sharesOutstanding: JSONNull?
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case symbol, name, price, changesPercentage, change, dayLow, dayHigh, yearHigh, yearLow, marketCap, priceAvg50, priceAvg200, volume, avgVolume, exchange
        case indexOpen = "open"
        case previousClose, eps, pe, earningsAnnouncement, sharesOutstanding, timestamp
    }
}

enum Exchange1: String, Codable {
    case index = "INDEX"
}

typealias Index = [IndexElement]
