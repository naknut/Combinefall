import Combine
import Foundation

private let baseURLComponent: URLComponents = URLComponents(string: "https://api.scryfall.com/")!

enum EndpointComponents {
    case autocomplete(searchTerm: String)
    case card(named: String)
    case cardImage(named: String, version: ImageVersion)
    case cardCollection(CardIdentifiers)

    private var url: URL {
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

    var urlRequest: URLRequest {
        switch self {
        case .cardCollection(let identifiers):
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            // swiftlint:disable:next force_try
            urlRequest.httpBody = try! JSONEncoder().encode(identifiers)
            return urlRequest
        default: return URLRequest(url: url)
        }
    }
}

public enum Error: Swift.Error {
    case network(underlying: URLError), decode(underlying: Swift.Error), scryfall(underlying: URLError)
}

typealias RemotePublisherClosure<R: Publisher> = (URLRequest) -> R
    where R.Output == URLSession.DataTaskPublisher.Output, R.Failure == URLSession.DataTaskPublisher.Failure

func dataPublisher<U: Publisher, R: Publisher> (
    upstream: U, remotePublisherClosure: @escaping (URLRequest) -> R
) -> AnyPublisher<Data, Error>
    where
    U.Output == URLRequest,
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
    upstream: U, remotePublisherClosure: @escaping (URLRequest) -> R
) -> AnyPublisher<Data, Error>
    where
    U.Output == EndpointComponents,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        dataPublisher(upstream: upstream.map { $0.urlRequest }, remotePublisherClosure: remotePublisherClosure)
}

func fetchPublisher<U: Publisher, R: Publisher, S: ScryfallModel> (
    upstream: U, remotePublisherClosure: @escaping (URLRequest) -> R
) -> AnyPublisher<S, Error>
    where
    U.Output == URLRequest,
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
    upstream: U, remotePublisherClosure: @escaping (URLRequest) -> R
) -> AnyPublisher<S, Error>
    where
    U.Output == EndpointComponents,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        fetchPublisher(upstream: upstream.map { $0.urlRequest }, remotePublisherClosure: remotePublisherClosure)
}
