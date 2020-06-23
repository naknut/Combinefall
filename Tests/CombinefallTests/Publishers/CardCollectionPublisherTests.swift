import XCTest
import Combine
@testable import Combinefall

final class CardCollectionPublisherTests: XCTestCase {
    @Published var testUpstream: CardIdentifiers = CardIdentifiers([])
    var cancellable: AnyCancellable?

    func testSucessfullFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = cardCollectionPublisher(
            upstream: $testUpstream,
            dataTaskPublisher: { _ -> NewURLSessionMockPublisher in
                let path = Bundle.module.path(forResource: "Card List", ofType: "json", inDirectory: "Test Data")!
                return NewURLSessionMockPublisher(data: try! Data(contentsOf: URL(fileURLWithPath: path)))
            }
        )
        .assertNoFailure()
        .sink { _ in valueExpectation.fulfill() }
        wait(for: [valueExpectation], timeout: 10.0)
    }
}
