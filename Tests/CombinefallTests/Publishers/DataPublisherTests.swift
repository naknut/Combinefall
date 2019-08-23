import XCTest
import Combine
@testable import Combinefall

final class DataPublisherTests: XCTestCase {
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

    @Published var testUpstream: URL = URL(string: "https://example.com")!
    var cancellable: AnyCancellable?

    func testNetworkError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = dataPublisher(
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
        wait(for: [expectation], timeout: 10.0)
    }

    func testSuccessfullFetch() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = dataPublisher(
                upstream: $testUpstream,
                remotePublisherClosure: { (_: URL) in URLSessionMockPublisher(testData: TestData.catalog) }
            )
            .assertNoFailure()
            .sink {
                XCTAssert($0 == TestData.catalog.data)
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }
}
