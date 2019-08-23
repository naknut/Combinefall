import Foundation
import Combine

///Represent individual _Magic: The Gathering_ cards that players
///could obtain and add to their collection (with a few minor exceptions).
// swiftlint:disable:next type_body_length
public struct Card: ScryfallModel {

    // MARK: - ScryfallModel

    let object: String

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

    public enum Layout: String, Decodable {
        case normal
        case split
        case flip
        case transform
        case meld
        case leveler
        case saga
        case planar
        case scheme
        case vanguard
        case token
        case doubleFacedToken = "double_faced_token"
        case emblem
        case augment
        case host
    }

    public struct Legalities: Decodable {
        public enum Legality: String, Decodable {
            case legal
            case notLegal = "not_legal"
            case restricted
            case banned
        }

        public let standard: Legality
        public let future: Legality
        public let modern: Legality
        public let legacy: Legality
        public let pauper: Legality
        public let vintage: Legality
        public let penny: Legality
        public let commander: Legality
        public let brawl: Legality
        public let duel: Legality
        public let oldschool: Legality
    }

    ///If this card is closely related to other cards, this property will be set to an `[RelatedCard]`.
    public let allParts: [RelatedCard]?
    ///An `[CardFace]`, if this card is multifaced.
    public let cardFaces: [CardFace]?
    ///The card’s converted mana cost. Note that some funny cards have fractional mana costs.
    public let convertedManaCost: Double
    ///This card’s colors, if the overall card has colors defined by the rules.
    ///Otherwise the colors will be on the `cardFaces`.
    public let colors: [Color]?
    ///This card’s color identity.
    public let colorIdentity: [Color]
    ///The colors in this card’s color indicator, if any.
    ///A `nil` value for this property indicates the card does not have one.
    public let colorIndicator: [Color]?
    ///This card’s overall rank/popularity on EDHREC. Not all cards are ranked.
    public let edhrecRank: Int?
    ///True if this printing exists in a foil version.
    public let canBeFoil: Bool
    ///This card’s hand modifier, if it is Vanguard card. This value will contain a delta, such as -1.
    public let handModifier: String?
    public let layout: Layout
    ///Legality of this card across play formats.
    public let legalities: Legalities
    ///This card’s life modifier, if it is Vanguard card. This value will contain a delta, such as +2.
    public let lifeModifier: String?
    ///The mana cost for this card. This value will be empty if the cost is absent.
    ///
    ///Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
    ///Multi-faced cards will report this value in card faces.
    public let manaCost: String?
    ///The name of this card. If this card has multiple faces, this field will contain both names separated by "//".
    public let name: String
    ///True if this printing exists in a nonfoil version.
    public let canBeNonFoil: Bool
    public let oracleText: String?
    public let oversized: Bool
    ///This card’s power, if any. Note that some cards have powers that are not numeric, such as *.
    public let power: String?
    ///True if this card is on the Reserved List.
    public let reserved: Bool
    ///This card’s toughness, if any. Note that some cards have toughnesses that are not numeric, such as *.
    public let toughness: String?
    public let typeLine: String

    // MARK: - Print properties

    public struct ImageUrls: Decodable {
        public let small: URL?
        public let normal: URL?
        public let large: URL?
        public let png: URL?
        public let artCrop: URL?
        public let borderCrop: URL?

        enum CodingKeys: String, CodingKey {
            case small
            case normal
            case large
            case png
            case artCrop = "art_crop"
            case borderCrop = "border_crop"
        }
    }

    public enum BorderColor: String, Decodable {
        case black, borderless, gold, silver, white
    }

    public enum FrameEffect: String, Decodable {
        case legendary
        case miracle
        case nyxtouched
        case draft
        case devoid
        case tombstone
        case colorshifted
        case sunAndMoonDoubleFaceCard = "sunmoondfc"
        case compassLandDoubleFaceCard = "compasslanddfc"
        case originsPlaneswalkerDoubleFaceCard = "originpwdfc"
        case moonEldraziDoubleFaceCard = "mooneldrazidfc"
    }

    public enum Frame: String, Decodable {
        case nineteenNinetyThree = "1993"
        case nineteenNinetySeven = "1997"
        case twentyOThree = "2003"
        case twentyFifteen = "2015"
        case future
    }

    public enum Game: String, Decodable {
        case paper, arena, magicOnline = "mtgo"
    }

    public enum Rarity: String, Decodable {
        case common, uncommon, rare, mythic
    }

    public struct Prices: Decodable {
        public let unitedStatesDollar: String?
        public let unitedStatesDollarFoil: String?
        public let euro: String?
        public let magicOnlineEventTicket: String?

        enum CodingKeys: String, CodingKey {
            case unitedStatesDollar = "usd"
            case unitedStatesDollarFoil = "usd_foil"
            case euro = "eur"
            case magicOnlineEventTicket = "tix"
        }
    }

    public struct PurchaseUrls: Decodable {
        public let tcgplayer: URL
        public let cardmarket: URL
        public let cardhoarder: URL
    }

    public struct RelatedUrls: Decodable {
        public let gatherer: URL
        public let tcgplayerDecks: URL
        public let edhrec: URL
        public let mtgtop8: URL

        enum CodingKeys: String, CodingKey {
            case gatherer
            case tcgplayerDecks = "tcgplayer_decks"
            case edhrec
            case mtgtop8
        }
    }

    ///The name of the illustrator of this card. Newly spoiled cards may not have this field yet.
    public let artist: String?
    public let canBeFoundInBooster: Bool
    public let borderColor: BorderColor
    ///The Scryfall ID for the card back design present on this card.
    public let cardBackIdentifier: UUID
    ///This card’s collector number.
    ///
    ///Note that collector numbers can contain non-numeric characters, such as letters or *.
    public let collectorNumber: String
    ///True if this is a digital card on Magic Online.
    public let isDigital: Bool
    public let flavorText: String?
    public let frameEffect: FrameEffect?
    public let frame: Frame
    ///True if this card’s artwork is larger than normal.
    public let fullArt: Bool
    ///A `[Game]` that this card print is available in,
    public let availableIn: [Game]
    ///True if this card’s imagery is high resolution.
    public let hasHighResolutionImage: Bool
    ///A unique identifier for the card artwork that remains consistent across reprints.
    ///
    ///Newly spoiled cards may not have this field yet.
    public let illustrationIdentifier: UUID?
    public let imageUrls: ImageUrls?
    ///Containing daily price information for this card
    public let prices: Prices
    ///The localized name printed on this card.
    public let printedName: String?
    ///The localized text printed on this card.
    public let printedText: String?
    ///The localized type line printed on this card
    public let printedTypeLine: String?
    public let isPromo: Bool
    ///A `[String]?` describing what categories of promo cards this card falls into.
    public let promoTypes: [String]?
    public let purchaseUrls: PurchaseUrls
    public let rarity: Rarity
    ///URLs to this card’s listing on other Magic: The Gathering online resources.
    public let relatedUrls: RelatedUrls
    // TODO: Add released_at
    public let isReprint: Bool
    ///A link to this card’s set on Scryfall’s website.
    public let scryfallSetUrl: URL
    ///This card’s full set name.
    public let setName: String
    ///A link to where you can begin paginating this card’s set on the Scryfall API.
    public let setSearchUrl: URL
    public let setType: String
    ///A link to this card’s [set object](https://scryfall.com/docs/api/sets) on Scryfall’s API.
    public let setUrl: URL
    public let setCode: String
    public let isStorySpotlight: Bool
    public let isTextless: Bool
    ///Whether this card is a variation of another printing.
    public let isVariation: Bool
    ///The printing ID of the printing this card is a variation of.
    public let isVariationOfCardWithIdentifier: UUID?
    public let watermark: String?

    /// Creates a publisher that will publish all of the alternativ prints of this card.
    ///
    /// - Returns: A publisher that publishes a `CardCatalog` with all alternative prints of this `Card`.
    public func alternativePrintsPublisher() -> AnyPublisher<CardCatalog, Error> {
        fetchPublisher(upstream: Just(printsSearchUrl), remotePublisherClosure: URLSession.shared.dataTaskPublisher)
    }

    // MARK: - Decodeable
    enum CodingKeys: String, CodingKey {
        case object
        case arenaIdentifier = "arena_id"
        case identifier = "id"
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
        case cardFaces = "card_faces"
        case convertedManaCost = "cmc"
        case colors
        case colorIdentity = "color_identity"
        case colorIndicator = "color_indicator"
        case edhrecRank = "edhrec_rank"
        case canBeFoil = "foil"
        case handModifier = "hand_modifier"
        case layout
        case legalities
        case lifeModifier = "life_modifier"
        case manaCost = "mana_cost"
        case name
        case canBeNonFoil = "nonfoil"
        case oracleText = "oracle_text"
        case oversized
        case power
        case reserved
        case toughness
        case typeLine = "type_line"
        case artist
        case canBeFoundInBooster = "booster"
        case borderColor = "border_color"
        case cardBackIdentifier = "card_back_id"
        case collectorNumber = "collector_number"
        case isDigital = "digital"
        case flavorText = "flavor_text"
        case frameEffect = "frame_effect"
        case frame
        case fullArt = "full_art"
        case availableIn = "games"
        case hasHighResolutionImage = "highres_image"
        case illustrationIdentifier = "illustration_id"
        case imageUrls = "image_uris"
        case prices
        case printedName = "printed_name"
        case printedText = "printed_text"
        case printedTypeLine = "printed_type_line"
        case isPromo = "promo"
        case promoTypes = "promo_types"
        case purchaseUrls = "purchase_uris"
        case rarity
        case relatedUrls = "related_uris"
        case isReprint = "reprint"
        case scryfallSetUrl = "scryfall_set_uri"
        case setName = "set_name"
        case setSearchUrl = "set_search_uri"
        case setType = "set_type"
        case setUrl = "set_uri"
        case setCode = "set"
        case isStorySpotlight = "story_spotlight"
        case isTextless = "textless"
        case isVariation = "variation"
        case isVariationOfCardWithIdentifier = "variation_of"
        case watermark
    }
// swiftlint:disable:next file_length
}
