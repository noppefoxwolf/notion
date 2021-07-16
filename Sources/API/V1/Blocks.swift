//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
@_spi(API)
import Object

extension V1.Blocks {
    /// Retrieve block children
    ///
    /// https://developers.notion.com/reference/get-block-children
    public struct Children: Request {
        /// - Parameters:
        ///     - id:
        ///         Identifier for a block
        ///     - parameter:
        ///         Parameter for request
        public init(id: Block.ID, parameter: PaginationParameter = .default) {
            self.id = id
            queryItems = parameter.queryItems
        }
        
        public var path: String { "/v1/blocks/\(id)/children" }
        public let id: String
        public let method: HTTPMethod = .get
        public let queryItems: [URLQueryItem]
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
            httpBody = ParameterEncoder().encode(parameter)
        }
        
        public var path: String { "/v1/blocks/\(id)/children" }
        public let id: String
        public let method: HTTPMethod = .patch
        public let httpBody: Data?
        public typealias Response = Object.Block
    }
}
