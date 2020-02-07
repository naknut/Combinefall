import XCTest
import Combine
@testable import Combinefall

final class AutocompleteTests: XCTestCase {
    @Published var testUpstream: String = ""
    var cancellable: AnyCancellable?

    func testAutocompleteCatalog() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _autocompleteCatalogPublisher(
                upstream: $testUpstream,
                dataTaskPublisher: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.catalog) },
                scheduler: RunLoop.current
            )
            .assertNoFailure()
            .sink { catalog in
                XCTAssert(catalog.totalValues == 1)
                XCTAssert(catalog.data.count == 1)
                XCTAssert(catalog.data.first == "Jace")
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }

    func testAutocomplete() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _autocompletePublisher(
                upstream: $testUpstream,
                dataTaskPublisher: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.catalog) },
                scheduler: RunLoop.current
            )
            .assertNoFailure()
            .sink { list in
                XCTAssert(list.count == 1)
                XCTAssert(list.first == "Jace")
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }
}
