import XCTest
@testable import Combinefall

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class LegalityTests: XCTestCase {
    func testDoubleFacedTokenRawValue() {
        XCTAssert(
            Card.Legalities.Legality(rawValue: "not_legal") == .notLegal,
            "Legality is not of the right case"
        )
    }
}
