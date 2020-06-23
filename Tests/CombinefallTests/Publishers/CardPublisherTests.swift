import XCTest
import Combine
@testable import Combinefall

final class CardPublisherTests: XCTestCase {
    @Published var testUpstream: String = ""
    var cancellable: AnyCancellable?

    func testSucessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardPublisher(
            upstream: $testUpstream,
            dataTaskPublisher: { _ -> NewURLSessionMockPublisher in
                let path = Bundle.module.path(forResource: "Card", ofType: "json", inDirectory: "Test Data")!
                return NewURLSessionMockPublisher(data: try! Data(contentsOf: URL(fileURLWithPath: path)))
            }
        )
        .assertNoFailure()
        .sink { _ in valueExpectation.fulfill() }
        wait(for: [valueExpectation], timeout: 10.0)
    }
}
