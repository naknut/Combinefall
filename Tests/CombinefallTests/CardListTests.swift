import XCTest
@testable import Combinefall

final class CardListTests: XCTestCase {
    func testNextPage() async throws {
        let configuration = URLSessionConfiguration.default
        
        let firstJsonUrl = Bundle.module.url(forResource: "CardListWithMore", withExtension: "json")!
        //let firstSession = DataURLSessionMock(data: try Data(contentsOf: firstJsonUrl))
        TwoDataMockURLProtocol.dataOne = try Data(contentsOf: firstJsonUrl)
        
        let secondJsonUrl = Bundle.module.url(forResource: "CardList", withExtension: "json")!
        //let secondSession = DataURLSessionMock(data: try Data(contentsOf: secondJsonUrl))
        TwoDataMockURLProtocol.dataTwo = try Data(contentsOf: secondJsonUrl)
        
        configuration.protocolClasses = [TwoDataMockURLProtocol.self]
        
        let cardIdentifiers = CardIdentifiers([.scryfallIdentifier(UUID())])
        let firstCardList = try await cardCollection(identifiers: cardIdentifiers, on: URLSession(configuration: configuration)).first!
        
        XCTAssert(firstCardList.hasMore)
        XCTAssert(firstCardList.totalCards == 1)
        XCTAssert(firstCardList.cards.count == 1)
        
        let secondCardList = try await firstCardList.nextPage
        guard let secondCardList = secondCardList else {
            XCTFail()
            return
        }
        
        XCTAssert(!secondCardList.hasMore)
        XCTAssert(secondCardList.totalCards == 1)
        XCTAssert(secondCardList.cards.count == 1)
    }
}
