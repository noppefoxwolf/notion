

import XCTest
@testable import Object

class BlockTests: XCTestCase {

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
          "object": "list",
          "results": [
            {
              "object": "block",
              "id": "059b012c-19ff-4958-b979-ce9037aef91a",
              "created_time": "2021-03-02T18:43:09.822Z",
              "last_edited_time": "2021-04-07T12:29:00.000Z",
              "has_children": true,
              "type": "child_page",
              "child_page": {
                "title": "About me"
              }
            },
            {
              "object": "block",
              "id": "a8adef5c-7ac1-46f7-b45f-a79c104a91f4",
              "created_time": "2021-03-16T16:18:00.000Z",
              "last_edited_time": "2021-03-16T16:19:00.000Z",
              "has_children": false,
              "type": "heading_1",
              "heading_1": {
                "text": [
                  {
                    "type": "text",
                    "text": {
                      "content": "Blog",
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
                    "plain_text": "Blog",
                    "href": null
                  }
                ]
              }
            },
            {
              "object": "block",
              "id": "a755f9fe-f6bd-40b2-95d4-5f5b93cf4cb0",
              "created_time": "2021-03-23T16:56:09.366Z",
              "last_edited_time": "2021-04-29T20:18:00.000Z",
              "has_children": false,
              "type": "unsupported",
              "unsupported": {}
            },
            {
              "object": "block",
              "id": "e5d519a9-9aeb-4787-9dbd-90afd25a6a4c",
              "created_time": "2021-03-16T16:19:10.764Z",
              "last_edited_time": "2021-05-09T15:54:00.000Z",
              "has_children": false,
              "type": "unsupported",
              "unsupported": {}
            },
            {
              "object": "block",
              "id": "93a48fe9-0a90-484c-9b9e-6d678c903440",
              "created_time": "2021-03-02T19:09:00.000Z",
              "last_edited_time": "2021-03-23T16:57:00.000Z",
              "has_children": false,
              "type": "heading_1",
              "heading_1": {
                "text": [
                  {
                    "type": "text",
                    "text": {
                      "content": "Works",
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
                    "plain_text": "Works",
                    "href": null
                  }
                ]
              }
            },
            {
              "object": "block",
              "id": "818251f5-3afe-4da2-a69d-6a85df10625b",
              "created_time": "2021-03-12T06:05:08.540Z",
              "last_edited_time": "2021-03-12T06:22:00.000Z",
              "has_children": false,
              "type": "unsupported",
              "unsupported": {}
            },
            {
              "object": "block",
              "id": "65d4d6e5-2d14-466a-9ce1-f60d3fbeba12",
              "created_time": "2021-03-12T06:08:00.958Z",
              "last_edited_time": "2021-04-16T17:59:00.000Z",
              "has_children": false,
              "type": "unsupported",
              "unsupported": {}
            },
            {
              "object": "block",
              "id": "8d764c1a-2d1a-4f44-8b3a-d23c2cc01f7d",
              "created_time": "2021-03-12T06:09:00.000Z",
              "last_edited_time": "2021-03-12T06:09:00.000Z",
              "has_children": false,
              "type": "paragraph",
              "paragraph": {
                "text": []
              }
            },
            {
              "object": "block",
              "id": "6f005650-686c-4676-ae1b-5df8a896ece1",
              "created_time": "2021-03-09T12:35:29.373Z",
              "last_edited_time": "2021-03-23T16:56:00.000Z",
              "has_children": true,
              "type": "toggle",
              "toggle": {
                "text": [
                  {
                    "type": "text",
                    "text": {
                      "content": "Hidden Contents",
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
                    "plain_text": "Hidden Contents",
                    "href": null
                  }
                ]
              }
            },
            {
              "object": "block",
              "id": "f40d3cdc-76df-48a2-9d1a-ef3e72ef890b",
              "created_time": "2021-03-09T12:37:00.000Z",
              "last_edited_time": "2021-03-09T12:38:00.000Z",
              "has_children": false,
              "type": "paragraph",
              "paragraph": {
                "text": [
                  {
                    "type": "text",
                    "text": {
                      "content": "2020-2021 noppe©︎ All rights reserved.",
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
                    "plain_text": "2020-2021 noppe©︎ All rights reserved.",
                    "href": null
                  }
                ]
              }
            },
            {
              "object": "block",
              "id": "40865008-d69e-4a1d-88d4-0c97fe1e9378",
              "created_time": "2021-03-12T06:09:00.000Z",
              "last_edited_time": "2021-03-12T06:10:00.000Z",
              "has_children": false,
              "type": "paragraph",
              "paragraph": {
                "text": []
              }
            }
          ],
          "next_cursor": null,
          "has_more": false
        }
        """
        let list = try! decoder.decode(List<Block>.self, from: json.data(using: .utf8)!)
        
        XCTAssertEqual(list.results.count, 11)
        XCTAssertNil(list.nextCursor)
        XCTAssertFalse(list.hasMore)
        
        XCTAssertEqual(list.results[0].object, "block")
        XCTAssertEqual(list.results[0].id, "059b012c-19ff-4958-b979-ce9037aef91a")
        XCTAssertTrue(list.results[0].hasChildren)
        if case let .childPage(page) = list.results[0].type {
            XCTAssertEqual(page.title, "About me")
        } else { XCTAssert(false) }
        
        XCTAssertFalse(list.results[1].hasChildren)
        if case let .heading1(heading) = list.results[1].type {
            XCTAssertEqual(heading.text[0].plainText, "Blog")
            XCTAssertEqual(heading.text[0].annotations.color, .default)
            XCTAssertNil(heading.text[0].href)
            if case let .text(text) = heading.text[0].type {
                XCTAssertEqual(text.content, "Blog")
            } else { XCTAssert(false) }
        } else { XCTAssert(false) }
        
        XCTAssertFalse(list.results[2].hasChildren)
        if case .unsupported = list.results[2].type {
        } else { XCTAssert(false) }
        
        XCTAssertFalse(list.results[3].hasChildren)
        if case .unsupported = list.results[3].type {
        } else { XCTAssert(false) }
        
        XCTAssertFalse(list.results[4].hasChildren)
        if case let .heading1(heading) = list.results[4].type {
            XCTAssertEqual(heading.text[0].plainText, "Works")
            XCTAssertEqual(heading.text[0].annotations.color, .default)
            XCTAssertNil(heading.text[0].href)
            if case let .text(text) = heading.text[0].type {
                XCTAssertEqual(text.content, "Works")
            } else { XCTAssert(false) }
        } else { XCTAssert(false) }
        
    }
}
