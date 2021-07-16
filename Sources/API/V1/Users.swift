//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
@_spi(API)
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
        public init(parameter: PaginationParameter = .default) {
            queryItems = parameter.queryItems
        }
        
        public var path: String { "/v1/users" }
        public let method: HTTPMethod = .get
        public let queryItems: [URLQueryItem]
        public typealias Response = Object.List<Object.User>
    }
}


