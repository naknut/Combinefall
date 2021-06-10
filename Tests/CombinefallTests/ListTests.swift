import XCTest
import Combine
@testable import Combinefall

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class ListTests: XCTestCase {
    func testTotalCardsCodingKey() {
        XCTAssert(
            CardList.CodingKeys(rawValue: "total_cards") == .totalCards,
            "CodingKey is not of the right case"
        )
    }

    func testHasMoreCodingKey() {
        XCTAssert(
            CardList.CodingKeys(rawValue: "has_more") == .hasMore,
            "CodingKey is not of the right case"
        )
    }

    func testNextPageCodingKey() {
        XCTAssert(
            CardList.CodingKeys(rawValue: "next_page") == .nextPageUrl,
            "CodingKey is not of the right case"
        )
    }
}
