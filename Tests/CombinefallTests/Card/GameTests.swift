import XCTest
@testable import Combinefall

final class GameTests: XCTestCase {
    func testMagicOnlineRawValue() {
        XCTAssert(
            Card.Game(rawValue: "mtgo") == .magicOnline,
            "Frame is not of the right case"
        )
    }

    static var allTests = [
        ("testMagicOnlineRawValue", testMagicOnlineRawValue)
    ]
}
