//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Object

extension V1.Pages {
    /// Retrieve a page
    /// - Parameters id: page_id
    public struct Page: Request {
        public init(id: String) {
            self.id = id
        }
        
        public var path: String { "/v1/pages/\(id)" }
        public let id: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.Page
    }
    
    public struct Create: Request {
        public init(parent: Parent, properties: [String : Property], children: [Block]) {
            struct Parameter: Encodable {
                let parent: Parent
                let properties: [String : Property]
                let children: [Block]
            }
            let parameter = Parameter(parent: parent, properties: properties, children: children)
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(.iso8601Full)
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try! encoder.encode(parameter)
            httpBody = data
        }
        
        public var path: String { "/v1/pages" }
        public let method: HTTPMethod = .post
        public let httpBody: Data?
        public typealias Response = Object.Page
    }
    
    public struct Update: Request {
        public var path: String { "/v1/pages" }
        public let parent: String
        public let properties: [String]
        public let children: [String]
        public let method: HTTPMethod = .patch
        public typealias Response = Object.List<Object.User>
    }
}
