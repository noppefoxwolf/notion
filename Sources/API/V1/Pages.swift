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
        public var path: String { "/v1/pages" }
        public let parent: String
        public let properties: [String]
        public let children: [String]
        public let method: HTTPMethod = .post
        public typealias Response = Object.List<Object.User>
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
