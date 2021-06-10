import Foundation

public protocol ScryfallModel: Decodable {
    var object: String { get }
    
    static func from(jsonData: Data) throws -> Self
}

public extension ScryfallModel {
    static func from(jsonData: Data) throws -> Self { return try JSONDecoder().decode(Self.self, from: jsonData) }
}
