import XCTest
@testable import Combinefall

final class CardIdentifierTests: XCTestCase {
    func testScryfallIdentifierCodingKey() {
        XCTAssert(
            CardIdentifier.CodingKeys(rawValue: "id") == .scryfallIdentifier,
            "CodingKey is not of the right case"
        )
    }
    
    func testMagicOnlineIdentifierCodingKey() {
        XCTAssert(
            CardIdentifier.CodingKeys(rawValue: "mtgo_id") == .magicOnlineIdentifier,
            "CodingKey is not of the right case"
        )
    }
    
    func testMultiverseIdentifierCodingKey() {
        XCTAssert(
            CardIdentifier.CodingKeys(rawValue: "multiverse_id") == .multiverseIdentifier,
            "CodingKey is not of the right case"
        )
    }
    
    func testIllustrationIdentifierCodingKey() {
        XCTAssert(
            CardIdentifier.CodingKeys(rawValue: "illustration_id") == .illustrationIdentifier,
            "CodingKey is not of the right case"
        )
    }
    
    func testCollectiorNumberCodingKey() {
        XCTAssert(
            CardIdentifier.CodingKeys(rawValue: "collector_number") == .collectiorNumber,
            "CodingKey is not of the right case"
        )
    }
    
    func testEncodeScryfallIdentifier() {
        let identifier = UUID()
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.scryfallIdentifier.rawValue)\":\"\(identifier)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.scryfallIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
    
    func testEncodeMagicOnlineIdentifier() {
        let identifier = 1
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.magicOnlineIdentifier.rawValue)\":\(identifier)}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.magicOnlineIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
    
    func testEncodeMultiversIdentifier() {
        let identifier = 1
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.multiverseIdentifier.rawValue)\":\(identifier)}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.multiverseIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
    
    func testEncodeOracleIdentifier() {
        let identifier = UUID()
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.oracleIdentifier.rawValue)\":\"\(identifier)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.oracleIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
    
    func testEncodeIllustrationIdentifier() {
        let identifier = UUID()
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.illustrationIdentifier.rawValue)\":\"\(identifier)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.illustrationIdentifier(identifier))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
    
    func testEncodeName() {
        let name = "Grizzly Bears"
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.name.rawValue)\":\"\(name)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.name(name))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
    
    func testEncodeNameAndSet() {
        let name = "Grizzly Bears"
        let set = "Alpha"
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.name.rawValue)\":\"\(name)\",\"\(CardIdentifier.CodingKeys.set.rawValue)\":\"\(set)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.nameAndSet(name: name, set: set))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
    
    func testEncodeCollectiorNumberAndSet() {
        let collectorNumber = "1"
        let set = "Alpha"
        let expectedJSON = "{\"\(CardIdentifier.CodingKeys.set.rawValue)\":\"\(set)\",\"\(CardIdentifier.CodingKeys.collectiorNumber.rawValue)\":\"\(collectorNumber)\"}"
        let jsonData = try! JSONEncoder().encode(CardIdentifier.collectiorNumberAndSet(collectorNumber: collectorNumber, set: set))
        XCTAssert(
            jsonData == expectedJSON.data(using: .utf8),
            "JSON: \(String(data: jsonData, encoding: .utf8)!) does not match expected JSON: \(expectedJSON)"
        )
    }
}
