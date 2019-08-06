import Foundation

public struct Card: Decodable {
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

    let arenaIdentifier: Int?
    let identifier: UUID
    let language: Language
    let magicOnlineIdentifier: Int?
    let magicOnlineFoilIdentifier: Int?
    let multiverseIdentifier: [Int]?
    let tcgPlayerIdentifier: Int
    let oracleIdentifier: UUID
    let printsSearchUrl: URL
    let rulingsUrl: URL
    let scryfallUrl: URL
    let url: URL

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
