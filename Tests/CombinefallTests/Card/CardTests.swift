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

    func testCanBeFoundInBoosterCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "booster") == .canBeFoundInBooster,
            "CodingKey is not of the right case"
        )
    }

    func testBorderColorCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "border_color") == .borderColor,
            "CodingKey is not of the right case"
        )
    }

    func testCardBackIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "card_back_id") == .cardBackIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testCollectorNumberCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "collector_number") == .collectorNumber,
            "CodingKey is not of the right case"
        )
    }

    func testIsDigitalCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "digital") == .isDigital,
            "CodingKey is not of the right case"
        )
    }

    func testFlavorTextCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "flavor_text") == .flavorText,
            "CodingKey is not of the right case"
        )
    }

    func testFrameEffectCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "frame_effect") == .frameEffect,
            "CodingKey is not of the right case"
        )
    }

    func testFullArtCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "full_art") == .fullArt,
            "CodingKey is not of the right case"
        )
    }

    func testAvailableInCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "games") == .availableIn,
            "CodingKey is not of the right case"
        )
    }

    func testHasHighResolutionImageCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "highres_image") == .hasHighResolutionImage,
            "CodingKey is not of the right case"
        )
    }

    func testIllustrationIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "illustration_id") == .illustrationIdentifier,
            "CodingKey is not of the right case"
        )
    }

    func testImageUrlsCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "image_uris") == .imageUrls,
            "CodingKey is not of the right case"
        )
    }

    func testPrintedTextCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "printed_text") == .printedText,
            "CodingKey is not of the right case"
        )
    }

    func testPrintedTypeLineCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "printed_type_line") == .printedTypeLine,
            "CodingKey is not of the right case"
        )
    }

    func testIsPromoCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "promo") == .isPromo,
            "CodingKey is not of the right case"
        )
    }

    func testPromoTypesCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "promo_types") == .promoTypes,
            "CodingKey is not of the right case"
        )
    }

    func testPurchaseUrlsCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "purchase_uris") == .purchaseUrls,
            "CodingKey is not of the right case"
        )
    }

    func testRelatedUrlsCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "related_uris") == .relatedUrls,
            "CodingKey is not of the right case"
        )
    }

    func testIsReprintCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "reprint") == .isReprint,
            "CodingKey is not of the right case"
        )
    }

    func testScryfallSetUrlCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "scryfall_set_uri") == .scryfallSetUrl,
            "CodingKey is not of the right case"
        )
    }

    func testSetNameCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "set_name") == .setName,
            "CodingKey is not of the right case"
        )
    }

    func testSetSearchUrlCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "set_search_uri") == .setSearchUrl,
            "CodingKey is not of the right case"
        )
    }

    func testSetTypeCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "set_type") == .setType,
            "CodingKey is not of the right case"
        )
    }

    func testSetUrlCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "set_uri") == .setUrl,
            "CodingKey is not of the right case"
        )
    }

    func testSetCodeCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "set") == .setCode,
            "CodingKey is not of the right case"
        )
    }

    func testIsStorySpotlightCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "story_spotlight") == .isStorySpotlight,
            "CodingKey is not of the right case"
        )
    }

    func testIsTextlessCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "textless") == .isTextless,
            "CodingKey is not of the right case"
        )
    }

    func testIsVariationCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "variation") == .isVariation,
            "CodingKey is not of the right case"
        )
    }

    func testIsVariationOfCardWithIdentifierCodingKey() {
        XCTAssert(
            Card.CodingKeys(rawValue: "variation_of") == .isVariationOfCardWithIdentifier,
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
        ("testTypeLineCodingKey", testTypeLineCodingKey),
        ("testCanBeFoundInBoosterCodingKey", testCanBeFoundInBoosterCodingKey),
        ("testBorderColorCodingKey", testBorderColorCodingKey),
        ("testCardBackIdentifierCodingKey", testCardBackIdentifierCodingKey),
        ("testCollectorNumberCodingKey", testCollectorNumberCodingKey),
        ("testIsDigitalCodingKey", testIsDigitalCodingKey),
        ("testFlavorTextCodingKey", testFlavorTextCodingKey),
        ("testFrameEffectCodingKey", testFrameEffectCodingKey),
        ("testFullArtCodingKey", testFullArtCodingKey),
        ("testAvailableInCodingKey", testAvailableInCodingKey),
        ("testHasHighResolutionImageCodingKey", testHasHighResolutionImageCodingKey),
        ("testIllustrationIdentifierCodingKey", testIllustrationIdentifierCodingKey),
        ("testImageUrlsCodingKey", testImageUrlsCodingKey),
        ("testPrintedTextCodingKey", testPrintedTextCodingKey),
        ("testPrintedTypeLineCodingKey", testPrintedTypeLineCodingKey),
        ("testIsPromoCodingKey", testIsPromoCodingKey),
        ("testPromoTypesCodingKey", testPromoTypesCodingKey),
        ("testPurchaseUrlsCodingKey", testPurchaseUrlsCodingKey),
        ("testRelatedUrlsCodingKey", testRelatedUrlsCodingKey),
        ("testIsReprintCodingKey", testIsReprintCodingKey),
        ("testScryfallSetUrlCodingKey", testScryfallSetUrlCodingKey),
        ("testSetNameCodingKey", testSetNameCodingKey),
        ("testSetSearchUrlCodingKey", testSetSearchUrlCodingKey),
        ("testSetTypeCodingKey", testSetTypeCodingKey),
        ("testSetUrlCodingKey", testSetUrlCodingKey),
        ("testSetCodeCodingKey", testSetCodeCodingKey),
        ("testIsStorySpotlightCodingKey", testIsStorySpotlightCodingKey),
        ("testIsTextlessCodingKey", testIsTextlessCodingKey),
        ("testIsVariationCodingKey", testIsVariationCodingKey),
        ("testIsVariationOfCardWithIdentifierCodingKey", testIsVariationOfCardWithIdentifierCodingKey)
    ]
}
