import Combine
import Foundation

private let baseURLComponent: URLComponents = URLComponents(string: "https://api.scryfall.com/")!

enum EndpointComponents {
    case autocomplete(searchTerm: String)
    case card(named: String)
    case cardImage(named: String, version: ImageVersion)
    case cardCollection([CardIdentifiers])

    var url: URL {
        var urlComponent = baseURLComponent
        switch self {
        case .autocomplete(let searchTerm):
            urlComponent.path = "/cards/autocomplete"
            urlComponent.queryItems = [URLQueryItem(name: "q", value: searchTerm)]
        case .card(let named):
            urlComponent.path = "/cards/named"
            urlComponent.queryItems = [URLQueryItem(name: "exact", value: named)]
        case .cardImage(let named, let version):
            urlComponent.path = "/cards/named"
            urlComponent.queryItems = [
                URLQueryItem(name: "exact", value: named),
                URLQueryItem(name: "format", value: "image"),
                URLQueryItem(name: "version", value: version.rawValue)
            ]
        case .cardCollection:
            urlComponent.path = "/cards/collection"
        }
        return urlComponent.url!
    }
}

public enum CardIdentifier: Encodable {
    case scryfallIdentifier(UUID)
    case magicOnlineIdentifier(Int)
    case multiverseIdentifier(Int)
    case oracleIdentifier(UUID)
    case illustrationIdentifier(UUID)
    case name(String)
    case nameAndSet(String, String)
    case collectiorNumberAndSet(String, String)
    
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
}

public enum Error: Swift.Error {
    case network(underlying: URLError), decode(underlying: Swift.Error), scryfall(underlying: URLError)
}

func dataPublisher<U: Publisher, R: Publisher> (
    upstream: U, remotePublisherClosure: @escaping (URL) -> R
) -> AnyPublisher<Data, Error>
where
U.Output == URL,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    upstream
        .setFailureType(to: URLSession.DataTaskPublisher.Failure.self)
        .flatMap { url -> R in remotePublisherClosure(url) }
        .map { $0.data }
        .mapError { error -> Error in
            if 400...500 ~= error.errorCode { return .scryfall(underlying: error) }
            return .network(underlying: error)
        }
        .eraseToAnyPublisher()
}

func dataPublisher<U: Publisher, R: Publisher> (
    upstream: U, remotePublisherClosure: @escaping (URL) -> R
) -> AnyPublisher<Data, Error>
where
U.Output == EndpointComponents,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    dataPublisher(upstream: upstream.map { $0.url }, remotePublisherClosure: remotePublisherClosure)
}

func fetchPublisher<U: Publisher, R: Publisher, S: ScryfallModel> (
    upstream: U, remotePublisherClosure: @escaping (URL) -> R
) -> AnyPublisher<S, Error>
where
U.Output == URL,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    dataPublisher(upstream: upstream, remotePublisherClosure: remotePublisherClosure)
        .decode(type: S.self, decoder: JSONDecoder())
        .mapError { error -> Combinefall.Error in
            if let error = error as? Combinefall.Error { return error }
            return .decode(underlying: error)
        }
        .eraseToAnyPublisher()
}

func fetchPublisher<U: Publisher, R: Publisher, S: ScryfallModel> (
    upstream: U, remotePublisherClosure: @escaping (URL) -> R
) -> AnyPublisher<S, Error>
where
U.Output == EndpointComponents,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    fetchPublisher(upstream: upstream.map { $0.url }, remotePublisherClosure: remotePublisherClosure)
}

// MARK: - Autocomplete

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _autocompleteCatalogPublisher<U: Publisher, R: Publisher, S: Scheduler> (
    upstream: U, remotePublisherClosure: @escaping (URL) -> R, scheduler: S
) -> AnyPublisher<AutocompleteCatalog, Combinefall.Error>
where
U.Output == String,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    fetchPublisher(
        upstream: upstream
            .debounce(for: .milliseconds(100), scheduler: scheduler)
            .removeDuplicates()
            .map { EndpointComponents.autocomplete(searchTerm: $0) },
        remotePublisherClosure: remotePublisherClosure
    )
}

/// Creates a publisher connected to upstream that queries the autocomplete endpoint of Scryfall.
///
/// This function is designed for creating assistive UI elements that allow users to free-type card names.
///
/// The names are sorted with the nearest match first, highly favoring results that begin with your given string.
///
/// Spaces, punctuation, and capitalization are ignored.
/// If the `upstream` published `String` is less than 2 characters long,
/// or if no names match, this publisher wont publish any values.
///
/// - Parameter upstream: _Required_ A publisher which `Output` must be `String`.
/// - Parameter scheduler: _Required_ The `Scheduler` on where to preform the operations.
/// - Returns: A publisher that publishes a `AutocompleteCatalog` containing up to
///            20 full English card names that could be autocompletions of the given `upstream` published element.
public func autocompleteCatalogPublisher<U: Publisher, S: Scheduler>(
    upstream: U, scheduler: S
) -> AnyPublisher<AutocompleteCatalog, Error>
where U.Output == String, U.Failure == Never {
    _autocompleteCatalogPublisher(
        upstream: upstream,
        remotePublisherClosure: URLSession.shared.dataTaskPublisher,
        scheduler: scheduler
    )
}

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _autocompletePublisher<U: Publisher, R: Publisher, S: Scheduler>(
    upstream: U, remotePublisherClosure: @escaping (URL) -> R, scheduler: S
) -> AnyPublisher<[String], Error>
where
U.Output == String,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    _autocompleteCatalogPublisher(
        upstream: upstream,
        remotePublisherClosure: remotePublisherClosure,
        scheduler: scheduler
    )
    .map { $0.data }
    .eraseToAnyPublisher()
}

/// Creates a publisher connected to upstream that queries the autocomplete endpoint of Scryfall.
///
/// This function is designed for creating assistive UI elements that allow users to free-type card names.
///
/// The names are sorted with the nearest match first, highly favoring results that begin with your given string.
///
/// Spaces, punctuation, and capitalization are ignored.
/// If the `upstream` published `String` is less than 2 characters long,
/// or if no names match, this publisher wont publish any values.
///
/// - Parameter upstream: _Required_ A publisher which `Output` must be `String`.
/// - Parameter scheduler: _Required_ The `Scheduler` on where to preform the operations.
/// - Returns: A publisher that publishes a `[String]` containing up to
///            20 full English card names that could be autocompletions of the given `upstream` published element.
public func autocompletePublisher<U: Publisher, S: Scheduler>(
    upstream: U, scheduler: S
) -> AnyPublisher<[String], Error>
where U.Output == String, U.Failure == Never {
    _autocompletePublisher(
        upstream: upstream,
        remotePublisherClosure: URLSession.shared.dataTaskPublisher,
        scheduler: scheduler
    )
}

public extension Publisher where Self.Output == String, Self.Failure == Never {

    /// Queries the autocomplete endpoint of Scryfall.
    ///
    /// This function is designed for creating assistive UI elements that allow users to free-type card names.
    ///
    /// The names are sorted with the nearest match first, highly favoring results that begin with your given string.
    ///
    /// Spaces, punctuation, and capitalization are ignored.
    /// If the `upstream` published `String` is less than 2 characters long,
    /// or if no names match, this publisher wont publish any values.
    ///
    /// - Parameter scheduler: _Required_ The scheduler on which this publisher delivers elements
    /// - Returns: A publisher that publishes a `AutocompleteCatalog` containing up to
    ///            20 full English card names that could be autocompletions of the given `upstream` published element.
    func autocompleteList<S: Scheduler>(on scheduler: S) -> AnyPublisher<AutocompleteCatalog, Error> {
        autocompleteCatalogPublisher(upstream: self, scheduler: scheduler)
    }

    /// Queries the autocomplete endpoint of Scryfall.
    /// This function is designed for creating assistive UI elements that allow users to free-type card names.
    ///
    /// The names are sorted with the nearest match first, highly favoring results that begin with your given string.
    ///
    /// Spaces, punctuation, and capitalization are ignored.
    /// If the `upstream` published `String` is less than 2 characters long,
    /// or if no names match, this publisher wont publish any values.
    ///
    /// - Parameter scheduler: _Required_ The scheduler on which this publisher delivers elements
    /// - Returns: A publisher that publishes a `[String]` containing up to
    ///            20 full English card names that could be autocompletions of the given `upstream` published element.
    func autocomplete<S: Scheduler>(on scheduler: S) -> AnyPublisher<[String], Error> {
        autocompletePublisher(upstream: self, scheduler: scheduler)
    }
}

// MARK: - Card

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _cardPublisher<U: Publisher, R: Publisher> (
    upstream: U, remotePublisherClosure: @escaping (URL) -> R
) -> AnyPublisher<Card, Combinefall.Error>
where
U.Output == String,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    fetchPublisher(
        upstream: upstream
            .first()
            .map { EndpointComponents.card(named: $0) },
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

// MARK: - Card Image

public enum ImageVersion: String {
    case small, normal, large, png, artCrop = "art_crop", borderCrop = "border_crop"
}

public struct CardImageParameters {
    public let name: String
    public let version: ImageVersion

    public init(name: String, version: ImageVersion) {
        self.name = name
        self.version = version
    }
}

// swiftlint:disable:next identifier_name
func _cardImageDataPublisher<U: Publisher, R: Publisher>(
    upstream: U, remotePublisherClosure: @escaping (URL) -> R
) -> AnyPublisher<Data, Error>
where
U.Output == CardImageParameters,
U.Failure == Never,
R.Output == URLSession.DataTaskPublisher.Output,
R.Failure == URLSession.DataTaskPublisher.Failure {
    dataPublisher(
        upstream: upstream
            .first()
            .map { EndpointComponents.cardImage(named: $0.name, version: $0.version).url },
        remotePublisherClosure: remotePublisherClosure
    )
    .eraseToAnyPublisher()
}

/// Creates a publisher connected to upstream that queries the `card/named` endpoint of Scryfall.
///
/// Names are case-insensitive and punctuation is optional (you can drop apostrophes and periods etc).
/// For example: `"fIReBALL"` is the same as `"Fireball"` and `"smugglers copter"` is the same as `"Smuggler's Copter"`.
///
/// - Parameter upstream: _Required_ A publisher which `Output` must be `(String, ImageVersion)`
/// The `String` should be set to the exact name of the card and `ImageVersion` desides what image will be returned.
/// - Returns: A publisher that publishes `Data` mathing the given `upstream` published element.
public func cardImageDataPublisher<U: Publisher>(upstream: U) -> AnyPublisher<Data, Error>
where U.Output == CardImageParameters, U.Failure == Never {
    _cardImageDataPublisher(upstream: upstream, remotePublisherClosure: URLSession.shared.dataTaskPublisher)
        .eraseToAnyPublisher()
}

public extension Publisher where Self.Output == CardImageParameters, Self.Failure == Never {
    /// Creates a publisher connected to upstream that queries the `card/named` endpoint of Scryfall.
    ///
    /// Names are case-insensitive and punctuation is optional (you can drop apostrophes and periods etc).
    /// For example: `"fIReBALL"` is the same as `"Fireball"`
    /// and `"smugglers copter"` is the same as `"Smuggler's Copter"`.
    ///
    /// - Parameter upstream: _Required_ A publisher which `Output` must be `(String, ImageVersion)`
    /// The `String` should be set to the exact name of the card and `ImageVersion` desides what image will be returned.
    /// - Returns: A publisher that publishes `Data` mathing the given `upstream` published element.
    func cardImageData() -> AnyPublisher<Data, Error> {
        cardImageDataPublisher(upstream: self)
    }
}
