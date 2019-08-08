import XCTest
@testable import Combinefall

final class LanguageTests: XCTestCase {
    func testEnglishRawValue() {
        XCTAssert(
            Card.Language(rawValue: "en") == .english,
            "Language is not of the right case"
        )
    }

    func testSpanishRawValue() {
        XCTAssert(
            Card.Language(rawValue: "es") == .spanish,
            "Language is not of the right case"
        )
    }

    func testFrenchRawValue() {
        XCTAssert(
            Card.Language(rawValue: "fr") == .french,
            "Language is not of the right case"
        )
    }

    func testGermanRawValue() {
        XCTAssert(
            Card.Language(rawValue: "de") == .german,
            "Language is not of the right case"
        )
    }

    func testItalianRawValue() {
        XCTAssert(
            Card.Language(rawValue: "it") == .italian,
            "Language is not of the right case"
        )
    }

    func testPortugueseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "pt") == .portuguese,
            "Language is not of the right case"
        )
    }

    func testJapaneseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ja") == .japanese,
            "Language is not of the right case"
        )
    }

    func testKoreanRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ko") == .korean,
            "Language is not of the right case"
        )
    }

    func testRussianRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ru") == .russian,
            "Language is not of the right case"
        )
    }

    func testSimplifiedChineseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "zhs") == .simplifiedChinese,
            "Language is not of the right case"
        )
    }

    func testTraditionalChineseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "zht") == .traditionalChinese,
            "Language is not of the right case"
        )
    }

    func testHebrewRawValue() {
        XCTAssert(
            Card.Language(rawValue: "he") == .hebrew,
            "Language is not of the right case"
        )
    }

    func testLatinRawValue() {
        XCTAssert(
            Card.Language(rawValue: "la") == .latin,
            "Language is not of the right case"
        )
    }

    func testAncientGreekRawValue() {
        XCTAssert(
            Card.Language(rawValue: "grc") == .ancientGreek,
            "Language is not of the right case"
        )
    }

    func testArabicRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ar") == .arabic,
            "Language is not of the right case"
        )
    }

    func testSanskritRawValue() {
        XCTAssert(
            Card.Language(rawValue: "sa") == .sanskrit,
            "Language is not of the right case"
        )
    }

    func testPhyrexianRawValue() {
        XCTAssert(
            Card.Language(rawValue: "px") == .phyrexian,
            "Language is not of the right case"
        )
    }

    static var allTests = [
        ("testEnglishRawValue", testEnglishRawValue),
        ("testSpanishRawValue", testSpanishRawValue),
        ("testFrenchRawValue", testFrenchRawValue),
        ("testGermanRawValue", testGermanRawValue),
        ("testItalianRawValue", testItalianRawValue),
        ("testPortugueseRawValue", testPortugueseRawValue),
        ("testJapaneseRawValue", testJapaneseRawValue),
        ("testKoreanRawValue", testKoreanRawValue),
        ("testRussianRawValue", testRussianRawValue),
        ("testSimplifiedChineseRawValue", testSimplifiedChineseRawValue),
        ("testTraditionalChineseRawValue", testTraditionalChineseRawValue),
        ("testHebrewRawValue", testHebrewRawValue),
        ("testLatinRawValue", testLatinRawValue),
        ("testAncientGreekRawValue", testAncientGreekRawValue),
        ("testArabicRawValue", testArabicRawValue),
        ("testSanskritRawValue", testSanskritRawValue),
        ("testPhyrexianRawValue", testPhyrexianRawValue)
    ]
}
