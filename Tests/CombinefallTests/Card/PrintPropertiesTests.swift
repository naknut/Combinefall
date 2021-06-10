import XCTest
@testable import Combinefall

// MARK: - Core Card Properties

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class PrintPropertiestTests: XCTestCase {
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
}
