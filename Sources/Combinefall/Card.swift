import Foundation

///Represent individual _Magic: The Gathering_ cards that players
///could obtain and add to their collection (with a few minor exceptions).
public struct Card: Decodable {

    // MARK: - Core Card Properties

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

    // MARK: - Gameplay Properties

    public struct RelatedCard: Decodable {

        ///Explaining what role a `RelatedCard` plays in relationship to a `Card`
        public enum Component: String, Decodable {
            case token
            case meldPart = "meld_part"
            case meldResult = "meld_result"
            case comboPiece = "combo_piece"
        }

        ///An unique identifier for this card in Scryfall’s database.
        public let identifier: UUID
        public let component: Component
        public let name: String
        public let typeLine: String
        ///A `URL` where you can retrieve a full object describing this card on Scryfall’s API.
        public let url: URL

        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case component
            case name
            case typeLine = "type_line"
            case url = "uri"
        }
    }

    public struct CardFace: Decodable {
        ///The name of the illustrator of this card face. Newly spoiled cards may have this set to `nil`.
        public let artist: String?
        ///The colors in this face’s color indicator, if any.
        public let colorIndicator: [Color]?
        ///This face’s colors, if the game defines colors for the individual face of this card.
        public let colors: [Color]?
        ///The flavor text printed on this face, if any.
        public let flavorText: String?
        ///A unique identifier for the card face artwork that remains consistent across reprints.
        ///Newly spoiled cards may not have this field yet.
        public let illustrationIdentifier: UUID?
        ///An object providing URIs to imagery for this face, if this is a double-sided card.
        ///If this card is not double-sided, then the `ImageUrls` property will be part of the parent object instead.
        public let imageUrls: [URL]?
        ///This face’s loyalty, if any.
        public let loyalty: String?
        ///The mana cost for this face. This value will be any empty string "" if the cost is absent.
        ///Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
        public let manaCost: String
        ///The name of this particular face.
        public let name: String
        ///The Oracle text for this face, if any.
        public let oracleText: String?
        ///This face’s power, if any. Note that some cards have powers that are not numeric, such as *.
        public let power: String?
        ///The localized name printed on this face, if any.
        public let printedName: String?
        ///The localized text printed on this face, if any.
        public let printedText: String?
        ///The localized type line printed on this face, if any.
        public let printedTypeLine: String?
        ///This face’s toughness, if any.
        public let toughness: String?
        ///The type line of this particular face.
        public let typeLine: String
        ///The watermark on this particulary card face, if any.
        public let watermark: String?

        enum CodingKeys: String, CodingKey {
            case artist
            case colorIndicator = "color_indicator"
            case colors
            case flavorText = "flavor_text"
            case illustrationIdentifier = "illustration_id"
            case imageUrls = "image_uris"
            case loyalty
            case manaCost = "mana_cost"
            case name
            case oracleText = "oracle_text"
            case power
            case printedName = "printed_name"
            case printedText = "printed_text"
            case printedTypeLine = "printed_type_line"
            case toughness
            case typeLine = "type_line"
            case watermark
        }
    }

    ///If this card is closely related to other cards, this property will be set to an `[RelatedCard]`.
    public let allParts: [RelatedCard]?

    // MARK: - Decodeable
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
        case allParts = "all_parts"
    }
}
