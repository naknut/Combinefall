import XCTest
@testable import Combinefall

final class LegalityTests: XCTestCase {
    func testDoubleFacedTokenRawValue() {
        XCTAssert(
            Card.Legalities.Legality(rawValue: "not_legal") == .notLegal,
            "Legality is not of the right case"
        )
    }

    static var allTests = [
        ("testDoubleFacedTokenRawValue", testDoubleFacedTokenRawValue)
    ]
}
