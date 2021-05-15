//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

public struct Block: Codable, Identifiable, Equatable {
    public init(type: Block.TypeValue) {
        self.object = "block"
        self.id = UUID().uuidString
        self.type = type
        self.createdTime = Date()
        self.lastEditedTime = Date()
        self.hasChildren = false
    }
    
    public let object: String
    public let id: String
    public let type: TypeValue
    public let createdTime: Date
    public let lastEditedTime: Date
    public let hasChildren: Bool
}

extension Block {
    enum CodingKey: String, Swift.CodingKey {
        case object
        case id
        case type
        case createdTime
        case lastEditedTime
        case hasChildren
    }
    
    enum InternalType: String, Decodable {
        case paragraph = "paragraph"
        case heading1 = "heading_1"
        case heading2 = "heading_2"
        case heading3 = "heading_3"
        case bulletedListItem = "bulleted_list_item"
        case numberedListItem = "numbered_list_item"
        case toDo = "to_do"
        case toggle = "toggle"
        case childPage = "child_page"
        case unsupported = "unsupported"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        object = try container.decode(forKey: .init(.object))
        id = try container.decode(forKey: .init(.id))
        createdTime = try container.decode(forKey: .init(.createdTime))
        lastEditedTime = try container.decode(forKey: .init(.lastEditedTime))
        hasChildren = try container.decode(forKey: .init(.hasChildren))
        let type: InternalType = try container.decode(forKey: .init(.type))
        switch type {
        case .paragraph:
            let value = try container.decode(TypeValue.Paragraph.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .paragraph(value)
        case .heading1:
            let value = try container.decode(TypeValue.Heading1.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .heading1(value)
        case .heading2:
            let value = try container.decode(TypeValue.Heading2.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .heading2(value)
        case .heading3:
            let value = try container.decode(TypeValue.Heading3.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .heading3(value)
        case .bulletedListItem:
            let value = try container.decode(TypeValue.BulletedListItem.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .bulletedListItem(value)
        case .numberedListItem:
            let value = try container.decode(TypeValue.NumberedListItem.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .numberedListItem(value)
        case .toDo:
            let value = try container.decode(TypeValue.ToDo.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .toDo(value)
        case .toggle:
            let value = try container.decode(TypeValue.Toggle.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .toggle(value)
        case .childPage:
            let value = try container.decode(TypeValue.ChildPage.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .childPage(value)
        case .unsupported:
            self.type = .unsupported(.init())
        }
    }
}

extension Block {
    public enum TypeValue: Equatable {
        case paragraph(Paragraph)
        case heading1(Heading1)
        case heading2(Heading2)
        case heading3(Heading3)
        case bulletedListItem(BulletedListItem)
        case numberedListItem(NumberedListItem)
        case toDo(ToDo)
        case toggle(Toggle)
        case childPage(ChildPage)
        case unsupported(Unsupported)
    }
}

extension Block.TypeValue {
    public struct Paragraph: Codable, Equatable {
        public init(text: [RichText], children: [Block]?) {
            self.text = text
            self.children = children
        }
        
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct Heading1: Codable, Equatable {
        public init(text: [RichText]) {
            self.text = text
        }
        
        public let text: [RichText]
    }
    public struct Heading2: Codable, Equatable {
        public init(text: [RichText]) {
            self.text = text
        }
        
        public let text: [RichText]
    }
    public struct Heading3: Codable, Equatable {
        public init(text: [RichText]) {
            self.text = text
        }
        
        public let text: [RichText]
    }
    public struct BulletedListItem: Codable, Equatable {
        public init(text: [RichText], children: [Block]?) {
            self.text = text
            self.children = children
        }
        
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct NumberedListItem: Codable, Equatable {
        public init(text: [RichText], children: [Block]?) {
            self.text = text
            self.children = children
        }
        
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct ToDo: Codable, Equatable {
        public init(text: [RichText], checked: Bool, children: [Block]?) {
            self.text = text
            self.checked = checked
            self.children = children
        }
        
        public let text: [RichText]
        public let checked: Bool
        public let children: [Block]?
    }
    public struct Toggle: Codable, Equatable {
        public init(text: [RichText], children: [Block]?) {
            self.text = text
            self.children = children
        }
        
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct ChildPage: Codable, Equatable {
        public init(title: String) {
            self.title = title
        }
        
        public let title: String
    }
    public struct Unsupported: Codable, Equatable {
        public init() {}
    }
}

extension Block {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        try container.encode(object, forKey: .init(.object))
        try container.encode(id, forKey: .init(.id))
        try container.encode(createdTime, forKey: .init(.createdTime))
        try container.encode(lastEditedTime, forKey: .init(.lastEditedTime))
        try container.encode(hasChildren, forKey: .init(.hasChildren))
        switch type {
        case let .paragraph(paragraph):
            try container.encode(InternalType.paragraph.rawValue, forKey: .init(.type))
            try container.encode(paragraph, forKey: .init(stringValue: InternalType.paragraph.rawValue)!)
        case let .heading1(heading1):
            try container.encode(InternalType.heading1.rawValue, forKey: .init(.type))
            try container.encode(heading1, forKey: .init(stringValue: InternalType.heading1.rawValue)!)
        case let .heading2(heading2):
            try container.encode(InternalType.heading2.rawValue, forKey: .init(.type))
            try container.encode(heading2, forKey: .init(stringValue: InternalType.heading2.rawValue)!)
        case let .heading3(heading3):
            try container.encode(InternalType.heading3.rawValue, forKey: .init(.type))
            try container.encode(heading3, forKey: .init(stringValue: InternalType.heading3.rawValue)!)
        case let .bulletedListItem(bulletedListItem):
            try container.encode(InternalType.bulletedListItem.rawValue, forKey: .init(.type))
            try container.encode(bulletedListItem, forKey: .init(stringValue: InternalType.bulletedListItem.rawValue)!)
        case let .numberedListItem(numberedListItem):
            try container.encode(InternalType.numberedListItem.rawValue, forKey: .init(.type))
            try container.encode(numberedListItem, forKey: .init(stringValue: InternalType.numberedListItem.rawValue)!)
        case let .toDo(toDo):
            try container.encode(InternalType.toDo.rawValue, forKey: .init(.type))
            try container.encode(toDo, forKey: .init(stringValue: InternalType.toDo.rawValue)!)
        case let .toggle(toggle):
            try container.encode(InternalType.toggle.rawValue, forKey: .init(.type))
            try container.encode(toggle, forKey: .init(stringValue: InternalType.toggle.rawValue)!)
        case let .childPage(childPage):
            try container.encode(InternalType.childPage.rawValue, forKey: .init(.type))
            try container.encode(childPage, forKey: .init(stringValue: InternalType.childPage.rawValue)!)
        case let .unsupported(unsupported):
            try container.encode(InternalType.unsupported.rawValue, forKey: .init(.type))
            try container.encode(unsupported, forKey: .init(stringValue: InternalType.unsupported.rawValue)!)
        }
    }
}
