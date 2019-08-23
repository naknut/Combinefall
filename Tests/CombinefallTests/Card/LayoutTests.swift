import XCTest
@testable import Combinefall

final class LayoutTests: XCTestCase {
    func testDoubleFacedTokenRawValue() {
        XCTAssert(
            Card.Layout(rawValue: "double_faced_token") == .doubleFacedToken,
            "Language is not of the right case"
        )
    }
}
