//
//  GetCardTests.swift
//  
//
//  Created by Marcus Isaksson on 6/25/21.
//

import XCTest
@testable import Combinefall

final class GetCardTests: XCTestCase {
    func testGetCard() async throws {
        let jsonUrl = Bundle.module.url(forResource: "Card", withExtension: "json")!
        DataMockURLProtocol.data = try Data(contentsOf: jsonUrl)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [DataMockURLProtocol.self]
        
        let test = try await Combinefall.card(using: .exact("Grizzly Bear"), on: URLSession(configuration: configuration))
        print(test)
        
        //let _ = try await Combinefall.card(using: .exact("Grizzly Bear"), on: URLSession(configuration: configuration))
    }
}
