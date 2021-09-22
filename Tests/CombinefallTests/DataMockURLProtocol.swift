import Foundation

class DataMockURLProtocol: URLProtocol {
    static var data: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let client = client else { return }
        guard let data = DataMockURLProtocol.data else {
            fatalError("Data is unavailable.")
        }
        
        client.urlProtocol(
            self,
            didReceive: HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!,
            cacheStoragePolicy: .notAllowed
        )
        client.urlProtocol(self, didLoad: data)
        client.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
