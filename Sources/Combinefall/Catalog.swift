public struct Catalog<T>: Decodable where T: Decodable {
    typealias DataType = T
    
    let totalValues: Int
    let data: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalValues = "total_values", data
    }
}
