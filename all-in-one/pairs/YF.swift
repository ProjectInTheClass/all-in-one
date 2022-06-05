//
//  YF.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/28.
//

import Foundation

// MARK: - Yf
struct Yf: Codable {
    let quoteResponse: QuoteResponse
}

// MARK: - QuoteResponse
struct QuoteResponse: Codable {
    let result: [Result]
    let error: JSONNull?
}

// MARK: - Result
struct Result: Codable {
    let language, region, quoteType, typeDisp: String
    let quoteSourceName: String
    let triggerable: Bool
    let customPriceAlertConfidence, currency, marketState, shortName: String
    let exchangeTimezoneShortName, exchangeTimezoneName: String
    let gmtOffSetMilliseconds: Int
    let market: String
    let esgPopulated: Bool
    let messageBoardID, exchange: String
    let priceHint: Int
    let regularMarketPrice, regularMarketDayHigh: Double
    let regularMarketDayRange: String
    let regularMarketDayLow: Double
    let regularMarketVolume: Int
    let regularMarketPreviousClose: Double
    let bid, ask, bidSize, askSize: Int
    let fullExchangeName: String
    let regularMarketOpen, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent: Double
    let fiftyTwoWeekRange: String
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh: Double
    let sourceInterval, exchangeDataDelayedBy: Int
    let tradeable: Bool
    let regularMarketChange, regularMarketChangePercent: Double
    let regularMarketTime: Int
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case language, region, quoteType, typeDisp, quoteSourceName, triggerable, customPriceAlertConfidence, currency, marketState, shortName, exchangeTimezoneShortName, exchangeTimezoneName, gmtOffSetMilliseconds, market, esgPopulated
        case messageBoardID = "messageBoardId"
        case exchange, priceHint, regularMarketPrice, regularMarketDayHigh, regularMarketDayRange, regularMarketDayLow, regularMarketVolume, regularMarketPreviousClose, bid, ask, bidSize, askSize, fullExchangeName, regularMarketOpen, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, fiftyTwoWeekRange, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh, sourceInterval, exchangeDataDelayedBy, tradeable, regularMarketChange, regularMarketChangePercent, regularMarketTime, symbol
    }
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
