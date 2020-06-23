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

    /// Creates a publsier that gets the next page of this `List`.
    /// - Parameter dataTaskPublisher: _Required_ A closure that returns `Publisher`
    ///     with `Output == URLSession.DataTaskPublisher.Output`
    ///     and `Failure == URLSession.DataTaskPublisher.Failure`.
    ///     This is so that you can supply your own `Publisher` from your own `URLSession`
    /// - Returns: A publisher that publishes `List` containing the `T`s of the next page.
    public func nextPagePublisher<R: Publisher>(dataTaskPublisher: @escaping (URLRequest) -> R)
        -> AnyPublisher<Self, Error>?
        where R.Output == URLSession.DataTaskPublisher.Output, R.Failure == URLSession.DataTaskPublisher.Failure {
            guard let nextPage = nextPage else { return nil }
            return fetchPublisher(upstream: Just(URLRequest(url: nextPage)), dataTaskPublisher: dataTaskPublisher)
    }

    /// A publisher that publises the next page of this `List`.
    public var nextPagePublisher: AnyPublisher<Self, Error>? {
        nextPagePublisher(dataTaskPublisher: URLSession.shared.dataTaskPublisher)
    }

    enum CodingKeys: String, CodingKey {
        case object, totalCards = "total_cards", data, hasMore = "has_more", nextPage = "next_page", warnings
    }
}
