//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Object

extension V1.Blocks {
    /// Retrieve block children
    ///
    /// https://developers.notion.com/reference/get-block-children
    public struct Children: Request {
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
        
        /// - Parameters:
        ///     - id:
        ///         Identifier for a block
        ///     - parameter:
        ///         Parameter for request
        public init(id: Block.ID, parameter: Parameter) {
            self.id = id
            queryItems = [
                URLQueryItem(name: "start_cursor", value: parameter.startCursor),
                URLQueryItem(name: "page_size", value: "\(parameter.pageSize)")
            ]
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
