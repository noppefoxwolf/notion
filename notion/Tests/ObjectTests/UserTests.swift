

import XCTest
@testable import Object

class UserTests: XCTestCase {

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
              "object": "user",
              "id": "08b2fc12-81be-402c-ab7a-a1711f55235b",
              "name": "Tomoya Hirano",
              "avatar_url": "https://lh5.googleusercontent.com/-Vq9awmp2EtE/AAAAAAAAAAI/AAAAAAAAACc/tXzk67jnOtw/photo.jpg?sz=50",
              "type": "person",
              "person": {
                "email": "noppelabs@gmail.com"
              }
            },
            {
              "object": "user",
              "id": "0c0adb4b-03d7-4e3c-8bec-0889b04292ac",
              "name": "notion-swift",
              "avatar_url": null,
              "type": "bot",
              "bot": {}
            },
            {
              "object": "user",
              "id": "ece1c990-a544-4743-b03f-e026b1b5e249",
              "name": "noppe",
              "avatar_url": null,
              "type": "bot",
              "bot": {}
            }
          ],
          "next_cursor": null,
          "has_more": false
        }
        """
        let list = try! decoder.decode(List<User>.self, from: json.data(using: .utf8)!)
        
        XCTAssertEqual(list.results.count, 3)
        XCTAssertNil(list.nextCursor)
        XCTAssertFalse(list.hasMore)
        XCTAssertEqual(list.object, "list")
        XCTAssertEqual(list.results[0].object, "user")
        XCTAssertEqual(list.results[0].id, "08b2fc12-81be-402c-ab7a-a1711f55235b")
        XCTAssertEqual(list.results[0].name, "Tomoya Hirano")
        XCTAssertEqual(list.results[0].avatarUrl, "https://lh5.googleusercontent.com/-Vq9awmp2EtE/AAAAAAAAAAI/AAAAAAAAACc/tXzk67jnOtw/photo.jpg?sz=50")
        if case let .person(person) = list.results[0].type {
            XCTAssertEqual(person.email, "noppelabs@gmail.com")
        } else { XCTAssert(false) }
        
        XCTAssertEqual(list.results[1].object, "user")
        XCTAssertEqual(list.results[1].id, "0c0adb4b-03d7-4e3c-8bec-0889b04292ac")
        XCTAssertEqual(list.results[1].name, "notion-swift")
        XCTAssertNil(list.results[1].avatarUrl)
        if case .bot = list.results[1].type {
        } else { XCTAssert(false) }
        
        XCTAssertEqual(list.results[2].object, "user")
        XCTAssertEqual(list.results[2].id, "ece1c990-a544-4743-b03f-e026b1b5e249")
        XCTAssertEqual(list.results[2].name, "noppe")
        XCTAssertNil(list.results[2].avatarUrl)
        if case .bot = list.results[2].type {
        } else { XCTAssert(false) }
    }
}
