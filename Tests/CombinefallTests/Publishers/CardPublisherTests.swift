import XCTest
import Combine
@testable import Combinefall

final class CardPublisherTests: XCTestCase {
    @Published var testUpstream: String = ""
    var cancellable: AnyCancellable?

    func testSucessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardPublisher(
            upstream: $testUpstream,
            dataTaskPublisher: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.card) }
        )
        .assertNoFailure()
        .sink { _ in valueExpectation.fulfill() }
        wait(for: [valueExpectation], timeout: 10.0)
    }
}
