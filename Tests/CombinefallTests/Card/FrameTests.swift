import XCTest
@testable import Combinefall

final class FrameTests: XCTestCase {
    func testNineteenNinetyThreeRawValue() {
        XCTAssert(
            Card.Frame(rawValue: "1993") == .nineteenNinetyThree,
            "Frame is not of the right case"
        )
    }

    func testNineteenNinetySevenRawValue() {
        XCTAssert(
            Card.Frame(rawValue: "1997") == .nineteenNinetySeven,
            "Frame is not of the right case"
        )
    }

    func testTwentyOThreeRawValue() {
        XCTAssert(
            Card.Frame(rawValue: "2003") == .twentyOThree,
            "Frame is not of the right case"
        )
    }

    func testTwentyFifteenRawValue() {
        XCTAssert(
            Card.Frame(rawValue: "2015") == .twentyFifteen,
            "Frame is not of the right case"
        )
    }
}
