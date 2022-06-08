//
//  Stock.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/08.
//
import Foundation

// MARK: - StockElement
struct StockElement: Codable {
    let symbol, name: String
    let price, changesPercentage, change, dayLow: Double
    let dayHigh, yearHigh, yearLow: Double
    let marketCap: Int
    let priceAvg50, priceAvg200: Double
    let volume, avgVolume: Int
    let exchange: String
}

typealias Stock = [StockElement]

