import Foundation

enum TestData: String {    
    case cardListWithMore = #"""
       {
         "object": "list",
         "total_cards": 0,
         "has_more": true,
         "next_page": "https://api.scryfall.com/cards/search?format=json&include_extras=false&include_multilingual=false&order=set&page=2&q=e%3Aima&unique=prints",
         "data": []
       }
       """#
    
    var data: Data { self.rawValue.data(using: .utf8)! }
}
