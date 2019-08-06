import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CombinefallTests.allTests),
        testCase(CatalogTests.allTests),
        testCase(CardTests.allTests)
    ]
}
#endif
