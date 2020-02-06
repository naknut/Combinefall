import Combine
import Foundation

public typealias CardList = List<Card>

public enum CardIdentifier: Encodable {
    case scryfallIdentifier(UUID)
    case magicOnlineIdentifier(Int)
    case multiverseIdentifier(Int)
    case oracleIdentifier(UUID)
    case illustrationIdentifier(UUID)
    case name(String)
    case nameAndSet(name: String, set: String)
    case collectiorNumberAndSet(collectorNumber: String, set: String)

    enum CodingKeys: String, CodingKey {
        case scryfallIdentifier = "id"
        case magicOnlineIdentifier = "mtgo_id"
        case multiverseIdentifier = "multiverse_id"
        case oracleIdentifier = "oracle_id"
        case illustrationIdentifier = "illustration_id"
        case name
        case set
        case collectiorNumber = "collector_number"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .scryfallIdentifier(let identifier):
            try container.encode(identifier, forKey: .scryfallIdentifier)
        case .magicOnlineIdentifier(let identifier):
            try container.encode(identifier, forKey: .magicOnlineIdentifier)
        case .multiverseIdentifier(let identifier):
            try container.encode(identifier, forKey: .multiverseIdentifier)
        case .oracleIdentifier(let identifier):
            try container.encode(identifier, forKey: .oracleIdentifier)
        case .illustrationIdentifier(let identifier):
            try container.encode(identifier, forKey: .illustrationIdentifier)
        case .name(let name):
            try container.encode(name, forKey: .name)
        case .nameAndSet(let name, let set):
            try container.encode(name, forKey: .name)
            try container.encode(set, forKey: .set)
        case .collectiorNumberAndSet(let collectiorNumber, let set):
            try container.encode(collectiorNumber, forKey: .collectiorNumber)
            try container.encode(set, forKey: .set)
        }
    }
}

public struct CardIdentifiers: Encodable {
    public let identifiers: [CardIdentifier]

    public init(_ identifiers: [CardIdentifier]) { self.identifiers = identifiers }

    public subscript(index: Int) -> CardIdentifier { identifiers[index] }
}

// swiftlint:disable:next identifier_name
func _cardCollectionPublisher<U: Publisher, R: Publisher>(
    upstream: U, remotePublisherClosure: @escaping (URLRequest) -> R
) -> AnyPublisher<CardList, Error>
    where
    U.Output == CardIdentifiers,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        fetchPublisher(
            upstream: upstream.first().map { EndpointComponents.cardCollection($0) },
            remotePublisherClosure: remotePublisherClosure
        )
}

///Gets a `CardList` with the collection of requested cards.
///A maximum of 75 card references may be submitted per request.
///
///While `Card`s in the `CardList` be returned in the order that they were requested,
///cards that aren’t found will throw off the mapping of request identifiers to results,
///so you should not rely on positional index alone while parsing the data.
///
/// - Parameter upstream: _Required_ A publisher which `Output` must be `CardIdentifiers`
/// - Returns: A publisher that publishes `CardList` mathing the given `upstream` published element.
public func cardCollectionPublisher<U: Publisher>(upstream: U) -> AnyPublisher<CardList, Error>
    where U.Output == CardIdentifiers, U.Failure == Never {
        return _cardCollectionPublisher(upstream: upstream, remotePublisherClosure: URLSession.shared.dataTaskPublisher)
}

public extension Publisher where Self.Output == CardIdentifiers, Self.Failure == Never {
    ///Gets a `CardList` with the collection of requested cards.
    ///A maximum of 75 card references may be submitted per request.
    ///
    ///While `Card`s in the `CardList` be returned in the order that they were requested,
    ///cards that aren’t found will throw off the mapping of request identifiers to results,
    ///so you should not rely on positional index alone while parsing the data.
    ///
    /// - Returns: A publisher that publishes `CardList` mathing the given `upstream` published element.
    func cardCollection() -> AnyPublisher<CardList, Error> {
        cardCollectionPublisher(upstream: self)
    }
}
