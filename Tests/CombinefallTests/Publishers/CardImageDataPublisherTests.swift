import XCTest
import Combine
@testable import Combinefall

final class CardImageDataPublisherTests: XCTestCase {
    @Published var testUpstream: (String, ImageVersion) = ("Ajani", .png)
    var cancellable: AnyCancellable?

    func testSuccessfullFetch() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardImageDataPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.catalog) }
            )
            .assertNoFailure()
            .sink {
                XCTAssert($0 == TestData.catalog.data)
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }

    static var allTests = [
        ("testSuccessfullFetch", testSuccessfullFetch)
    ]
}
