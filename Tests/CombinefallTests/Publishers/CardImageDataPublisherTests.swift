import XCTest
import Combine
@testable import Combinefall

final class CardImageDataPublisherTests: XCTestCase {
    @Published var testUpstream = CardImageParameters(name: "Ajani", version: .png)
    var cancellable: AnyCancellable?

    func testSuccessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardImageDataPublisher(
            upstream: $testUpstream,
            dataTaskPublisher: { (_: URLRequest) in URLSessionMockPublisher(testData: TestData.catalog) }
        )
            .assertNoFailure()
            .sink {
                XCTAssert($0 == TestData.catalog.data)
                valueExpectation.fulfill()
        }
        wait(for: [valueExpectation], timeout: 10.0)
    }
}
