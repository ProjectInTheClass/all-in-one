//
//  BTCUSD.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/26.
//

import Foundation

struct BTCUSD: Codable {
    let mid, bid, ask, lastPrice: String
    let low, high, volume, timestamp: String

    enum CodingKeys: String, CodingKey {
        case mid, bid, ask
        case lastPrice = "last_price"
        case low, high, volume, timestamp
    }
}
