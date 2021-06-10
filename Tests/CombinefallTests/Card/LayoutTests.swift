import XCTest
@testable import Combinefall

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class LayoutTests: XCTestCase {
    func testDoubleFacedTokenRawValue() {
        XCTAssert(
            Card.Layout(rawValue: "double_faced_token") == .doubleFacedToken,
            "Language is not of the right case"
        )
    }
}
