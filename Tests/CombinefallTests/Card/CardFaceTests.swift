import XCTest
@testable import Combinefall

final class CardFaceTests: XCTestCase {
    func testColorIndicatorCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "color_indicator") == .colorIndicator,
            "CodingKey is not of the right case"
        )
    }

    func testFlavorTextCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "flavor_text") == .flavorText,
            "CodingKey is not of the right case"
        )
    }

    func testIllustrationIdentifierCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "illustration_id") == .illustrationIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testImageUrlsCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "image_uris") == .imageUrls,
            "CodingKey is not of the right case"
        )
    }

    func testManaCostCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "mana_cost") == .manaCost,
            "CodingKey is not of the right case"
        )
    }

    func testOracleTextCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "oracle_text") == .oracleText,
            "CodingKey is not of the right case"
        )
    }

    func testPrintedNameCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "printed_name") == .printedName,
            "CodingKey is not of the right case"
        )
    }

    func testPrintedTextCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "printed_text") == .printedText,
            "CodingKey is not of the right case"
        )
    }

    func testPrintedTypeLineCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "printed_type_line") == .printedTypeLine,
            "CodingKey is not of the right case"
        )
    }

    func testTypeLineLineCodingKey() {
        XCTAssert(
            Card.CardFace.CodingKeys(rawValue: "type_line") == .typeLine,
            "CodingKey is not of the right case"
        )
    }

    static var allTests = [
        ("testColorIndicatorCodingKey", testColorIndicatorCodingKey),
        ("testFlavorTextCodingKey", testFlavorTextCodingKey),
        ("testIllustrationIdentifierCodingKey", testIllustrationIdentifierCodingKey),
        ("testImageUrlsCodingKey", testImageUrlsCodingKey),
        ("testManaCostCodingKey", testManaCostCodingKey),
        ("testOracleTextCodingKey", testOracleTextCodingKey),
        ("testPrintedNameCodingKey", testPrintedNameCodingKey),
        ("testPrintedTextCodingKey", testPrintedTextCodingKey),
        ("testPrintedTypeLineCodingKey", testPrintedTypeLineCodingKey),
        ("testTypeLineLineCodingKey", testTypeLineLineCodingKey)
    ]
}
