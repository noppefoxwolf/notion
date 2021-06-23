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
        public struct Parameter: Encodable {
            let parent: Parent
            let properties: [String : Property.TypeValue]
            let children: [Block]
        }
        public init(parameter: Parameter) {
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
        public init(id: Object.Page.ID, properties: [String : Property]) {
            self.id = id
            
            struct Parameter: Encodable {
                let properties: [String : Property]
            }
            let parameter = Parameter(properties: properties)
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(.iso8601Full)
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try! encoder.encode(parameter)
            httpBody = data
        }
        
        public var path: String { "/v1/pages/\(id)" }
        public let id: String
        public let httpBody: Data?
        public let method: HTTPMethod = .patch
        public typealias Response = Object.Page
    }
}
