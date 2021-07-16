//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Object

extension V1.Databases {
    /// Retrieve a user
    /// - Parameters:
    ///     - id: Identifier for a Notion database
    ///
    /// https://developers.notion.com/reference/get-database
    public struct Retrieve: Request {
        public init(id: Object.Database.ID) {
            self.id = id
        }
        
        public var path: String { "/v1/databases/\(id)" }
        public let id: Object.Database.ID
        public let method: HTTPMethod = .get
        public typealias Response = Object.Database
    }
    
    /// Query a database
    /// - Parameters:
    ///     - id: Identifier for a Notion database.
    ///
    /// Not implemented yet in this SDK.
    /// Welcome to submit your PR!
    /// https://developers.notion.com/reference/post-database-query
    public struct Query: Request {
        public init(id: Object.Database.ID) {
            self.id = id
        }
        public var path: String { "/v1/databases/\(id)/query" }
        public let id: Object.Database.ID
        public let method: HTTPMethod = .post
        public typealias Response = Object.List<Object.Page>
    }
    
    /// List databases
    ///
    /// List all Databases shared with the authenticated integration. The response may contain fewer than page_size of results.
    /// https://developers.notion.com/reference/get-databases
    public struct List: Request {
        
        /// - Parameters:
        ///     - startCursor:
        ///         If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results.
        ///     - pageSize:
        ///         The number of items from the full list desired in the response. Maximum: 100
        public struct Parameter: Encodable {
            let startCursor: String
            let pageSize: Int32
            
            public init(startCursor: String, pageSize: Int32) {
                self.startCursor = startCursor
                self.pageSize = pageSize
            }
        }
        public init(parameter: Parameter) {
            queryItems = [
                URLQueryItem(name: "start_cursor", value: parameter.startCursor),
                URLQueryItem(name: "page_size", value: "\(parameter.pageSize)")
            ]
        }
        public var path: String { "/v1/databases" }
        public var method: HTTPMethod = .get
        public let queryItems: [URLQueryItem]
        public typealias Response = Object.List<Object.Database>
    }
    
    /// Create a database
    ///
    /// Not implemented yet in this SDK.
    /// Welcome to submit your PR!
    /// Creates a database as a subpage in the specified parent page, with the specified properties schema.
    /// https://developers.notion.com/reference/create-a-database
    public struct Create: Request {
        
        /// - Parameters:
        ///     - parent:
        ///         A page parent
        ///     - title:
        ///         Title of database as it appears in Notion. An array of rich text objects.
        ///     - properties:
        ///         Property schema of database. The keys are the names of properties as they appear in Notion and the values are property schema objects.
        public init() {
            
        }
        public var path: String { "/v1/databases" }
        public var method: HTTPMethod = .post
        public typealias Response = Object.Database
    }
}

