import XCTest
import Combine
@testable import Combinefall

final class PublishersTests: XCTestCase {
    // swiftlint:disable:next force_try
    let testCard = try! JSONDecoder().decode(Card.self, from: TestData.card.data)

    var cancellable: AnyCancellable?
    func testAlternativePrintsListPublisher() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = testCard._alternativePrintsListPublisher(
                dataTaskPublisher: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.cardList) }
            )
            .assertNoFailure()
            .sink { _ in expectation.fulfill() }
        wait(for: [expectation], timeout: 10.0)
    }

    func testAlternativePrintsPublisher() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = testCard._alternativePrintsPublisher(
                dataTaskPublisher: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.cardList) }
            )
            .assertNoFailure()
            .sink { _ in expectation.fulfill() }
        wait(for: [expectation], timeout: 10.0)
    }
}
