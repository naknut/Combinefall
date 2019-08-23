import XCTest
@testable import Combinefall

final class CatalogTests: XCTestCase {
    func testTotalValuesCodingKey() {
        XCTAssert(
            Catalog<String>.CodingKeys(rawValue: "total_values") == .totalValues,
            "CodingKey is not of the right case"
        )
    }
}
