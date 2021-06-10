import Combine
import Foundation

public enum CardIdentifier: Encodable {
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
        case .scryfallIdentifier(let identifier):
            try container.encode(identifier, forKey: .scryfallIdentifier)
        case .magicOnlineIdentifier(let identifier):
            try container.encode(identifier, forKey: .magicOnlineIdentifier)
        case .multiverseIdentifier(let identifier):
            try container.encode(identifier, forKey: .multiverseIdentifier)
        case .oracleIdentifier(let identifier):
            try container.encode(identifier, forKey: .oracleIdentifier)
        case .illustrationIdentifier(let identifier):
            try container.encode(identifier, forKey: .illustrationIdentifier)
        case .name(let name):
            try container.encode(name, forKey: .name)
        case .nameAndSet(let name, let set):
            try container.encode(name, forKey: .name)
            try container.encode(set, forKey: .set)
        case .collectiorNumberAndSet(let collectiorNumber, let set):
            try container.encode(collectiorNumber, forKey: .collectiorNumber)
            try container.encode(set, forKey: .set)
        }
    }
}

public struct CardIdentifiers: Encodable {
    public let identifiers: [CardIdentifier]

    public init(_ identifiers: [CardIdentifier]) { self.identifiers = identifiers }

    public subscript(index: Int) -> CardIdentifier { identifiers[index] }
}
