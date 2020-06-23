import XCTest
import Combine
@testable import Combinefall

final class CardCollectionPublisherTests: XCTestCase {
    @Published var testUpstream: CardIdentifiers = CardIdentifiers([])
    var cancellable: AnyCancellable?

    func testSucessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = cardCollectionPublisher(
                upstream: $testUpstream,
                dataTaskPublisher: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.cardList) }
            )
        .assertNoFailure()
        .sink { _ in valueExpectation.fulfill() }
        wait(for: [valueExpectation], timeout: 10.0)
    }
}
