import Foundation

class LongRunningURLSession: URLSession {
    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        LongRunningURLSessionDataTask(completionHandler: completionHandler)
    }
}
