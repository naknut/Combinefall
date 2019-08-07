import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CombinefallTests.allTests),
        testCase(CatalogTests.allTests),
        testCase(CardTests.allTests),
        testCase(LanguageTests.allTests),
        testCase(RelatedCardTests.allTests)
    ]
}
#endif
