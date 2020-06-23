import Combine
import Foundation

/// A `Catalog` containing up to 20 full English card names.
public typealias AutocompleteCatalog = Catalog<String>

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
/// - Parameters:
///     - upstream: _Required_ A publisher which `Output` must be `String`.
///     - scheduler: _Required_ The `Scheduler` on where to preform the operations.
///     - dataTaskPublisher: _Required_ A closure that returns `Publisher`
///         with `Output == URLSession.DataTaskPublisher.Output`
///         and `Failure == URLSession.DataTaskPublisher.Failure`.
///         This is so that you can supply your own `Publisher` from your own `URLSession`
/// - Returns: A publisher that publishes a `AutocompleteCatalog` containing up to
///            20 full English card names that could be autocompletions of the given `upstream` published element.
public func autocompleteCatalogPublisher<U: Publisher, R: Publisher, S: Scheduler> (
    upstream: U, dataTaskPublisher: @escaping (URLRequest) -> R, scheduler: S
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
            dataTaskPublisher: dataTaskPublisher
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
public func autocompleteCatalogPublisher<U: Publisher, S: Scheduler>(upstream: U, scheduler: S)
    -> AnyPublisher<AutocompleteCatalog, Error> where U.Output == String, U.Failure == Never {
        autocompleteCatalogPublisher(
            upstream: upstream,
            dataTaskPublisher: URLSession.shared.dataTaskPublisher,
            scheduler: scheduler
        )
}

// Used internaly to inject remote publisher for testing.
public func autocompletePublisher<U: Publisher, R: Publisher, S: Scheduler>(
    upstream: U, dataTaskPublisher: @escaping (URLRequest) -> R, scheduler: S
) -> AnyPublisher<[String], Error>
    where
    U.Output == String,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        autocompleteCatalogPublisher(
            upstream: upstream,
            dataTaskPublisher: dataTaskPublisher,
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
public func autocompletePublisher<U: Publisher, S: Scheduler>(upstream: U, scheduler: S)
    -> AnyPublisher<[String], Error> where U.Output == String, U.Failure == Never {
        autocompletePublisher(
            upstream: upstream,
            dataTaskPublisher: URLSession.shared.dataTaskPublisher,
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
