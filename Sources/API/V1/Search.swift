//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Object

extension V1.Search {
    public struct Search: Request {
        
        // TODO: Support Filter, Sort,
        public init(query: String) {
            struct Parameter: Encodable {
                let query: String
            }
            let encoder = JSONEncoder()
            let data = try! encoder.encode(Parameter(query: query))
            httpBody = data
        }
        
        public var path: String { "/v1/search" }
        public let method: HTTPMethod = .post
        public let httpBody: Data?
        public typealias Response = Object.List<Object.SearchResult>
    }
}


