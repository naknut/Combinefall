import Foundation
import Combine

/// Contains an array of Magic datapoints (words, card values, etc).
///
/// `Catalog` is provided by `Combinefall` as a aid for building other Magic software and
/// understanding possible values for a field on Card objects.
public struct List<T: Decodable>: ScryfallModel {
    let object: String

    /// If this is a list of `Card` objects, this field will contain the total number of cards found across all pages.
    public let totalCards: Int?

    public let hasMore: Bool?

    /// If there is a page beyond the current page, this field will contain a full API URI to that page.
    public let nextPage: URL?

    /// An array of human-readable warnings issued when generating this list, as strings.
    /// Warnings are non-fatal issues that the API discovered with your input.
    /// In general, they indicate that the List will not contain the all of the information you requested.
    /// You should fix the warnings and re-submit your request.
    public let warnings: [String]?

    /// An array of datapoints.
    public let data: [T]

    // Used internaly to inject remote publisher for testing.
    // swiftlint:disable:next identifier_name
    func _nextPagePublisher<R: Publisher>(
        remotePublisherClosure: @escaping (URLRequest) -> R
    ) -> AnyPublisher<Self, Error>?
    where R.Output == URLSession.DataTaskPublisher.Output, R.Failure == URLSession.DataTaskPublisher.Failure {
        guard let nextPage = nextPage else { return nil }
        return fetchPublisher(upstream: Just(URLRequest(url: nextPage)), remotePublisherClosure: remotePublisherClosure)
    }

    /// Creates a publisher that publises the next page of this `List`.
    public func nextPagePublisher() -> AnyPublisher<Self, Error>? {
        _nextPagePublisher(remotePublisherClosure: URLSession.shared.dataTaskPublisher)
    }

    enum CodingKeys: String, CodingKey {
        case object, totalCards = "total_cards", data, hasMore = "has_more", nextPage = "next_page", warnings
    }
}
