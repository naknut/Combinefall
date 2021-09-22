import XCTest
@testable import Combinefall

final class AutocompleteHandlerTests: XCTestCase {
    var session: URLSession!
    
    func testAutocompleteCatalog() async throws {
        let jsonUrl = Bundle.module.url(forResource: "Catalog", withExtension: "json")!
        DataMockURLProtocol.data = try Data(contentsOf: jsonUrl)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [DataMockURLProtocol.self]
        let autocompleteHandler = AutocompleteHandler(session: URLSession(configuration: configuration))
        let results = try await autocompleteHandler.autocomplete(query: "Grizzly Bear")
        XCTAssert(results == ["Jace"])
    }
    
    actor WrappedGroup {
        
    }
    
    func testCancellation() async {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [LongRunningMockURLProtocol.self]
        session = URLSession(configuration: configuration)
        let autocompleteHandler = AutocompleteHandler(session: session)
        
        async let first = autocompleteHandler.autocomplete(query: "Grizzly Bear")
        async let second = autocompleteHandler.autocomplete(query: "Grizzly Bear")
        
        do {
            let _ = [try await first, try await second]
        } catch {
            XCTAssert(error is CancellationError)
            await autocompleteHandler.cancelIfRunning()
        }
    }
}
