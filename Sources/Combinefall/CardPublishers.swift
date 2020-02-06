import Combine
import Foundation

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _cardPublisher<U: Publisher, R: Publisher> (upstream: U, remotePublisherClosure: @escaping (URLRequest) -> R)
    -> AnyPublisher<Card, Combinefall.Error>
    where
    U.Output == String,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        fetchPublisher(
            upstream: upstream.map { EndpointComponents.card(named: $0) },
            remotePublisherClosure: remotePublisherClosure
        )
}

/// Creates a publisher connected to upstream that queries the `card/named` endpoint of Scryfall.
///
/// Names are case-insensitive and punctuation is optional (you can drop apostrophes and periods etc).
/// For example: `"fIReBALL"` is the same as `"Fireball"` and `"smugglers copter"` is the same as `"Smuggler's Copter"`.
///
/// - Parameter upstream: _Required_ A publisher which `Output` must be `String`.
/// - Returns: A publisher that publishes a `Card` mathing the given `upstream` published element.
public func cardPublisher<U: Publisher>(upstream: U) -> AnyPublisher<Card, Error>
    where U.Output == String, U.Failure == Never {
        _cardPublisher(
            upstream: upstream,
            remotePublisherClosure: URLSession.shared.dataTaskPublisher
        )
}

public extension Publisher where Self.Output == String, Self.Failure == Never {
    /// Queries the `card/named` endpoint of Scryfall.
    ///
    /// Names are case-insensitive and punctuation is optional (you can drop apostrophes and periods etc).
    /// For example: `"fIReBALL"` is the same as `"Fireball"`
    /// and `"smugglers copter"` is the same as `"Smuggler's Copter"`.
    ///
    /// - Returns: A publisher that publishes a `Card` mathing the given `upstream` published element.
    func card() -> AnyPublisher<Card, Error> {
        cardPublisher(upstream: self)
    }
}
