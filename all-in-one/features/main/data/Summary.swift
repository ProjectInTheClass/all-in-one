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
    var searchCase: String
    
    init(_ title: String, _ value: String, _ ticker: String = "") {
        self.title = title
        self.value = value
        self.ticker = ticker
       
        switch self.title.prefix(3){
        case "BTC":
            self.titleKr = "비트코인"
            self.searchCase = titleKr
        case "USD":
            self.titleKr = "달러"
            self.searchCase = titleKr
        case "JPY":
            self.titleKr = "엔화"
            self.searchCase = titleKr
        case "EUR":
            self.titleKr = "유로"
            self.searchCase = titleKr
        case "App":
            self.titleKr = "애플"
            self.searchCase = titleKr
        case "Ama":
            self.titleKr = "아마존"
            self.searchCase = titleKr
        case "ASM":
            self.titleKr = "에이에스엠엘 홀딩"
            self.searchCase = "ASML 홀딩"
        case "Met":
            self.titleKr = "메타(페이스북)"
            self.searchCase = titleKr
        case "Alp":
            self.titleKr = "알파벳"
            self.searchCase = titleKr
        case "Mic":
            self.titleKr = "마이크로소프트"
            self.searchCase = titleKr
        case "NVI":
            self.titleKr = "엔비디아"
            self.searchCase = titleKr
        case "Pay":
            self.titleKr = "페이팔"
            self.searchCase = titleKr
        case "Tes":
            self.titleKr = "테슬라"
            self.searchCase = titleKr
        case "Dow":
            self.titleKr = "다우존스"
            self.searchCase = titleKr
        case "NAS":
            self.titleKr = "나스닥"
            self.searchCase = titleKr
        case "KOS":
            self.titleKr = "코스피"
            self.searchCase = titleKr
        case "HAN":
            self.titleKr = "항생"
            self.searchCase = titleKr
        //한국주식
        case "SK ":
            self.titleKr = "에스케이하이닉스"
            self.searchCase = "SK 하이닉스"
        case "LG ":
            self.titleKr = "엘지화학"
            self.searchCase = "LG 화학"
        case "NAV":
            self.titleKr = "네이버"
            self.searchCase = titleKr
        case "Hyu":
            self.titleKr = "현대자동차"
            self.searchCase = titleKr
        case "Kak":
            self.titleKr = "카카오"
            self.searchCase = titleKr
        case "Kia":
            self.titleKr = "기아자동차"
            self.searchCase = titleKr
        case "Pos":
            self.titleKr = "포스코"
            self.searchCase = titleKr
        case "Cel":
            self.titleKr = "셀트리온"
            self.searchCase = titleKr
        case "KRA":
            self.titleKr = "크래프톤"
            self.searchCase = titleKr
            
            
        default:
            self.titleKr = ""
            self.searchCase = titleKr
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

enum MarketType {
    case KRX //국내주식
    case NASDAQ //미국주식
    case BINANCE //암호화폐
    case FX //외환
}
