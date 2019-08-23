import XCTest
@testable import Combinefall

final class PricesTests: XCTestCase {
    func unitedStatesDollarCodingKey() {
        XCTAssert(
            Card.Prices.CodingKeys(rawValue: "usd") == .unitedStatesDollar,
            "Legality is not of the right case"
        )
    }

    func unitedStatesDollarFoilCodingKey() {
        XCTAssert(
            Card.Prices.CodingKeys(rawValue: "usd_foil") == .unitedStatesDollarFoil,
            "Legality is not of the right case"
        )
    }

    func euroCodingKey() {
        XCTAssert(
            Card.Prices.CodingKeys(rawValue: "eur") == .euro,
            "Legality is not of the right case"
        )
    }

    func magicOnlineEventTicketCodingKey() {
        XCTAssert(
            Card.Prices.CodingKeys(rawValue: "tix") == .magicOnlineEventTicket,
            "Legality is not of the right case"
        )
    }
}
