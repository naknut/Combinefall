import XCTest
import Combine
@testable import Combinefall

final class CardPublisherTests: XCTestCase {
    @Published var testUpstream: String = ""
    var cancellable: AnyCancellable?

    func testCard() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        let completionExpectation = XCTestExpectation(description: "Let publisher finish")
        cancellable = _cardPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.card) }
            )
            .sink(
                receiveCompletion: { _ in completionExpectation.fulfill() },
                receiveValue: { _ in valueExpectation.fulfill() }
            )
        wait(for: [valueExpectation, completionExpectation], timeout: 10.0)
    }

    static var allTests = [
        ("testCard", testCard)
    ]
}
