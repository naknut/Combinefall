//
//  URL.swift
//  
//
//  Created by Marcus Isaksson on 6/10/21.
//

import Foundation

public enum Endpoint {
    public enum CardsSearchOptions {
        public enum SearchParameter {
            case exact(String), fuzzy(String)
            
            var queryItem: URLQueryItem {
                switch self {
                case let .exact(name): return URLQueryItem(name: "exact", value: name)
                case let .fuzzy(name): return URLQueryItem(name: "fuzzy", value: name)
                }
            }
        }
        
        public enum Format {
            public enum Version: String, CaseIterable {
                case small, normal, large, png, artCrop = "art_crop", borderCrop = "border_crop"
            }
            
            public enum Face: CaseIterable {
                case front, back
            }
            
            case json, text, image(Version = .large, Face = .front)
            
            var queryItems: [URLQueryItem] {
                switch self {
                case .json: return []
                case .text: return [URLQueryItem(name: "format", value: "text")]
                case let .image(version, face):
                    var queryItems = [URLQueryItem(name: "format", value: "image")]
                    if version != .large {
                        queryItems.append(URLQueryItem(name: "version", value: version.rawValue))
                    }
                    if face == .back {
                        queryItems.append(URLQueryItem(name: "face", value: "back"))
                    }
                    return queryItems
                }
            }
        }
        
        case autocomplete(String),
             named(SearchParameter, Format = .json),
             id(UUID)
        
        var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.path = "/cards"
            switch self {
            case let .autocomplete(query): urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
            case let .named(searchParameter, format):
                var queryItems = [searchParameter.queryItem]
                queryItems.append(contentsOf: format.queryItems)
                urlComponents.queryItems = queryItems
            case let .id(id): urlComponents.path += "/\(id.uuidString)"
            }
            return urlComponents
        }
    }
    
    case cards(CardsSearchOptions)
    
    var url: URL {
        var urlComponents: URLComponents
        switch self {
        case let .cards(searchOptions): urlComponents = searchOptions.urlComponents
        }
        return urlComponents.url(relativeTo: URL(string: "https://api.scryfall.com"))!
    }
}
