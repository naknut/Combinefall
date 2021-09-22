import Combine
import Foundation

public struct CardIdentifiers {
    public enum Identifier: Encodable {
        case scryfallIdentifier(UUID)
        case magicOnlineIdentifier(Int)
        case multiverseIdentifier(Int)
        case oracleIdentifier(UUID)
        case illustrationIdentifier(UUID)
        case name(String)
        case nameAndSet(name: String, set: String)
        case collectiorNumberAndSet(collectorNumber: String, set: String)

        enum CodingKeys: String, CodingKey {
            case scryfallIdentifier = "id"
            case magicOnlineIdentifier = "mtgo_id"
            case multiverseIdentifier = "multiverse_id"
            case oracleIdentifier = "oracle_id"
            case illustrationIdentifier = "illustration_id"
            case name
            case set
            case collectiorNumber = "collector_number"
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .scryfallIdentifier(let identifier): try container.encode(identifier, forKey: .scryfallIdentifier)
            case .magicOnlineIdentifier(let identifier): try container.encode(identifier, forKey: .magicOnlineIdentifier)
            case .multiverseIdentifier(let identifier): try container.encode(identifier, forKey: .multiverseIdentifier)
            case .oracleIdentifier(let identifier): try container.encode(identifier, forKey: .oracleIdentifier)
            case .illustrationIdentifier(let identifier): try container.encode(identifier, forKey: .illustrationIdentifier)
            case .name(let name): try container.encode(name, forKey: .name)
            case .nameAndSet(let name, let set):
                try container.encode(name, forKey: .name)
                try container.encode(set, forKey: .set)
            case .collectiorNumberAndSet(let collectiorNumber, let set):
                try container.encode(collectiorNumber, forKey: .collectiorNumber)
                try container.encode(set, forKey: .set)
            }
        }
    }
    
    let identifiers: [Identifier]

    public init(_ identifiers: [Identifier]) { self.identifiers = identifiers }
    
    public init(_ identifiersSlice: Slice<CardIdentifiers>) { self.init(Array(identifiersSlice)) }
}

extension CardIdentifiers: Encodable {
    public func encode(to encoder: Encoder) throws { try identifiers.encode(to: encoder) }
}

extension CardIdentifiers: Collection {
    public var startIndex: Int { identifiers.startIndex }
    
    public var endIndex: Int { identifiers.endIndex }
    
    public subscript(index: Int) -> Identifier { identifiers[index] }
    
    public func index(after i: Int) -> Int { identifiers.index(after: i) }
    
    public var splittedOnCapacity: [CardIdentifiers] {
        stride(from: 0, to: count, by: 75).map { CardIdentifiers(self[$0 ..< Swift.min($0 + 75, count)]) }
    }
}

struct CardLists {
    typealias Element = Card
    
    public let cardLists: [CardList]
    
    public init(cardLists: [CardList]) {
        self.cardLists = cardLists
    }
}

public func cardCollection(identifiers: CardIdentifiers, on session: URLSession = .shared) async throws -> [CardList] {
    let identifiersSplits = identifiers.splittedOnCapacity
    
    var cardLists = [CardList]()
    for identifiers in identifiersSplits {
        var request = URLRequest(url: Endpoint.cards(.collection).url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(identifiers)
        
        print(request)
        
        var cardList = try CardList.from(jsonData: try await session.data(for: request).0)
        cardList.session = session
        cardLists.append(cardList)
    }
    
    return cardLists
}
