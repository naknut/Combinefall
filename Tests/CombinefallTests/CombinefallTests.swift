import XCTest
import Combine
@testable import Combinefall

final class CombinefallTests: XCTestCase {
    private struct URLSessionMockPublisher: Publisher {
        typealias Output = URLSession.DataTaskPublisher.Output
        typealias Failure = URLSession.DataTaskPublisher.Failure

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(subscription: URLSessionMockPublisherSubscription(subscriber: subscriber))
        }
    }

    private class URLSessionMockPublisherSubscription<S: Subscriber>: Subscription
    where S.Input == URLSessionMockPublisher.Output {
        var subscriber: S?

        init(subscriber: S) {
            self.subscriber = subscriber
        }

        func request(_ demand: Subscribers.Demand) {
            _ = subscriber?.receive((TestData.catalog.data, URLResponse()))
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

    private struct BadDataMockPublisher: Publisher {
        typealias Output = URLSession.DataTaskPublisher.Output
        typealias Failure = URLSession.DataTaskPublisher.Failure

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(subscription: BadDataSubscription(subscriber: subscriber))
        }
    }

    private class BadDataSubscription<S: Subscriber>: Subscription
    where S.Input == FailingURLSessionMockPublisher.Output, S.Failure == FailingURLSessionMockPublisher.Failure {
        var subscriber: S?

        init(subscriber: S) {
            self.subscriber = subscriber
        }

        func request(_ demand: Subscribers.Demand) {
            _ = subscriber?.receive((TestData.invalid.data, URLResponse()))
            subscriber?.receive(completion: .finished)
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
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher() },
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
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher() },
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
                remotePublisherClosure: { (_: URL) in BadDataMockPublisher() },
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

    static var allTests = [
        ("testAutocompleteCatalog", testAutocompleteCatalog),
        ("testAutocomplete", testAutocomplete),
        ("testNetworkError", testNetworkError),
        ("testDecodeError", testDecodeError)
    ]
}
