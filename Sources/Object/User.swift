//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

public struct User: Decodable, Identifiable {
    public let object: String
    public let id: String
    public let type: TypeValue
    public let name: String?
    public let avatarUrl: String?
}

extension User {
    enum CodingKey: String, Swift.CodingKey {
        case object
        case id
        case type
        case name
        case avatarUrl
    }
    
    enum InternalType: String, Decodable {
        case person
        case bot
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        object = try container.decode(forKey: .init(.object))
        id = try container.decode(forKey: .init(.id))
        name = try container.decode(forKey: .init(.name))
        avatarUrl = try container.decode(forKey: .init(.avatarUrl))
        let type = try container.decode(InternalType.self, forKey: .init(.type))
        switch type {
        case .person:
            let value = try container.decode(TypeValue.Person.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .person(value)
        case .bot:
            let value = try container.decode(TypeValue.Bot.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .bot(value)
        }
    }
}

public extension User {
    enum TypeValue {
        case person(Person)
        case bot(Bot)
    }
}

public extension User.TypeValue {
    struct Person: Decodable {
        public let email: String
    }
    struct Bot: Decodable {
    }
}
