// swiftlint:disable force_try
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
            dataTaskPublisher: { _ -> NewURLSessionMockPublisher in
                let path = Bundle.module.path(forResource: "Catalog", ofType: "json", inDirectory: "Test Data")!
                return NewURLSessionMockPublisher(data: try! Data(contentsOf: URL(fileURLWithPath: path)))
            }
        )
        .assertNoFailure()
        .sink {
            let rawDataPath = Bundle.module.path(forResource: "Catalog", ofType: "json", inDirectory: "Test Data")!
            let rawData = try! Data(contentsOf: URL(fileURLWithPath: rawDataPath))
            XCTAssert($0 == rawData)
            valueExpectation.fulfill()
        }
        wait(for: [valueExpectation], timeout: 10.0)
    }
}
