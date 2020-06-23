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

    @Published var testURLRequestUpstream: URLRequest = URLRequest(url: URL(string: "https://example.com")!)
    @Published var testEndpointComponentsUpstream: EndpointComponents = .autocomplete(searchTerm: "Grizzly Bears")
    var cancellable: AnyCancellable?

    func testNetworkError() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = dataPublisher(
                upstream: $testURLRequestUpstream,
                dataTaskPublisher: { (_: URLRequest) in FailingURLSessionMockPublisher() }
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

    func testSuccessfullFetchWithUrl() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = dataPublisher(
                upstream: $testURLRequestUpstream,
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
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }

    func testSuccessfullFetchWithEndpointComponents() {
        let expectation = XCTestExpectation(description: "Let publisher publish")
        cancellable = dataPublisher(
                upstream: $testEndpointComponentsUpstream,
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
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }
}
