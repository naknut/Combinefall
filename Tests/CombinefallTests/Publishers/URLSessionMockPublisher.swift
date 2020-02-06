import Combine
import Foundation

struct URLSessionMockPublisher: Publisher {
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

    let testData: TestData

    typealias Output = URLSession.DataTaskPublisher.Output
    typealias Failure = URLSession.DataTaskPublisher.Failure

    func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
        subscriber.receive(
            subscription: URLSessionMockPublisherSubscription(subscriber: subscriber, testData: testData)
        )
    }
}
