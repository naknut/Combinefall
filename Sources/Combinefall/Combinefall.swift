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

// MARK: - Autocomplete

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _autocompleteCatalogPublisher<U: Publisher, R: Publisher, S: Scheduler> (
    upstream: U,
    remotePublisherClosure: @escaping (URL) -> R, scheduler: S
) -> AnyPublisher<AutocompleteCatalog, Combinefall.Error>
where
    U.Output == String,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
    upstream
        .debounce(for: .milliseconds(100), scheduler: scheduler)
        .removeDuplicates()
        .setFailureType(to: URLSession.DataTaskPublisher.Failure.self)
        .flatMap { searchTerm -> R in
            var autoCompleteComponents = EndpointComponents.autocomplete.urlComponents
            autoCompleteComponents.queryItems = [URLQueryItem(name: "q", value: searchTerm)]
            return remotePublisherClosure(autoCompleteComponents.url!)
        }
        .map { $0.data }
        .decode(type: AutocompleteCatalog.self, decoder: JSONDecoder())
        .mapError { error -> Combinefall.Error in
            if let urlError = error as? URLError {
                if 400...500 ~= urlError.errorCode { return .scryfall(underlying: urlError) }
                return .network(underlying: urlError)
            }
            return .decode(underlying: error)
        }
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

// MARK: - Cards

// Used internaly to inject remote publisher for testing.
// swiftlint:disable:next identifier_name
func _cardPublisher<U: Publisher, R: Publisher, S: Scheduler> (
    upstream: U,
    remotePublisherClosure: @escaping (URL) -> R, scheduler: S
) -> AnyPublisher<Card, Combinefall.Error>
where
    U.Output == String,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
    upstream
        .debounce(for: .milliseconds(100), scheduler: scheduler)
        .removeDuplicates()
        .setFailureType(to: URLSession.DataTaskPublisher.Failure.self)
        .flatMap { cardName -> R in
            var cardNamedComponents = EndpointComponents.cardNamed.urlComponents
            cardNamedComponents.queryItems = [URLQueryItem(name: "exact", value: cardName)]
            return remotePublisherClosure(cardNamedComponents.url!)
        }
        .map { $0.data }
        .decode(type: Card.self, decoder: JSONDecoder())
        .mapError { error -> Combinefall.Error in
            if let urlError = error as? URLError {
                if 400...500 ~= urlError.errorCode { return .scryfall(underlying: urlError) }
                return .network(underlying: urlError)
            }
            return .decode(underlying: error)
        }
        .eraseToAnyPublisher()
}

public func cardPublisher<U: Publisher, S: Scheduler>(
    upstream: U, scheduler: S
) -> AnyPublisher<Card, Error>
where U.Output == String, U.Failure == Never {
    _cardPublisher(
        upstream: upstream,
        remotePublisherClosure: URLSession.shared.dataTaskPublisher,
        scheduler: scheduler
    )
}

public extension Publisher where Self.Output == String, Self.Failure == Never {
    func card<S: Scheduler>(on scheduler: S) -> AnyPublisher<Card, Error> {
        cardPublisher(upstream: self, scheduler: scheduler)
    }
}
