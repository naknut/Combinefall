import XCTest
@testable import Combinefall

final class CombinefallTests: XCTestCase {
    func testCatalog() {
        let testJSON = """
            {
                "total_values": 0,
                "data": []
            }
            """
        guard let catalog = try? JSONDecoder().decode(Catalog<String>.self, from: testJSON.data(using: .utf8)!) else {
            XCTFail("Could not decode JSON")
            return
        }
        XCTAssert(catalog.totalValues == 0)
    }

    static var allTests = [
        ("testCatalog", testCatalog),
    ]
}
