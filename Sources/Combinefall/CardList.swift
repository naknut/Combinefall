//
//  CardList.swift
//  
//
//  Created by Marcus Isaksson on 6/9/21.
//

import Foundation

public struct CardList: List {
    public typealias Element = Card
    
    public let object: String
    public let data: [Element]
    public let hasMore: Bool
    public let totalCards: Int
    public let nextPageUrl: URL?
    public let warnings: [String]?
    
    public var cards: [Card] { data }
    
    public var session: URLSession = .shared
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        object = try container.decode(String.self, forKey: .object)
        data = try container.decode([Card].self, forKey: .data)
        hasMore = try container.decodeIfPresent(Bool.self, forKey: .hasMore) ?? false
        totalCards = try container.decode(Int.self, forKey: .totalCards)
        nextPageUrl = try container.decodeIfPresent(URL.self, forKey: .nextPageUrl)
        warnings = try container.decodeIfPresent([String].self, forKey: .warnings)
    }
    
    enum CodingKeys: String, CodingKey {
        case object, data, hasMore = "has_more", totalCards = "total_cards", nextPageUrl = "next_page", warnings
    }
}
