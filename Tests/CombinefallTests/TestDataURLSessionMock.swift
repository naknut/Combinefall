import Foundation

class TestDataURLSessionMock: URLSession {
    private var testData: TestData

    init(testData: TestData) {
        self.testData = testData
    }

    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        TestDataURLSessionDataTaskMock(completionHandler: completionHandler, testData: testData)
    }
}
