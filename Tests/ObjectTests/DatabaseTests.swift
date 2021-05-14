

import XCTest
@testable import Object

class DatabaseTests: XCTestCase {

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
            "has_more": false,
            "next_cursor": null,
            "object": "list",
            "results": [
                {
                  "object": "database",
                  "id": "e5d519a9-9aeb-4787-9dbd-90afd25a6a4c",
                  "created_time": "2021-03-16T16:19:10.764Z",
                  "last_edited_time": "2021-05-09T15:54:00.000Z",
                  "title": [
                    {
                      "type": "text",
                      "text": {
                        "content": "Articles",
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
                      "plain_text": "Articles",
                      "href": null
                    }
                  ],
                  "properties": {
                    "作成日": {
                      "id": "^co@",
                      "type": "created_time",
                      "created_time": {}
                    },
                    "タイトル": {
                      "id": "title",
                      "type": "title",
                      "title": {}
                    }
                  }
                }
            ]
        }
        """
        let databases = try! decoder.decode(List<Database>.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(databases.results.count, 1)
        XCTAssertNotNil(databases.results[0].properties["作成日"])
        XCTAssertNotNil(databases.results[0].properties["タイトル"])
    }
}
