import Foundation
import Combine

/// Contains an array of Magic datapoints (words, card values, etc).
///
/// `Catalog` is provided by `Combinefall` as a aid for building other Magic software and
/// understanding possible values for a field on Card objects.
/*@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct List<T: ListableScryfallModel>: ScryfallModel {
    public let object: String

    /// If this is a list of `Card` objects, this field will contain the total number of cards found across all pages.
    public let totalCards: Int?

    public let hasMore: Bool?

    /// If there is a page beyond the current page, this field will contain a full API URI to that page.
    public let nextPageUrl: URL?

    /// An array of human-readable warnings issued when generating this list, as strings.
    /// Warnings are non-fatal issues that the API discovered with your input.
    /// In general, they indicate that the List will not contain the all of the information you requested.
    /// You should fix the warnings and re-submit your request.
    public let warnings: [String]?

    /// An array of datapoints.
    public let data: [T]
    
    public func nextPage(using session: URLSession) async throws -> Self? {
        guard let nextPageUrl = nextPageUrl else { return nil }
        return try Self.from(jsonData: try await session.data(from: nextPageUrl).0)
    }

    enum CodingKeys: String, CodingKey {
        case object, totalCards = "total_cards", data, hasMore = "has_more", nextPageUrl = "next_page", warnings
    }
}*/

public protocol List: ScryfallModel {
    associatedtype Data: Listable
    
    var object: String { get }
    var data: [Data] { get }
    var hasMore: Bool { get }
    var nextPageUrl: URL? { get }
    var warnings: [String]? { get }
    
    func nextPage(using session: URLSession) async throws -> Self?
}

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
extension List {
    public func nextPage(using session: URLSession) async throws -> Self? {
        guard let nextPageUrl = nextPageUrl else { return nil }
        return try Self.from(jsonData: try await session.data(from: nextPageUrl).0)
    }
}

public protocol Listable: ScryfallModel { }
