import Foundation

class LongRunningMockURLProtocol: URLProtocol {
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() { }
    
    override func stopLoading() { }
}
