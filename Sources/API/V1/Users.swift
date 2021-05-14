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
    /// - Parameters id: user_id
    public struct User: Request {
        public init(id: String) {
            self.id = id
        }
        
        public var path: String { "/v1/users/\(id)" }
        public let id: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.User
    }
    
    public struct List: Request {
        public init() {}
        
        public var path: String { "/v1/users" }
        public let method: HTTPMethod = .get
        public typealias Response = Object.List<Object.User>
    }
}


