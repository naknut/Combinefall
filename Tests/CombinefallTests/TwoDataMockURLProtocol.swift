import Foundation

class TwoDataMockURLProtocol: URLProtocol {
    static var dataOne: Data?
    static var dataTwo: Data?
    
    private static var call: Int = 0
    
    static func resetCallCounter() { call = 0 }
    
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
        guard let dataOne = TwoDataMockURLProtocol.dataOne,
              let dataTwo = TwoDataMockURLProtocol.dataTwo else {
            fatalError("Data is unavailable.")
        }
        
        client.urlProtocol(
            self,
            didReceive: HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!,
            cacheStoragePolicy: .notAllowed
        )
        client.urlProtocol(self, didLoad: TwoDataMockURLProtocol.call == 0 ? dataOne : dataTwo)
        client.urlProtocolDidFinishLoading(self)
        TwoDataMockURLProtocol.call += 1
    }
    
    override func stopLoading() { }
}
