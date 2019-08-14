import XCTest
@testable import Combinefall

final class CoreCardPropertiesTests: XCTestCase {
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

    static var allTests = [
        ("testArenaIdentifierCodingKey", testArenaIdentifierCodingKey),
        ("testIdentifierCodingKey", testIdentifierCodingKey),
        ("testLanguageCodingKey", testLanguageCodingKey),
        ("testMagicOnlineIdentifierCodingKey", testMagicOnlineIdentifierCodingKey),
        ("testMagicOnlineFoilIdentifierCodingKey", testMagicOnlineFoilIdentifierCodingKey),
        ("testMultiverseIdentifierCodingKey", testMultiverseIdentifierCodingKey),
        ("testTcgPlayerIdentifierCodingKey", testTcgPlayerIdentifierCodingKey),
        ("testOracleIdentifierCodingKey", testOracleIdentifierCodingKey),
        ("testPrintsSearchUrlCodingKey", testPrintsSearchUrlCodingKey),
        ("testRulingsUrlCodingKey", testRulingsUrlCodingKey),
        ("testScryfallUrlCodingKey", testScryfallUrlCodingKey),
        ("testUrlCodingKey", testUrlCodingKey)
    ]
}
