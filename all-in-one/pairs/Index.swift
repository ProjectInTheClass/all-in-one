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
    let indexOpen, previousClose: Double
    let eps, pe, earningsAnnouncement, sharesOutstanding: JSONNull?

    enum CodingKeys: String, CodingKey {
        case symbol, name, price, changesPercentage, change, dayLow, dayHigh, yearHigh, yearLow, marketCap, priceAvg50, priceAvg200, volume, avgVolume
        case indexOpen = "open"
        case previousClose, eps, pe, earningsAnnouncement, sharesOutstanding
    }
}

typealias Index = [IndexElement]
