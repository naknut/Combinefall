//
//  CardList.swift
//  
//
//  Created by Marcus Isaksson on 6/9/21.
//

import Foundation

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct CardList: List {
    public let object: String
    public let data: [Card]
    public let hasMore: Bool
    public let totalCards: Int
    public let nextPageUrl: URL?
    public let warnings: [String]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        object = try container.decode(String.self, forKey: .object)
        data = try container.decode([Card].self, forKey: .data)
        hasMore = try container.decode(Bool?.self, forKey: .hasMore) ?? false
        totalCards = try container.decode(Int.self, forKey: .totalCards)
        nextPageUrl = try container.decode(URL?.self, forKey: .nextPageUrl)
        warnings = try container.decode([String]?.self, forKey: .warnings)
    }
    
    enum CodingKeys: String, CodingKey {
        case object, data, hasMore = "has_more", totalCards = "total_cards", nextPageUrl = "next_page", warnings
    }
}
