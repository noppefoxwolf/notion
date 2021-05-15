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
    public struct Children: Request {
        public init(id: Block.ID) {
            self.id = id
        }
        
        public var path: String { "/v1/blocks/\(id)/children" }
        public let id: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.List<Object.Block>
    }
    
    public struct Append: Request {
        public var path: String { "/v1/blocks/\(id)/children" }
        public let id: String
        public let children: String
        public let method: HTTPMethod = .patch
        public typealias Response = Object.List<Object.User>
    }
}
