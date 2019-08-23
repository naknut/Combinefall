import XCTest
import Combine
@testable import Combinefall

final class FetchPublisherTests: XCTestCase {
    @Published var testUpstream: URL = URL(string: "https://example.com")!
    var cancellable: AnyCancellable?

    func testDecodeError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = (fetchPublisher(
                upstream: $testUpstream,
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
}
