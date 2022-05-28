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
    var unit: String
    
    init(_ title: String, _ value: String) {
        self.title = title
        self.value = value
        
        switch title.suffix(3) {
        case "USD":
            self.unit = "$"
        case "EUR":
            self.unit = "€"
        case "KRW":
            self.unit = "₩"
        case "JPY":
            self.unit = "¥"
        default:
            self.unit = "point"
        }
        
        if title == "김치프리미엄" {
            self.unit = "%"
        }
        
        if title == "금" || title == "은" {
            self.unit = "₩"
        }
    }
}
