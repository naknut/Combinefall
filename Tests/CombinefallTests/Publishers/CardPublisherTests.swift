import XCTest
import Combine
@testable import Combinefall

final class CardPublisherTests: XCTestCase {
    @Published var stringTestUpstream: String = ""
    @Published var idTestUpstream: UUID = UUID()
    var cancellable: AnyCancellable?

    func testNameFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardPublisher(
            upstream: $stringTestUpstream,
            dataTaskPublisher: { _ -> URLSessionMockPublisher in
                let path = Bundle.module.path(forResource: "Card", ofType: "json", inDirectory: "Test Data")!
                // swiftlint:disable:next force_try
                return URLSessionMockPublisher(data: try! Data(contentsOf: URL(fileURLWithPath: path)))
            }
        )
        .assertNoFailure()
        .sink { _ in valueExpectation.fulfill() }
        wait(for: [valueExpectation], timeout: 10.0)
    }
    
    func testIdFetch() {
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardPublisher(
            upstream: $idTestUpstream,
            dataTaskPublisher: { _ -> URLSessionMockPublisher in
                let path = Bundle.module.path(forResource: "Card", ofType: "json", inDirectory: "Test Data")!
                // swiftlint:disable:next force_try
                return URLSessionMockPublisher(data: try! Data(contentsOf: URL(fileURLWithPath: path)))
            }
        )
        .assertNoFailure()
        .sink { _ in valueExpectation.fulfill() }
        wait(for: [valueExpectation], timeout: 10.0)
    }
}
