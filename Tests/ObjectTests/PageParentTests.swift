

import XCTest
@testable import Object

class PageParentTests: XCTestCase {
    
    let decoder: JSONDecoder = JSONDecoder()
    let encoder: JSONEncoder = JSONEncoder()
    
    override func setUp() {
        super.setUp()
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
        encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let json = """
        {
            "type" : "database_id",
            "database_id" : "b8595b75-abd1-4cad-8dfe-f935a8ef57cb"
        }
        """
        let parent = try! decoder.decode(PageParent.self, from: json.data(using: .utf8)!)
        if case let .databaseId(id) = parent.type {
            XCTAssertEqual(id, "b8595b75-abd1-4cad-8dfe-f935a8ef57cb")
        } else { XCTAssert(false) }
        let data = try! encoder.encode(parent)
        let json2 = String(data: data, encoding: .utf8)
        let json3 = """
        {"type":"database_id","database_id":"b8595b75-abd1-4cad-8dfe-f935a8ef57cb"}
        """
        XCTAssertEqual(json2, json3)
    }
}
