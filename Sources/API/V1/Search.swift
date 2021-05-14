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
        public var path: String { "/v1/search" }
        public let method: HTTPMethod = .post
        public typealias Response = Object.User
    }
}


