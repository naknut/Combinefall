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
        testCase(AutocompleteTests.allTests),
        testCase(CardPublisherTests.allTests),
        testCase(FetchPublisherTests.allTests)
    ]
}
#endif
