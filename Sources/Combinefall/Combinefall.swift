import Combine
import Foundation

fileprivate let baseURLComponent: URLComponents = URLComponents(string: "https://api.scryfall.com/")!

fileprivate enum EndpointComponents {
    case autocomplete
    
    var urlComponents: URLComponents {
        var urlComponent = baseURLComponent
        switch self {
        case .autocomplete: urlComponent.path = "/cards/autocomplete"
        }
        return urlComponent
    }
}

/// Creates a publisher connected to upstream that queries the autocomplete endpoint of Scryfall.
/// - Parameter upstream: _Required_ A publisher which `Output` must be `String`.
/// - Parameter scheduler: _Required_ The `Scheduler` on where to preform the operations.
/// - Returns: A publisher that publishes the results of the query as a `AutocompleteCatalog`
public func autocompleteCatalogPublisher<U: Publisher, S: Scheduler>(upstream: U, scheduler: S) -> AnyPublisher<AutocompleteCatalog, Never> where U.Output == String, U.Failure == Never {
    upstream
        .filter { $0.count >= 2 }
        .debounce(for: .milliseconds(100), scheduler: scheduler)
        .removeDuplicates()
        .compactMap { searchTerm in
            var autoCompleteComponents = EndpointComponents.autocomplete.urlComponents
            autoCompleteComponents.queryItems = [URLQueryItem(name: "q", value: searchTerm)]
            return autoCompleteComponents.url
        }
        .flatMap { (url: URL) in
            URLSession.shared.dataTaskPublisher(for: url).assertNoFailure()
        }
        .map { $0.data }
        .decode(type: AutocompleteCatalog.self, decoder: JSONDecoder())
        .replaceError(with: AutocompleteCatalog(totalValues: 0, data: []))
        .eraseToAnyPublisher()
}


/// Creates a publisher connected to upstream that queries the autocomplete endpoint of Scryfall.
/// - Parameter upstream: _Required_ A publisher which `Output` must be `String`.
/// - Parameter scheduler: _Required_ The `Scheduler` on where to preform the operations.
/// - Returns: A publisher that publishes the results of the query as a `[String]`
public func autocompletePublisher<U: Publisher, S: Scheduler>(upstream: U, scheduler: S) -> AnyPublisher<[String], Never> where U.Output == String, U.Failure == Never {
    autocompleteCatalogPublisher(upstream: upstream, scheduler: scheduler)
        .map { $0.data }
        .eraseToAnyPublisher()
}

public extension Publisher where Self.Output == String, Self.Failure == Never {
    
    
    /// Queries the autocomplete endpoint of Scryfall.
    /// - Parameter scheduler: _Required_ The scheduler on which this publisher delivers elements
    /// - Returns: A publisher that publishes the results of the query as a `AutocompleteCatalog`
    func autocompleteList<S: Scheduler>(on scheduler: S) -> AnyPublisher<AutocompleteCatalog, Never> {
        autocompleteCatalogPublisher(upstream: self, scheduler: scheduler)
    }
    
    /// Queries the autocomplete endpoint of Scryfall.
    /// - Parameter scheduler: _Required_ The scheduler on which this publisher delivers elements
    /// - Returns: A publisher that publishes the results of the query as a `[String]`
    func autocomplete<S: Scheduler>(on scheduler: S) -> AnyPublisher<[String], Never> {
        autocompletePublisher(upstream: self, scheduler: scheduler)
    }
}
