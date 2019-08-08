import XCTest
@testable import Combinefall

final class CardTests: XCTestCase {
    func testArenaIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "arena_id") == .arenaIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "id") == .identifier,
            "CodingKey is not of the right case"
        )
    }

    func testLanguageCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "lang") == .language,
            "CodingKey is not of the right case"
        )
    }

    func testMagicOnlineIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "mtgo_id") == .magicOnlineIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testMagicOnlineFoilIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "mtgo_foil_id") == .magicOnlineFoilIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testMultiverseIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "multiverse_ids") == .multiverseIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testTcgPlayerIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "tcgplayer_id") == .tcgPlayerIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testOracleIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "oracle_id") == .oracleIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testPrintsSearchUrlCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "prints_search_uri") == .printsSearchUrl,
            "CodingKey is not of the right case"
        )
    }

    func testRulingsUrlCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "rulings_uri") == .rulingsUrl,
            "CodingKey is not of the right case"
        )
    }

    func testScryfallUrlCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "scryfall_uri") == .scryfallUrl,
            "CodingKey is not of the right case"
        )
    }

    func testUrlCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "uri") == .url,
            "CodingKey is not of the right case"
        )
    }

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

    static var allTests = [
        ("testArenaIdentifierCodingKey", testArenaIdentifierCodingKey),
        ("testLanguageCodingKey", testLanguageCodingKey),
        ("testMagicOnlineIdentifierCodingKey", testMagicOnlineIdentifierCodingKey),
        ("testMagicOnlineFoilIdentifierCodingKey", testMagicOnlineFoilIdentifierCodingKey),
        ("testMultiverseIdentifierCodingKey", testMultiverseIdentifierCodingKey),
        ("testTcgPlayerIdentifierCodingKey", testTcgPlayerIdentifierCodingKey),
        ("testOracleIdentifierCodingKey", testOracleIdentifierCodingKey),
        ("testPrintsSearchUrlCodingKey", testPrintsSearchUrlCodingKey),
        ("testRulingsUrlCodingKey", testRulingsUrlCodingKey),
        ("testScryfallUrlCodingKey", testScryfallUrlCodingKey),
        ("testUrlCodingKey", testUrlCodingKey),
        ("testCardFacesCodingKey", testCardFacesCodingKey),
        ("testConvertedManaCostCodingKey", testConvertedManaCostCodingKey),
        ("testColorIdentityCodingKey", testColorIdentityCodingKey),
        ("testColorIndicatorCodingKey", testColorIndicatorCodingKey),
        ("testEdhrecRankCodingKey", testEdhrecRankCodingKey),
        ("testCanBeFoilCodingKey", testCanBeFoilCodingKey),
        ("testHandModifierCodingKey", testHandModifierCodingKey),
        ("testManaCostCodingKey", testManaCostCodingKey),
        ("testCanBeNonFoilCodingKey", testCanBeNonFoilCodingKey),
        ("testOracleTextCodingKey", testOracleTextCodingKey),
        ("testTypeLineCodingKey", testTypeLineCodingKey)
    ]
}
