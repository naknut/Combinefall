import XCTest
import Combine
@testable import Combinefall

final class FetchPublisherTests: XCTestCase {
    @Published var testUrlUpstream: URL = URL(string: "https://example.com")!
    @Published var testEndpointComponentsUpstream: EndpointComponents = .autocomplete(searchTerm: "Grizzly Bears")
    
    var cancellable: AnyCancellable?

    func testDecodeError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = (fetchPublisher(
                upstream: $testUrlUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.invalid) }
            ) as AnyPublisher<AutocompleteCatalog, Combinefall.Error>)
            .sink(
                receiveCompletion: {
                    defer { expectation.fulfill() }
                    guard case let .failure(combinefallError) = $0 else { XCTFail("Publisher didnt fail"); return }
                    guard case .decode = combinefallError else { XCTFail("Publisher sent wrong error"); return }
                },
                receiveValue: { _ in }
            )
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSuccessfullFetchWithUrl() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = (fetchPublisher(
                upstream: $testUrlUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.catalog) }
            ) as AnyPublisher<AutocompleteCatalog, Combinefall.Error>)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in expectation.fulfill() }
            )
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSuccessfullWithFetchEndpointComponents() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = (fetchPublisher(
                upstream: $testEndpointComponentsUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.catalog) }
            ) as AnyPublisher<AutocompleteCatalog, Combinefall.Error>)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in expectation.fulfill() }
            )
        wait(for: [expectation], timeout: 10.0)
    }
}
