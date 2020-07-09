import Combine
import Foundation

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _cardPublisher<U: Publisher, R: Publisher> (upstream: U, dataTaskPublisher: @escaping (URLRequest) -> R)
    -> AnyPublisher<Card, Combinefall.Error>
    where
    U.Output == String,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        fetchPublisher(
            upstream: upstream.map { EndpointComponents.cardNamed($0) },
            dataTaskPublisher: dataTaskPublisher
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
            dataTaskPublisher: URLSession.shared.dataTaskPublisher
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

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _cardPublisher<U: Publisher, R: Publisher> (upstream: U, dataTaskPublisher: @escaping (URLRequest) -> R)
    -> AnyPublisher<Card, Combinefall.Error>
    where
    U.Output == UUID,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        fetchPublisher(
            upstream: upstream.map { EndpointComponents.cardId($0) },
            dataTaskPublisher: dataTaskPublisher
        )
}

/// Creates a publisher connected to upstream that queries the `card` endpoint of Scryfall.
///
/// - Parameter upstream: _Required_ A publisher which `Output` must be `UUID`.
/// - Returns: A publisher that publishes a `Card` mathing the given `upstream` published element.
public func cardPublisher<U: Publisher>(upstream: U) -> AnyPublisher<Card, Error>
where U.Output == UUID, U.Failure == Never {
    _cardPublisher(
        upstream: upstream,
        dataTaskPublisher: URLSession.shared.dataTaskPublisher
    )
}

public extension Publisher where Self.Output == UUID, Self.Failure == Never {
    /// Queries the `card/` endpoint of Scryfall.
    ///
    /// - Returns: A publisher that publishes a `Card` mathing the given `upstream` published element.
    func card() -> AnyPublisher<Card, Error> {
        cardPublisher(upstream: self)
    }
}
