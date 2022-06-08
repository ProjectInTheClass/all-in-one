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
    let source: Source
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: JSONNullNews?
    let name: String
}

// MARK: - Encode/decode helpers

class JSONNullNews: Codable, Hashable {

    public static func == (lhs: JSONNullNews, rhs: JSONNullNews) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        return
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullNews.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
