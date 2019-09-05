import Combine
import Foundation

private let baseURLComponent: URLComponents = URLComponents(string: "https://api.scryfall.com/")!

private enum EndpointComponents {
    case autocomplete, cardNamed

    var urlComponents: URLComponents {
        var urlComponent = baseURLComponent
        switch self {
        case .autocomplete: urlComponent.path = "/cards/autocomplete"
        case .cardNamed: urlComponent.path = "/cards/named"
        }
        return urlComponent
    }
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
            .map { searchTerm -> URL in
                var autoCompleteComponents = EndpointComponents.autocomplete.urlComponents
                autoCompleteComponents.queryItems = [URLQueryItem(name: "q", value: searchTerm)]
                return autoCompleteComponents.url!
            },
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
            .map { cardName -> URL in
                var cardNamedComponents = EndpointComponents.cardNamed.urlComponents
                cardNamedComponents.queryItems = [URLQueryItem(name: "exact", value: cardName)]
                return cardNamedComponents.url!
            },
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
            .map { cardImageParameters -> URL in
                var autoCompleteComponents = EndpointComponents.cardNamed.urlComponents
                autoCompleteComponents.queryItems = [
                    URLQueryItem(name: "exact", value: cardImageParameters.name),
                    URLQueryItem(name: "format", value: "image"),
                    URLQueryItem(name: "version", value: cardImageParameters.version.rawValue)
                ]
                return autoCompleteComponents.url!
            },
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
