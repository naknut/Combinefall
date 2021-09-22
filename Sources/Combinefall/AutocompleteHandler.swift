import Foundation

public typealias AutocompleteCatalog = Catalog<String>

public actor AutocompleteHandler {
    private var dataTask: URLSessionDataTask?
    private let session: URLSession
    
    public struct UnknownError: Swift.Error {
        let response: URLResponse?
        
        fileprivate init(response: URLResponse?) { self.response = response }
    }
    
    public func cancelIfRunning() {
        dataTask?.cancel()
    }
    
    public func autocompleteCatalog(query: String) async throws -> AutocompleteCatalog {
        cancelIfRunning()
        
        return try await withUnsafeThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: Endpoint.cards(.autocomplete(query)).url) { data, response, error in
                switch (data, error) {
                case let (data?, _):
                    do {
                        continuation.resume(returning: try JSONDecoder().decode(AutocompleteCatalog.self, from: data))
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case let (_, error?):
                    if (error as NSError).code == NSURLErrorCancelled {
                        continuation.resume(throwing: CancellationError())
                    } else {
                        continuation.resume(throwing: error)
                    }
                default: continuation.resume(throwing: UnknownError(response: response))
                }
            }
            self.dataTask = dataTask
            dataTask.resume()
        }
    }
    
    public func autocomplete(query: String) async throws -> [String] { try await autocompleteCatalog(query: query).data }
    
    public init(session: URLSession = .shared) { self.session = session }
    
    deinit { cancelIfRunning() }
}
