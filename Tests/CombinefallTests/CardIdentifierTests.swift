// swiftlint:disable force_try
import XCTest
@testable import Combinefall

final class CardIdentifierTests: XCTestCase {
    func testScryfallIdentifierCodingKey() {
        XCTAssert(
            CardIdentifiers.Identifier.CodingKeys(rawValue: "id") == .scryfallIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testMagicOnlineIdentifierCodingKey() {
        XCTAssert(
            CardIdentifiers.Identifier.CodingKeys(rawValue: "mtgo_id") == .magicOnlineIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testMultiverseIdentifierCodingKey() {
        XCTAssert(
            CardIdentifiers.Identifier.CodingKeys(rawValue: "multiverse_id") == .multiverseIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testIllustrationIdentifierCodingKey() {
        XCTAssert(
            CardIdentifiers.Identifier.CodingKeys(rawValue: "illustration_id") == .illustrationIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testCollectiorNumberCodingKey() {
        XCTAssert(
            CardIdentifiers.Identifier.CodingKeys(rawValue: "collector_number") == .collectiorNumber,
            "CodingKey is not of the right case"
        )
    }

    func testEncodeScryfallIdentifier() {
        let identifier = UUID()
        let expectedJSON = "{\"\(CardIdentifiers.Identifier.CodingKeys.scryfallIdentifier.rawValue)\":\"\(identifier)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifiers.Identifier.scryfallIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }

    func testEncodeMagicOnlineIdentifier() {
        let identifier = 1
        let expectedJSON = "{\"\(CardIdentifiers.Identifier.CodingKeys.magicOnlineIdentifier.rawValue)\":\(identifier)}"
        let jsonData = try! JSONEncoder().encode(CardIdentifiers.Identifier.magicOnlineIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }

    func testEncodeMultiversIdentifier() {
        let identifier = 1
        let expectedJSON = "{\"\(CardIdentifiers.Identifier.CodingKeys.multiverseIdentifier.rawValue)\":\(identifier)}"
        let jsonData = try! JSONEncoder().encode(CardIdentifiers.Identifier.multiverseIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }

    func testEncodeOracleIdentifier() {
        let identifier = UUID()
        let expectedJSON = "{\"\(CardIdentifiers.Identifier.CodingKeys.oracleIdentifier.rawValue)\":\"\(identifier)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifiers.Identifier.oracleIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }

    func testEncodeIllustrationIdentifier() {
        let identifier = UUID()
        let expectedJSON = "{\"\(CardIdentifiers.Identifier.CodingKeys.illustrationIdentifier.rawValue)\":\"\(identifier)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifiers.Identifier.illustrationIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }

    func testEncodeName() {
        let name = "Grizzly Bears"
        let expectedJSON = "{\"\(CardIdentifiers.Identifier.CodingKeys.name.rawValue)\":\"\(name)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifiers.Identifier.name(name))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }

    func testEncodeNameAndSet() {
        let name = "Grizzly Bears"
        let set = "Alpha"
        let expectedJSON =
            "{" +
            "\"\(CardIdentifiers.Identifier.CodingKeys.name.rawValue)\":\"\(name)\"," +
            "\"\(CardIdentifiers.Identifier.CodingKeys.set.rawValue)\":\"\(set)\"" +
            "}"
        let jsonData = try! JSONEncoder().encode(CardIdentifiers.Identifier.nameAndSet(name: name, set: set))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }

    func testEncodeCollectiorNumberAndSet() {
        let collectorNumber = "1"
        let set = "Alpha"
        let expectedJSON =
            "{" +
            "\"\(CardIdentifiers.Identifier.CodingKeys.set.rawValue)\":\"\(set)\"," +
            "\"\(CardIdentifiers.Identifier.CodingKeys.collectiorNumber.rawValue)\":\"\(collectorNumber)\"" +
            "}"
        let jsonData = try! JSONEncoder().encode(
            CardIdentifiers.Identifier.collectiorNumberAndSet(collectorNumber: collectorNumber, set: set)
        )
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
}
