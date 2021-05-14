

import XCTest
@testable import Object

class PageTests: XCTestCase {

    let decoder: JSONDecoder = JSONDecoder()
    
    override func setUp() {
        super.setUp()
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
     }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let json = """
        {
          "object": "page",
          "id": "25d1f23f-82f1-406b-b05b-9ed92b6998d0",
          "created_time": "2021-03-02T18:01:00.000Z",
          "last_edited_time": "2021-03-23T16:57:00.000Z",
          "parent": {
            "type": "workspace",
            "workspace": true
          },
          "archived": false,
          "properties": {
            "title": {
              "id": "title",
              "type": "title",
              "title": [
                {
                  "type": "text",
                  "text": {
                    "content": "noppe.dev",
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
                  "plain_text": "noppe.dev",
                  "href": null
                }
              ]
            }
          }
        }
        """
        let page = try! decoder.decode(Page.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(page.object, "page")
        XCTAssertEqual(page.id, "25d1f23f-82f1-406b-b05b-9ed92b6998d0")
        XCTAssertNotNil(page.createdTime)
    }
}
