import XCTest
import Combine
@testable import Combinefall

final class ImageVersonTests: XCTestCase {
    func testArtCropRawValue() {
        XCTAssert(
            ImageVersion(rawValue: "art_crop") == .artCrop,
            "Frame is not of the right case"
        )
    }

    func testBorderCropRawValue() {
        XCTAssert(
            ImageVersion(rawValue: "border_crop") == .borderCrop,
            "Frame is not of the right case"
        )
    }

    static var allTests = [
        ("testArtCropRawValue", testArtCropRawValue),
        ("testBorderCropRawValue", testBorderCropRawValue)
    ]
}
