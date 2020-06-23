import Combine
import Foundation

struct URLSessionMockPublisher: Publisher {
    private class NewURLSessionMockPublisherSubscription<S: Subscriber>: Subscription
    where S.Input == URLSessionMockPublisher.Output {
        var subscriber: S?
        let data: Data

        init(subscriber: S, data: Data) {
            self.subscriber = subscriber
            self.data = data
        }

        func request(_ demand: Subscribers.Demand) {
            _ = subscriber?.receive((data, URLResponse()))
            subscriber?.receive(completion: .finished)
        }

        func cancel() {
            subscriber = nil
        }
    }

    let data: Data

    typealias Output = URLSession.DataTaskPublisher.Output
    typealias Failure = URLSession.DataTaskPublisher.Failure

    func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
        subscriber.receive(
            subscription: NewURLSessionMockPublisherSubscription(subscriber: subscriber, data: data)
        )
    }
}
