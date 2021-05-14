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
    
    public struct List: Request {
        public init() {}
        
        public var path: String { "/v1/databases" }
        public let method: HTTPMethod = .get
        public typealias Response = Object.List<Object.Database>
    }
    
    public struct Query: Request {
        public init(id: String) {
            self.id = id
        }
        
        public var path: String { "/v1/databases/\(id)/query" }
        public let id: String
        public let method: HTTPMethod = .post
        public var parameters: [String : Any] {
            [
                "filter" : "",
                "sorts" : "",
                "start_cursor" : "",
                "page_size" : ""
            ]
        }
        public typealias Response = Object.List<Object.Page>
    }
}

struct Filter {
    let property: String
    
}
