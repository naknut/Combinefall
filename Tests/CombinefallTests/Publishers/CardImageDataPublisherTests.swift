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
            .sink(
                receiveCompletion: {
                    defer { completionExpectation.fulfill() }
                    switch $0 {
                    case .finished: return
                    default: XCTFail("Did not finish")
                    }
                },
                receiveValue: {
                    XCTAssert($0 == TestData.catalog.data)
                    valueExpectation.fulfill()
                })
        wait(for: [valueExpectation, completionExpectation], timeout: 10.0)
    }
}
