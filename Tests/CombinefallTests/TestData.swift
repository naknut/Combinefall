import Foundation

enum TestData: String {
    case catalog = """
    {
        "total_values": 1,
        "data": ["Jace"]
    }
    """
    
    case invalid = """
    {
        "total_values": 1,
        "data": ["Jace"]
    """
    
    var data: Data { self.rawValue.data(using: .utf8)! }
}
