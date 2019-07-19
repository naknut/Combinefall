import Combine
import Foundation

fileprivate let baseURLComponent: URLComponents = URLComponents(string: "https://api.scryfall.com/")!

fileprivate enum EndpointComponents {
    case autocomplete
    
    var urlComponents: URLComponents {
        var baseURLCopy = baseURLComponent
        switch self {
        case .autocomplete: baseURLCopy.path = "autocomplete"
        }
        return baseURLCopy
    }
}

/// Returns a publisher connected to upstream that queries the autocomplete endpoint of Scryfall and publishes a `AutocompleteCatalog`.
///
/// - Parameter upstream: A publisher which `Output` must be `String`.
/// - Parameter scheduler: The `RunLoop` on where to preform the operations. Default is the current `RunLoop`.
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

public func autocompletePublisher<U: Publisher>(upstream: U, scheduler: RunLoop = RunLoop.current) -> AnyPublisher<[String], Never> where U.Output == String, U.Failure == Never {
    autocompleteCatalogPublisher(upstream: upstream, scheduler: scheduler)
        .map { $0.data }
        .eraseToAnyPublisher()
}

public extension Publisher where Self.Output == String, Self.Failure == Never {
    func autocompleteList<T: RunLoop>(on scheduler: T) -> AnyPublisher<AutocompleteCatalog, Never> {
        autocompleteCatalogPublisher(upstream: self, scheduler: scheduler)
    }
    
    func autocomplete<T: RunLoop>(on scheduler: T) -> AnyPublisher<[String], Never> {
        autocompletePublisher(upstream: self, scheduler: scheduler)
    }
}
