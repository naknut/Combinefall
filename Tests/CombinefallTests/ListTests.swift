// swiftlint:disable force_try
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
        let testListPath = Bundle.module.path(forResource: "Card List", ofType: "json", inDirectory: "Test Data")!
        let testList = try! JSONDecoder().decode(List<Card>.self, from: try! Data(contentsOf: URL(fileURLWithPath: testListPath)))
        XCTAssertNil(testList.nextPagePublisher)
    }

    var cancellable: AnyCancellable?
    func testNextPagePublisher() {
        let testList = try! JSONDecoder().decode(List<Card>.self, from: TestData.cardListWithMore.data)
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = testList.nextPagePublisher(
            dataTaskPublisher: { _ -> NewURLSessionMockPublisher in
                let path = Bundle.module.path(forResource: "Card List", ofType: "json", inDirectory: "Test Data")!
                return NewURLSessionMockPublisher(data: try! Data(contentsOf: URL(fileURLWithPath: path)))
            }
        )?
        .assertNoFailure()
        .sink { _ in expectation.fulfill() }
        XCTAssertNotNil(cancellable)
        wait(for: [expectation], timeout: 10.0)
    }
}
