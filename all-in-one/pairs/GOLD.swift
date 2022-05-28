//
//  GOLD.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/28.
//

import Foundation

// MARK: - Gold
struct Gold: Codable {
    let timestamp: Int
    let metal, currency, exchange, symbol: String
    let openTime: Int
    let ask, bid, price, ch: Double
    let priceGram24K, priceGram22K, priceGram21K, priceGram20K: Double
    let priceGram18K: Double

    enum CodingKeys: String, CodingKey {
        case timestamp, metal, currency, exchange, symbol
        case openTime = "open_time"
        case ask, bid, price, ch
        case priceGram24K = "price_gram_24k"
        case priceGram22K = "price_gram_22k"
        case priceGram21K = "price_gram_21k"
        case priceGram20K = "price_gram_20k"
        case priceGram18K = "price_gram_18k"
    }
}
