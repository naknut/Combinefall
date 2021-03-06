/// Contains an array of Magic datapoints (words, card values, etc).
///
/// `Catalog` is provided by `Combinefall` as a aid for building other Magic software and
/// understanding possible values for a field on Card objects.
public struct Catalog<T: Decodable>: ScryfallModel {
    public let object: String

    /// The number of items in the `data` array.
    public let totalValues: Int

    /// An array of datapoints.
    public let data: [T]

    enum CodingKeys: String, CodingKey {
        case object, totalValues = "total_values", data
    }
}
