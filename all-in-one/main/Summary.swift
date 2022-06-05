//
//  Summary.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/22.
//

import Foundation

class Summary {
    var title: String
    var value: String
    var ticker: String
    var unit: String
    
    init(_ title: String, _ value: String, _ ticker: String = "") {
        self.title = title
        self.value = value
        self.ticker = ticker
        
        if self.ticker == "" {
            self.ticker = title
        }
        switch title.suffix(3) {
        case "코스피":
            self.unit = "point"
        case "EUR":
            self.unit = "€"
        case "KRW":
            self.unit = "₩"
        case "JPY":
            self.unit = "¥"
        default:
            self.unit = "$"
        }
        
        if title == "김치프리미엄" {
            self.unit = "%"
        }
        
        if title == "금" || title == "은" {
            self.unit = "₩"
        }
    }
}

enum Market {
    case KRX //국내주식
    case NASDAQ //미국주식
    case BINANCE //암호화폐
    case FX //외환
}
