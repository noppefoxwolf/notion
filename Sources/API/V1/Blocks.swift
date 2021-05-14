//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Object

extension V1.Blocks {
    /// Retrieve a user
    /// - Parameters id: block_id
    public struct User: Request {
        public var path: String { "/v1/blocks/\(id)/children" }
        public let id: String
        public let startCursor: String
        public let pageSize: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.List<Object.User>
    }
    
    public struct Append: Request {
        public var path: String { "/v1/blocks/\(id)/children" }
        public let id: String
        public let children: String
        public let method: HTTPMethod = .patch
        public typealias Response = Object.List<Object.User>
    }
}
