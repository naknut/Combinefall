import XCTest
import Combine
@testable import Combinefall

struct URLSessionMockPublisher: Publisher {
    typealias Output = URLSession.DataTaskPublisher.Output
    typealias Failure = Never
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        subscriber.receive(subscription: URLSessionMockPublisherSubscription(subscriber: subscriber))
    }
}

class URLSessionMockPublisherSubscription<S: Subscriber>: Subscription where S.Input == URLSessionMockPublisher.Output {
    var subscriber: S?
    let testData = try! JSONEncoder().encode(AutocompleteCatalog(totalValues: 1, data: ["Jace"]))
    
    init(subscriber: S) {
        self.subscriber = subscriber
    }
    
    func request(_ demand: Subscribers.Demand) {
        _ = subscriber?.receive((testData, URLResponse()))
    }
    
    func cancel() {
        subscriber = nil
    }
}

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
    
    @Published var testUpstream: String = ""
    
    func testAutocomplete() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        _ = _autocompleteCatalogPublisher(upstream: $testUpstream, remotePublisherFactory: { (_: URL) in URLSessionMockPublisher() }, scheduler: RunLoop.current)
            .sink { catalog in
                XCTAssert(catalog.totalValues == 1)
                XCTAssert(catalog.data.count == 1)
                XCTAssert(catalog.data.first == "Jace")
                expectation.fulfill()
            }
        testUpstream = "Foo"
        wait(for: [expectation], timeout: 10.0)
    }

    static var allTests = [
        ("testCatalog", testCatalog),
        ("testAutocomplete", testAutocomplete),
    ]
}
