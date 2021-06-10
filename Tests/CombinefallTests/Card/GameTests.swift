import XCTest
@testable import Combinefall

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class GameTests: XCTestCase {
    func testMagicOnlineRawValue() {
        XCTAssert(
            Card.Game(rawValue: "mtgo") == .magicOnline,
            "Frame is not of the right case"
        )
    }
}
