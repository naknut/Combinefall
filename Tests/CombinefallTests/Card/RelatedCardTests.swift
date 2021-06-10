import XCTest
@testable import Combinefall

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class RelatedCardTests: XCTestCase {
    func testComponentMeldPartRawValue() {
        XCTAssert(Card.RelatedCard.Component(rawValue: "meld_part") == .meldPart, "Enum is of wrong case.")
    }

    func testComponentMeldResultRawValue() {
        XCTAssert(Card.RelatedCard.Component(rawValue: "meld_result") == .meldResult, "Enum is of wrong case.")
    }

    func testComponentcomboPieceRawValue() {
        XCTAssert(Card.RelatedCard.Component(rawValue: "combo_piece") == .comboPiece, "Enum is of wrong case.")
    }

    func testIdentifierCodingKey() {
        XCTAssert(Card.RelatedCard.CodingKeys(rawValue: "id") == .identifier, "CodingKey is of the wrong case")
    }

    func testTypeLineCodingKey() {
        XCTAssert(Card.RelatedCard.CodingKeys(rawValue: "type_line") == .typeLine, "CodingKey is of the wrong case")
    }

    func testUrlCodingKey() {
        XCTAssert(Card.RelatedCard.CodingKeys(rawValue: "uri") == .url, "CodingKey is of the wrong case")
    }
}
