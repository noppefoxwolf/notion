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
    /// - Parameters id: user_id
    public struct Database: Request {
        public init(id: String) {
            self.id = id
        }
        
        public var path: String { "/v1/databases/\(id)" }
        public let id: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.Database
    }
    
    public struct Query: Request {
        public init(id: Object.Database.ID) {
            self.id = id
        }
        public var path: String { "/v1/databases/\(id)/query" }
        public let id: String
        public let method: HTTPMethod = .post
        public typealias Response = Object.List<Object.Page>
    }
}

