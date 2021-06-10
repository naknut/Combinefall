import XCTest
@testable import Combinefall

// MARK: - Core Card Properties

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class GameplayPropertiestTests: XCTestCase {
    func testCardFacesCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "card_faces") == .cardFaces,
            "CodingKey is not of the right case"
        )
    }

    func testConvertedManaCostCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "cmc") == .convertedManaCost,
            "CodingKey is not of the right case"
        )
    }

    func testColorIdentityCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "color_identity") == .colorIdentity,
            "CodingKey is not of the right case"
        )
    }

    func testColorIndicatorCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "color_indicator") == .colorIndicator,
            "CodingKey is not of the right case"
        )
    }

    func testEdhrecRankCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "edhrec_rank") == .edhrecRank,
            "CodingKey is not of the right case"
        )
    }

    func testCanBeFoilCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "foil") == .canBeFoil,
            "CodingKey is not of the right case"
        )
    }

    func testHandModifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "hand_modifier") == .handModifier,
            "CodingKey is not of the right case"
        )
    }

    func testManaCostCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "mana_cost") == .manaCost,
            "CodingKey is not of the right case"
        )
    }

    func testCanBeNonFoilCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "nonfoil") == .canBeNonFoil,
            "CodingKey is not of the right case"
        )
    }

    func testOracleTextCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "oracle_text") == .oracleText,
            "CodingKey is not of the right case"
        )
    }

    func testTypeLineCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "type_line") == .typeLine,
            "CodingKey is not of the right case"
        )
    }
}
