import XCTest
import Combine
@testable import Combinefall

final class CardImageDataPublisherTests: XCTestCase {
    @Published var testUpstream: (String, ImageVersion) = ("Ajani", .png)
    var cancellable: AnyCancellable?

    func testSuccessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        let completionExpectation = XCTestExpectation(description: "Let publisher finish")
        cancellable = _cardImageDataPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.catalog) }
            )
            .assertNoFailure()
            .sink(
                receiveCompletion: {
                    XCTAssert($0 == .finished)
                    completionExpectation.fulfill()
                },
                receiveValue: {
                    XCTAssert($0 == TestData.catalog.data)
                    valueExpectation.fulfill()
                })
        wait(for: [valueExpectation, completionExpectation], timeout: 10.0)
    }

    static var allTests = [
        ("testSuccessfullFetch", testSuccessfullFetch)
    ]
}
