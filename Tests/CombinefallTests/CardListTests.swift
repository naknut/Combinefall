import XCTest
@testable import Combinefall

final class CardListTests: XCTestCase {
    var session: URLSession!
    
    let cardIdentifiers = CardIdentifiers([.scryfallIdentifier(UUID())])
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        
        let firstJsonUrl = Bundle.module.url(forResource: "CardListWithMore", withExtension: "json")!
        TwoDataMockURLProtocol.dataOne = try! Data(contentsOf: firstJsonUrl)
        
        let secondJsonUrl = Bundle.module.url(forResource: "CardList", withExtension: "json")!
        TwoDataMockURLProtocol.dataTwo = try! Data(contentsOf: secondJsonUrl)
        
        configuration.protocolClasses = [TwoDataMockURLProtocol.self]
        
        TwoDataMockURLProtocol.resetCallCounter()
        
        session = URLSession(configuration: configuration)
    }
    
    func testNextPage() async throws {
        let firstCardList = try await cardCollection(identifiers: cardIdentifiers, on: session).first!
        
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
    
    func testAsyncSequence() async throws {
        var cards = [Card]()
        let cardList = try await cardCollection(identifiers: cardIdentifiers, on: session).first!
        for try await card in cardList { cards.append(card) }
        
        XCTAssert(cards.count == 2)
    }
}
