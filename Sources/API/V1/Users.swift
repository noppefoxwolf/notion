//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Object

extension V1.Users {
    /// Retrieve a user
    /// - Parameters
    ///     - id:
    ///         Identifier for a Notion user
    public struct Retrieve: Request {
        public init(id: String) {
            self.id = id
        }
        
        public var path: String { "/v1/users/\(id)" }
        public let id: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.User
    }
    
    /// List all users
    ///
    /// https://developers.notion.com/reference/get-users
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
        
        public var path: String { "/v1/users" }
        public let method: HTTPMethod = .get
        public let queryItems: [URLQueryItem]
        public typealias Response = Object.List<Object.User>
    }
}


