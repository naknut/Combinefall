import XCTest
import Combine
@testable import Combinefall

final class CardPublisherTests: XCTestCase {
    @Published var testUpstream: String = ""
    var cancellable: AnyCancellable?

    func testSucessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        let completionExpectation = XCTestExpectation(description: "Let publisher finish")
        cancellable = _cardPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.card) }
            )
            .sink(
                receiveCompletion: {
                    defer { completionExpectation.fulfill() }
                    switch $0 {
                    case .finished: return
                    default: XCTFail("Did not finish")
                    }
                },
                receiveValue: { _ in valueExpectation.fulfill() }
            )
        wait(for: [valueExpectation, completionExpectation], timeout: 10.0)
    }
}
