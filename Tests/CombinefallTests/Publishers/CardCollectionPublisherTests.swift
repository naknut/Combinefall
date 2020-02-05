import XCTest
import Combine
@testable import Combinefall

final class CardCollectionPublisherTests: XCTestCase {
    @Published var testUpstream: CardIdentifiers = CardIdentifiers([])
    var cancellable: AnyCancellable?

    func testSucessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        let completionExpectation = XCTestExpectation(description: "Let publisher finish")
        cancellable = _cardCollectionPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.cardList) }
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
