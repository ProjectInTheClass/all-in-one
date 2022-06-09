//
//  News.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/06.
//
import Foundation

// MARK: - EconomyNews
struct EconomyNews: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let title: String
    let url: String
}
