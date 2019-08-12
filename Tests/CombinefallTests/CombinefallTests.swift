import XCTest
import Combine
@testable import Combinefall

final class CombinefallTests: XCTestCase {
    private struct URLSessionMockPublisher: Publisher {
        let testData: TestData

        typealias Output = URLSession.DataTaskPublisher.Output
        typealias Failure = URLSession.DataTaskPublisher.Failure

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(
                subscription: URLSessionMockPublisherSubscription(subscriber: subscriber, testData: testData)
            )
        }
    }

    private class URLSessionMockPublisherSubscription<S: Subscriber>: Subscription
    where S.Input == URLSessionMockPublisher.Output {
        var subscriber: S?
        let testData: TestData

        init(subscriber: S, testData: TestData) {
            self.subscriber = subscriber
            self.testData = testData
        }

        func request(_ demand: Subscribers.Demand) {
            _ = subscriber?.receive((testData.data, URLResponse()))
            subscriber?.receive(completion: .finished)
        }

        func cancel() {
            subscriber = nil
        }
    }

    private struct FailingURLSessionMockPublisher: Publisher {
        typealias Output = URLSession.DataTaskPublisher.Output
        typealias Failure = URLSession.DataTaskPublisher.Failure

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(subscription: FailSubscription(subscriber: subscriber))
        }
    }

    private class FailSubscription<S: Subscriber>: Subscription
    where S.Input == FailingURLSessionMockPublisher.Output, S.Failure == FailingURLSessionMockPublisher.Failure {
        var subscriber: S?
        init(subscriber: S) {
            self.subscriber = subscriber
        }

        func request(_ demand: Subscribers.Demand) {
            subscriber?.receive(completion: Subscribers.Completion<URLError>.failure(URLError(.cannotDecodeRawData)))
        }

        func cancel() {
            subscriber = nil
        }
    }

    @Published var testUpstream: String = ""
    var cancellable: AnyCancellable?

    func testAutocompleteCatalog() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _autocompleteCatalogPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.catalog) },
                scheduler: RunLoop.current
            )
            .assertNoFailure()
            .sink { catalog in
                XCTAssert(catalog.totalValues == 1)
                XCTAssert(catalog.data.count == 1)
                XCTAssert(catalog.data.first == "Jace")
                expectation.fulfill()
            }
        testUpstream = "Foo"
        wait(for: [expectation], timeout: 10.0)
    }

    func testAutocomplete() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _autocompletePublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.catalog) },
                scheduler: RunLoop.current
            )
            .assertNoFailure()
            .sink { list in
                XCTAssert(list.count == 1)
                XCTAssert(list.first == "Jace")
                expectation.fulfill()
            }
        testUpstream = "Foo"
        wait(for: [expectation], timeout: 10.0)
    }

    func testNetworkError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _autocompletePublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in FailingURLSessionMockPublisher() },
                scheduler: RunLoop.current
            )
            .sink(
                receiveCompletion: {
                    defer { expectation.fulfill() }
                    guard case let .failure(combinefallError) = $0 else { XCTFail("Publisher didnt fail"); return }
                    guard case let .network(underlying: urlError) = combinefallError else {
                        XCTFail("Publisher sent wrong error")
                        return
                    }
                    guard urlError == URLError(.cannotDecodeRawData) else {
                        XCTFail("Underlying error not matching")
                        return
                    }
                },
                receiveValue: { _ in }
            )
        testUpstream = "Foo"
        wait(for: [expectation], timeout: 10.0)
    }

    func testDecodeError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _autocompletePublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.invalid) },
                scheduler: RunLoop.current
            )
            .sink(
                receiveCompletion: {
                    defer { expectation.fulfill() }
                    guard case let .failure(combinefallError) = $0 else { XCTFail("Publisher didnt fail"); return }
                    guard case .decode = combinefallError else { XCTFail("Publisher sent wrong error"); return }
                },
                receiveValue: { _ in }
            )
        testUpstream = "Foo"
        wait(for: [expectation], timeout: 10.0)
    }

    func testCard() {
        print(TestData.card.rawValue)
        let valueExpectation = XCTestExpectation(description: "Let publisher publish")
        let completionExpectation = XCTestExpectation(description: "Let publisher finish")
        cancellable = _cardPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.card) }
            )
            .sink(
                receiveCompletion: { _ in completionExpectation.fulfill() },
                receiveValue: { _ in valueExpectation.fulfill() }
            )
        wait(for: [valueExpectation, completionExpectation], timeout: 10.0)
    }
    
    func testCardNetworkError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in FailingURLSessionMockPublisher() }
            )
            .sink(
                receiveCompletion: {
                    defer { expectation.fulfill() }
                    guard case let .failure(combinefallError) = $0 else { XCTFail("Publisher didnt fail"); return }
                    guard case let .network(underlying: urlError) = combinefallError else {
                        XCTFail("Publisher sent wrong error")
                        return
                    }
                    guard urlError == URLError(.cannotDecodeRawData) else {
                        XCTFail("Underlying error not matching")
                        return
                    }
                },
                receiveValue: { _ in }
            )
        testUpstream = "Foo"
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCardDecodeError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = _cardPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.invalid) }
            )
            .sink(
                receiveCompletion: {
                    defer { expectation.fulfill() }
                    guard case let .failure(combinefallError) = $0 else { XCTFail("Publisher didnt fail"); return }
                    guard case .decode = combinefallError else { XCTFail("Publisher sent wrong error"); return }
                },
                receiveValue: { _ in }
            )
        testUpstream = "Foo"
        wait(for: [expectation], timeout: 10.0)
    }

    static var allTests = [
        ("testAutocompleteCatalog", testAutocompleteCatalog),
        ("testAutocomplete", testAutocomplete),
        ("testNetworkError", testNetworkError),
        ("testDecodeError", testDecodeError),
        ("testCard", testCard),
        ("testCardNetworkError", testCardNetworkError),
        ("testCardDecodeError", testCardDecodeError)
    ]
}
