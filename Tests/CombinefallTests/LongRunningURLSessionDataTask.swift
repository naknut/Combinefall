import Foundation

class LongRunningURLSessionDataTask: URLSessionDataTask {
    let completionHandler: (Data?, URLResponse?, Error?) -> ()
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.completionHandler = completionHandler
    }
    
    override func resume() { }
    
    override func cancel() {
        completionHandler(nil, nil, NSError(domain: "MockError", code: NSURLErrorCancelled, userInfo: nil))
    }
}
