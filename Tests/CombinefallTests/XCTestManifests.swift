import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CatalogTests.allTests),
        testCase(LanguageTests.allTests),
        testCase(RelatedCardTests.allTests),
        testCase(CardFaceTests.allTests),
        testCase(LayoutTests.allTests),
        testCase(LegalityTests.allTests),
        testCase(AutocompleteTests.allTests),
        testCase(CardPublisherTests.allTests),
        testCase(FetchPublisherTests.allTests),
        testCase(FrameEffectTests.allTests),
        testCase(FrameTests.allTests),
        testCase(GameTests.allTests),
        testCase(PricesTests.allTests),
        testCase(CoreCardPropertiesTests.allTests),
        testCase(GameplayPropertiestTests.allTests),
        testCase(PrintPropertiestTests.allTests),
        testCase(CardImageDataPublisherTests.allTests),
        testCase(DataPublisherTests.allTests),
        testCase(ImageVersonTests.allTests)
    ]
}
#endif
