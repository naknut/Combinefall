import Foundation

class TestDataURLSessionDataTaskMock: URLSessionDataTask {
    private let completionHandler: (Data?, URLResponse?, Error?) -> ()
    private let testData: TestData

    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> (), testData: TestData) {
        self.completionHandler = completionHandler
        self.testData = testData
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        completionHandler(testData.data,
                          URLResponse(url: URL(string: "https://example.com")!,
                                      mimeType: nil,
                                      expectedContentLength: 0,
                                      textEncodingName: nil),
                          nil)
    }
}
