//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/15.
//

import Foundation

public struct SearchResult: Decodable {
    public let object: Value
}

extension SearchResult {
    enum CodingKey: String, Swift.CodingKey {
        case object
    }
    
    enum ObjectType: String, Decodable {
        case database = "database"
        case page = "page"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        let objectType = try container.decode(ObjectType.self, forKey: .init(.object))
        switch objectType {
        case .database:
            let container = try decoder.singleValueContainer()
            let value = try container.decode(Database.self)
            self.object = .database(value)
        case .page:
            let container = try decoder.singleValueContainer()
            let value = try container.decode(Page.self)
            self.object = .page(value)
        }
    }
}

extension SearchResult {
    public enum Value {
        case database(Database)
        case page(Page)
    }
}
