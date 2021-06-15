//
//  EndpointTests.swift
//  
//
//  Created by Marcus Isaksson on 6/10/21.
//

import XCTest
@testable import Combinefall

final class URLTests: XCTestCase {
    func testCardFormatVersonArtCropCodingKey() {
        XCTAssert(Endpoint.CardsSearchOptions.Format.Version(rawValue: "art_crop") == .artCrop)
    }
    
    func testCardFormatVersonBorderCropCodingKey() {
        XCTAssert(Endpoint.CardsSearchOptions.Format.Version(rawValue: "border_crop") == .borderCrop)
    }
    
    func testCardFormatVersionJsonQueryItems() {
        XCTAssert(Endpoint.CardsSearchOptions.Format.json.queryItems == [])
    }
    
    func testCardFormatVersionTextQueryItems() {
        XCTAssert(Endpoint.CardsSearchOptions.Format.text.queryItems == [URLQueryItem(name: "format", value: "text")])
    }
    
    func testCardFormatImageQueryItems() {
        for version in Endpoint.CardsSearchOptions.Format.Version.allCases {
            var expected = [URLQueryItem(name: "format", value: "image")]
            switch version {
            case .small: expected.append(URLQueryItem(name: "version", value: "small"))
            case .normal: expected.append(URLQueryItem(name: "version", value: "normal"))
            case .large: break
            case .png: expected.append(URLQueryItem(name: "version", value: "png"))
            case .artCrop: expected.append(URLQueryItem(name: "version", value: "art_crop"))
            case .borderCrop: expected.append(URLQueryItem(name: "version", value: "border_crop"))
            }
            
            for face in Endpoint.CardsSearchOptions.Format.Face.allCases {
                switch face {
                case .front: break
                case .back: expected.append(URLQueryItem(name: "face", value: "back"))
                }
                
                let actual = Endpoint.CardsSearchOptions.Format.image(version, face).queryItems
                
                XCTAssert(expected.count == actual.count)
                
                for element in expected {
                    XCTAssert(actual.contains(element), "\(expected) does not contain \(element)")
                }
            }
        }
    }
}
