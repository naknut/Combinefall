import XCTest
@testable import Combinefall

final class LanguageTests: XCTestCase {
    func testLanguageEnglishRawValue() {
        XCTAssert(
            Card.Language(rawValue: "en") == .english,
            "Language is not of the right case"
        )
    }

    func testLanguageSpanishRawValue() {
        XCTAssert(
            Card.Language(rawValue: "es") == .spanish,
            "Language is not of the right case"
        )
    }

    func testLanguageFrenchRawValue() {
        XCTAssert(
            Card.Language(rawValue: "fr") == .french,
            "Language is not of the right case"
        )
    }

    func testLanguageGermanRawValue() {
        XCTAssert(
            Card.Language(rawValue: "de") == .german,
            "Language is not of the right case"
        )
    }

    func testLanguageItalianRawValue() {
        XCTAssert(
            Card.Language(rawValue: "it") == .italian,
            "Language is not of the right case"
        )
    }

    func testLanguagePortugueseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "pt") == .portuguese,
            "Language is not of the right case"
        )
    }

    func testLanguageJapaneseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ja") == .japanese,
            "Language is not of the right case"
        )
    }

    func testLanguageKoreanRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ko") == .korean,
            "Language is not of the right case"
        )
    }

    func testLanguageRussianRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ru") == .russian,
            "Language is not of the right case"
        )
    }

    func testLanguageSimplifiedChineseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "zhs") == .simplifiedChinese,
            "Language is not of the right case"
        )
    }

    func testLanguageTraditionalChineseRawValue() {
        XCTAssert(
            Card.Language(rawValue: "zht") == .traditionalChinese,
            "Language is not of the right case"
        )
    }

    func testLanguageHebrewRawValue() {
        XCTAssert(
            Card.Language(rawValue: "he") == .hebrew,
            "Language is not of the right case"
        )
    }

    func testLanguageLatinRawValue() {
        XCTAssert(
            Card.Language(rawValue: "la") == .latin,
            "Language is not of the right case"
        )
    }

    func testLanguageAncientGreekRawValue() {
        XCTAssert(
            Card.Language(rawValue: "grc") == .ancientGreek,
            "Language is not of the right case"
        )
    }

    func testLanguageArabicRawValue() {
        XCTAssert(
            Card.Language(rawValue: "ar") == .arabic,
            "Language is not of the right case"
        )
    }

    func testLanguageSanskritRawValue() {
        XCTAssert(
            Card.Language(rawValue: "sa") == .sanskrit,
            "Language is not of the right case"
        )
    }

    func testLanguagePhyrexianRawValue() {
        XCTAssert(
            Card.Language(rawValue: "px") == .phyrexian,
            "Language is not of the right case"
        )
    }

    static var allTests = [
        ("testLanguageEnglishRawValue", testLanguageEnglishRawValue),
        ("testLanguageSpanishRawValue", testLanguageSpanishRawValue),
        ("testLanguageFrenchRawValue", testLanguageFrenchRawValue),
        ("testLanguageGermanRawValue", testLanguageGermanRawValue),
        ("testLanguageItalianRawValue", testLanguageItalianRawValue),
        ("testLanguagePortugueseRawValue", testLanguagePortugueseRawValue),
        ("testLanguageJapaneseRawValue", testLanguageJapaneseRawValue),
        ("testLanguageKoreanRawValue", testLanguageKoreanRawValue),
        ("testLanguageRussianRawValue", testLanguageRussianRawValue),
        ("testLanguageSimplifiedChineseRawValue", testLanguageSimplifiedChineseRawValue),
        ("testLanguageTraditionalChineseRawValue", testLanguageTraditionalChineseRawValue),
        ("testLanguageHebrewRawValue", testLanguageHebrewRawValue),
        ("testLanguageLatinRawValue", testLanguageLatinRawValue),
        ("testLanguageAncientGreekRawValue", testLanguageAncientGreekRawValue),
        ("testLanguageArabicRawValue", testLanguageArabicRawValue),
        ("testLanguageSanskritRawValue", testLanguageSanskritRawValue),
        ("testLanguagePhyrexianRawValue", testLanguagePhyrexianRawValue)
    ]
}
