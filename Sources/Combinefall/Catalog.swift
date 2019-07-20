/// A Catalog object contains an array of Magic datapoints (words, card values, etc).
///
/// Catalog objects are provided by the API as aids for building other Magic software and understanding possible values for a field on Card objects.
public struct Catalog<T: Decodable>: Decodable {
    
    /// The number of items in the `data` array.
    let totalValues: Int
    
    /// An array of datapoints.
    let data: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalValues = "total_values", data
    }
}
