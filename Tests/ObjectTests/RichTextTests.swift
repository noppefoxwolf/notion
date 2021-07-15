

import XCTest
@testable import Object

class RichTextTests: XCTestCase {
    
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
                    "type": "text",
                    "text": {
                      "content": "hogw",
                      "link": null
                    },
                    "annotations": {
                      "bold": false,
                      "italic": false,
                      "strikethrough": false,
                      "underline": false,
                      "code": false,
                      "color": "default"
                    },
                    "plain_text": "hogw",
                    "href": null
                  }
        """
        let text = try! decoder.decode(RichText.self, from: json.data(using: .utf8)!)
        XCTAssertFalse(text.annotations.bold)
        if case let .text(text) = text.type {
            XCTAssertEqual(text.content, "hogw")
        } else { XCTAssert(false) }
        let data = try! encoder.encode(text)
        print("\(String(data: data, encoding: .utf8)!)")
        let text2 = try! decoder.decode(RichText.self, from: data)
        XCTAssertFalse(text2.annotations.bold)
        if case let .text(text) = text2.type {
            XCTAssertEqual(text.content, "hogw")
        } else { XCTAssert(false) }
//        let data = try! encoder.encode(text)
//        let json2 = String(data: data, encoding: .utf8)
//        let json3 = """
//        {"type":"database_id","database_id":"b8595b75-abd1-4cad-8dfe-f935a8ef57cb"}
//        """
//        XCTAssertEqual(json2, json3)
    }
}
