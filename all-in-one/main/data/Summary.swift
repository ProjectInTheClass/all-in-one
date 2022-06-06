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
    var titleKr: String
    
    init(_ title: String, _ value: String, _ ticker: String = "") {
        self.title = title
        self.value = value
        self.ticker = ticker
       
        switch self.title.prefix(3){
        case "BTC":
            self.titleKr = "비트코인"
        case "USD":
            self.titleKr = "달러"
        case "JPY":
            self.titleKr = "엔화"
        case "EUR":
            self.titleKr = "유로"
        case "App":
            self.titleKr = "애플"
        case "Ama":
            self.titleKr = "아마존"
        case "ASM":
            self.titleKr = "에이에스엠엘 홀딩"
        case "Met":
            self.titleKr = "메타(페이스북)"
        case "Alp":
            self.titleKr = "알파벳"
        case "Mic":
            self.titleKr = "마이크로소프트"
        case "NVI":
            self.titleKr = "엔비디아"
        case "Pay":
            self.titleKr = "페이팔"
        case "Tes":
            self.titleKr = "테슬라"
        case "Dow":
            self.titleKr = "다우존스"
        case "NAS":
            self.titleKr = "나스닥"
        case "KOS":
            self.titleKr = "코스피"
        case "HAN":
            self.titleKr = "항생"
            
        default:
            self.titleKr = ""
        }
    
        
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
