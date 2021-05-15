//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/15.
//

import Foundation

public struct Parent: Codable {
    public init(type: Parent.TypeValue) {
        self.type = type
    }
    
    public let type: TypeValue
}

extension Parent {
    enum CodingKey: String, Swift.CodingKey {
        case type
    }
    
    enum InternalType: String, Decodable {
        case databaseId = "database_id"
        case pageId = "page_id"
        case workspace
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        let type = try container.decode(InternalType.self, forKey: .init(.type))
        switch type {
        case .databaseId:
            let value = try container.decode(String.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .databaseId(value)
        case .pageId:
            let value = try container.decode(String.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .pageId(value)
        case .workspace:
            self.type = .workspace
        }
    }
}

extension Parent {
    public enum TypeValue {
        case databaseId(String)
        case pageId(String)
        case workspace
    }
}

extension Parent {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        switch type {
        case let .databaseId(id):
            try container.encode(InternalType.databaseId.rawValue, forKey: .init(.type))
            try container.encode(id, forKey: .init(stringValue: InternalType.databaseId.rawValue)!)
        case let .pageId(id):
            try container.encode(InternalType.pageId.rawValue, forKey: .init(.type))
            try container.encode(id, forKey: .init(stringValue: InternalType.pageId.rawValue)!)
        case .workspace:
            try container.encode(InternalType.workspace.rawValue, forKey: .init(.type))
        }
    }
}
