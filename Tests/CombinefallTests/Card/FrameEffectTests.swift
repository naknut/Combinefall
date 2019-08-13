import XCTest
@testable import Combinefall

final class FrameEffectTests: XCTestCase {
    func testSunAndMoonDoubleFaceCardRawValue() {
        XCTAssert(
            Card.FrameEffect(rawValue: "sunmoondfc") == .sunAndMoonDoubleFaceCard,
            "Language is not of the right case"
        )
    }

    func testCompassLandDoubleFaceCardRawValue() {
        XCTAssert(
            Card.FrameEffect(rawValue: "compasslanddfc") == .compassLandDoubleFaceCard,
            "Language is not of the right case"
        )
    }

    func testOriginsPlaneswalkerDoubleFaceCardRawValue() {
        XCTAssert(
            Card.FrameEffect(rawValue: "originpwdfc") == .originsPlaneswalkerDoubleFaceCard,
            "Language is not of the right case"
        )
    }

    func testMoonEldraziDoubleFaceCardRawValue() {
        XCTAssert(
            Card.FrameEffect(rawValue: "mooneldrazidfc") == .moonEldraziDoubleFaceCard,
            "Language is not of the right case"
        )
    }

    static var allTests = [
        ("testSunAndMoonDoubleFaceCardRawValue", testSunAndMoonDoubleFaceCardRawValue),
        ("testCompassLandDoubleFaceCardRawValue", testCompassLandDoubleFaceCardRawValue),
        ("testOriginsPlaneswalkerDoubleFaceCardRawValue", testOriginsPlaneswalkerDoubleFaceCardRawValue),
        ("testMoonEldraziDoubleFaceCardRawValue", testMoonEldraziDoubleFaceCardRawValue)
    ]
}
