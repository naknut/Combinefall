import XCTest
@testable import Combinefall

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
    
    func testtypeLineCodingKey() {
        XCTAssert(Card.RelatedCard.CodingKeys(rawValue: "type_line") == .typeLine, "CodingKey is of the wrong case")
    }
    
    func testUrlCodingKey() {
        XCTAssert(Card.RelatedCard.CodingKeys(rawValue: "uri") == .url, "CodingKey is of the wrong case")
    }
    
    static var allTests = [
        ("testComponentMeldPartRawValue", testComponentMeldPartRawValue),
        ("testComponentMeldResultRawValue", testComponentMeldResultRawValue),
        ("testComponentcomboPieceRawValue", testComponentcomboPieceRawValue),
        ("testIdentifierCodingKey", testIdentifierCodingKey),
        ("testtypeLineCodingKey", testtypeLineCodingKey),
        ("testUrlCodingKey", testUrlCodingKey)
    ]
}
