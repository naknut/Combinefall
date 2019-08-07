import Foundation

///Represent individual _Magic: The Gathering_ cards that players
///could obtain and add to their collection (with a few minor exceptions).
public struct Card: Decodable {

    //MARK: - Core Card Properties
    
    /// A language that a `Card` can be printed in.
    ///
    ///Scryfall archives Magic cards in 17 languages (including some unofficial languages).
    ///
    ///Our support for multiple languages in older sets is limited. We are expanding this data slowly over time.
    public enum Language: String, Decodable {
        case english = "en"
        case spanish = "es"
        case french = "fr"
        case german = "de"
        case italian = "it"
        case portuguese = "pt"
        case japanese = "ja"
        case korean = "ko"
        case russian = "ru"
        case simplifiedChinese = "zhs"
        case traditionalChinese = "zht"
        case hebrew = "he"
        case latin = "la"
        case ancientGreek = "grc"
        case arabic = "ar"
        case sanskrit = "sa"
        case phyrexian = "px"
    }

    ///The Arena ID, if any. A large percentage of cards are not available on Arena and if not this will be `nil`.
    public let arenaIdentifier: Int?
    
    ///A unique ID for this `Card` in Scryfall’s database.
    public let identifier: UUID
    
    ///The `Language` for this printing.
    public let language: Language
    
    ///The Magic Online ID (also known as the Catalog ID), if any.
    ///
    ///A large percentage of cards are not available on Magic Online and if not this will be `nil`.
    public let magicOnlineIdentifier: Int?
    
    ///The foil Magic Online ID (also known as the Catalog ID), if any.
    ///
    ///A large percentage of cards are not available on Magic Online and if not this will be `nil`.
    public let magicOnlineFoilIdentifier: Int?
    
    ///The multiverse IDs on Gatherer, if any, as an array of integers.
    ///
    ///Scryfall includes many promo cards, tokens, and other esoteric objects that do not have these identifiers.
    public let multiverseIdentifier: [Int]?
    
    ///The ID on TCGplayer’s API, also known as the productId.
    public let tcgPlayerIdentifier: Int
    
    ///A unique ID for oracle identity.
    ///
    ///This value is consistent across reprinted card editions,
    ///and unique among different cards with the same name (tokens, Unstable variants, etc).
    public let oracleIdentifier: UUID
    
    ///A link to where you can begin paginating all re/prints for this card on Scryfall’s API.
    public let printsSearchUrl: URL
    
    ///A link to the rulings list for this `Card` on Scryfall’s API.
    public let rulingsUrl: URL
    
    ///A link to the permapage for this `Card` on Scryfall’s website.
    public let scryfallUrl: URL
    
    ///A link to this `Card` on Scryfall’s API.
    public let url: URL

    //MARK: - Decodeable
    enum CodingKeys: String, CodingKey {
        case arenaIdentifier = "arena_id"
        case identifier
        case language = "lang"
        case magicOnlineIdentifier = "mtgo_id"
        case magicOnlineFoilIdentifier = "mtgo_foil_id"
        case multiverseIdentifier = "multiverse_ids"
        case tcgPlayerIdentifier = "tcgplayer_id"
        case oracleIdentifier = "oracle_id"
        case printsSearchUrl = "prints_search_uri"
        case rulingsUrl = "rulings_uri"
        case scryfallUrl = "scryfall_uri"
        case url = "uri"
    }
}
