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
    
    /// Append block children
    ///
    /// https://developers.notion.com/reference/patch-block-children
    public struct Append: Request {
        /// - Parameters:
        ///     - id:
        ///         Identifier for a block
        ///     - children:
        ///         Child content to append to a container block as an array of block objects
        public init(id: Block.ID, children: [Block]) {
            self.id = id
            struct Parameter: Encodable {
                let children: [Block]
            }
            let parameter = Parameter(children: children)
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(.iso8601Full)
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try! encoder.encode(parameter)
            httpBody = data
        }
        
        public var path: String { "/v1/blocks/\(id)/children" }
        public let id: String
        public let method: HTTPMethod = .patch
        public let httpBody: Data?
        public typealias Response = Object.Block
    }
}
