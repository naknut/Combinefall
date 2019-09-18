import XCTest
import Combine
@testable import Combinefall

final class ListTests: XCTestCase {
    func testTotalCardsCodingKey() {
        XCTAssert(
            List<String>.CodingKeys(rawValue: "total_cards") == .totalCards,
            "CodingKey is not of the right case"
        )
    }

    func testHasMoreCodingKey() {
        XCTAssert(
            List<String>.CodingKeys(rawValue: "has_more") == .hasMore,
            "CodingKey is not of the right case"
        )
    }

    func testNextPageCodingKey() {
        XCTAssert(
            List<String>.CodingKeys(rawValue: "next_page") == .nextPage,
            "CodingKey is not of the right case"
        )
    }

    func testNextPagePublisherWithNoNextPage() {
        // swiftlint:disable:next force_try
        let testList = try! JSONDecoder().decode(List<Card>.self, from: TestData.cardList.data)
        XCTAssertNil(testList.nextPagePublisher())
    }

    var cancellable: AnyCancellable?
    func testNextPagePublisher() {
        // swiftlint:disable:next force_try
        let testList = try! JSONDecoder().decode(List<Card>.self, from: TestData.cardListWithMore.data)
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = testList._nextPagePublisher(
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.cardList) }
            )?
            .assertNoFailure()
            .sink { _ in expectation.fulfill() }
        XCTAssertNotNil(cancellable)
        wait(for: [expectation], timeout: 10.0)
    }
}
