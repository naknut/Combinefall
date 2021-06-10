import XCTest
@testable import Combinefall

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
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
}
