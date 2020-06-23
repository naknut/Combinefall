import XCTest
import Combine
@testable import Combinefall

final class PublishersTests: XCTestCase {
    var testCard: Card!

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
    
    override func setUp() {
        super.setUp()
        let testCardPath = Bundle.module.path(forResource: "Card", ofType: "json", inDirectory: "Test Data")!
        // swiftlint:disable:next force_try
        self.testCard = try! JSONDecoder().decode(Card.self, from: try! Data(contentsOf: URL(fileURLWithPath: testCardPath)))
    }
}
