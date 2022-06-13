//
//  Stock.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/04.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let stock = try? newJSONDecoder().decode(Stock.self, from: jsonData)

import Foundation

// MARK: - StockElement
struct KStockElement: Codable {
    let symbol, name: String
    let price: Int
}

typealias KStock = [KStockElement]
