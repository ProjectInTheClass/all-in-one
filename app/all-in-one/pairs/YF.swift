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
    let language: Language
    let region: Region
    let quoteType: QuoteType
    let typeDisp: TypeDisp
    let quoteSourceName: QuoteSourceName
    let triggerable: Bool
    let customPriceAlertConfidence: CustomPriceAlertConfidence
    let currency: Currency
    let exchange: Exchange
    let shortName, longName, messageBoardID: String
    let market: Market
    let marketState: MarketState
    let priceHint: Int
    let exchangeTimezoneName: ExchangeTimezoneName
    let exchangeTimezoneShortName: ExchangeTimezoneShortName
    let gmtOffSetMilliseconds: Int
    let esgPopulated: Bool
    let firstTradeDateMilliseconds: Int
    let earningsTimestamp, earningsTimestampStart, earningsTimestampEnd: Int?
    let epsCurrentYear, priceEpsCurrentYear: Double?
    let sharesOutstanding: Int
    let fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, twoHundredDayAverage: Double
    let twoHundredDayAverageChange, twoHundredDayAverageChangePercent: Double
    let marketCap, sourceInterval, exchangeDataDelayedBy: Int
    let averageAnalystRating: String?
    let tradeable: Bool
    let regularMarketChange: Int
    let regularMarketChangePercent: Double
    let regularMarketTime, regularMarketPrice, regularMarketDayHigh: Int
    let regularMarketDayRange: String
    let regularMarketDayLow, regularMarketVolume, regularMarketPreviousClose, bid: Int
    let ask: Int
    let bidSize, askSize: Int?
    let fullExchangeName: FullExchangeName
    let financialCurrency: Currency
    let regularMarketOpen, averageDailyVolume3Month, averageDailyVolume10Day, fiftyTwoWeekLowChange: Int
    let fiftyTwoWeekLowChangePercent: Double
    let fiftyTwoWeekRange: String
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent: Double
    let fiftyTwoWeekLow: Int
    let fiftyTwoWeekHigh: Double
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case language, region, quoteType, typeDisp, quoteSourceName, triggerable, customPriceAlertConfidence, currency, exchange, shortName, longName
        case messageBoardID = "messageBoardId"
        case market, marketState, priceHint, exchangeTimezoneName, exchangeTimezoneShortName, gmtOffSetMilliseconds, esgPopulated, firstTradeDateMilliseconds, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd, epsCurrentYear, priceEpsCurrentYear, sharesOutstanding, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent, marketCap, sourceInterval, exchangeDataDelayedBy, averageAnalystRating, tradeable, regularMarketChange, regularMarketChangePercent, regularMarketTime, regularMarketPrice, regularMarketDayHigh, regularMarketDayRange, regularMarketDayLow, regularMarketVolume, regularMarketPreviousClose, bid, ask, bidSize, askSize, fullExchangeName, financialCurrency, regularMarketOpen, averageDailyVolume3Month, averageDailyVolume10Day, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, fiftyTwoWeekRange, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh, symbol
    }
}

enum Currency: String, Codable {
    case krw = "KRW"
}

enum CustomPriceAlertConfidence: String, Codable {
    case low = "LOW"
}

enum Exchange: String, Codable {
    case ksc = "KSC"
}

enum ExchangeTimezoneName: String, Codable {
    case asiaSeoul = "Asia/Seoul"
}

enum ExchangeTimezoneShortName: String, Codable {
    case kst = "KST"
}

enum FullExchangeName: String, Codable {
    case kse = "KSE"
}

enum Language: String, Codable {
    case enUS = "en-US"
}

enum Market: String, Codable {
    case krMarket = "kr_market"
}

enum MarketState: String, Codable {
    case closed = "CLOSED"
}

enum QuoteSourceName: String, Codable {
    case delayedQuote = "Delayed Quote"
}

enum QuoteType: String, Codable {
    case equity = "EQUITY"
}

enum Region: String, Codable {
    case us = "US"
}

enum TypeDisp: String, Codable {
    case equity = "Equity"
}

