import XCTest
@testable import Object

class FilterTests: XCTestCase {

    let decoder: JSONDecoder = JSONDecoder()
    let encoder: JSONEncoder = JSONEncoder()
    
    override func setUp() {
        super.setUp()
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.keyEncodingStrategy = .convertToSnakeCase
     }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let filter = DatabasePropertyFilter(property: "Landmark", condition: .text(.contains("Bridge")))
        let data = try! encoder.encode(filter)
        let json = String(data: data, encoding: .utf8)!
        XCTAssertEqual(json, "")
    }
}
