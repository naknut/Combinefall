import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CatalogTests.allTests),
        testCase(CardTests.allTests),
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
        testCase(PricesTests.allTests)
    ]
}
#endif
