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
        //한국주식
        case "SK ":
            self.titleKr = "에스케이하이닉스"
        case "LG ":
            self.titleKr = "엘지화학"
        case "NAV":
            self.titleKr = "네이버"
        case "Hyu":
            self.titleKr = "현대자동차"
        case "Kak":
            self.titleKr = "카카오"
        case "Kia":
            self.titleKr = "기아자동차"
        case "POS":
            self.titleKr = "포스코"
        case "Cel":
            self.titleKr = "셀트리온"
        case "KRA":
            self.titleKr = "크래프톤"
        case "Sam":
            if(title.prefix(9)=="Samsung E"){
                self.titleKr = "삼성일렉트로닉스"
                
            }
            else{
                self.titleKr = "삼성생명"
            }
        case "Kor":
            self.titleKr = "한국전력공사"
            
        default:
            switch self.title.suffix(3){
            case "BTC":
                self.titleKr = "비트코인"
            case "ETH":
                self.titleKr = "이더리움"
            case "XRP":
                self.titleKr = "리플"
            case "SOL":
                self.titleKr = "솔라나"
            case "ADA":
                self.titleKr = "에이다"
            case "MIX":
                self.titleKr = "위믹스"
            case "AND":
                self.titleKr = "샌드박스"
            case "EOS":
                self.titleKr = "이오스"
            case "LOW":
                self.titleKr = "플로우"
            case "MTL":
                self.titleKr = "메타코인"
            case "ETC":
                self.titleKr = "이더리움캐시"
            case "NEO":
                self.titleKr = "네오코인"
            case "VES":
                self.titleKr = "웨이브"
            case "GAS":
                self.titleKr = "가스"
            case "REP":
                self.titleKr = "어거"
            case "EEMM":
                self.titleKr = "스팀코인"
            case "BTG":
                self.titleKr = "비트코인골드"
                
            default:
                self.titleKr=""
            }
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
