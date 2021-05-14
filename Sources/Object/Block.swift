//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

public struct Block: Decodable, Identifiable {
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
            let value = try container.decode(TypeValue.Paragraph.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .paragraph(value)
        case .heading1:
            let value = try container.decode(TypeValue.Heading1.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .heading1(value)
        case .heading2:
            let value = try container.decode(TypeValue.Heading2.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .heading2(value)
        case .heading3:
            let value = try container.decode(TypeValue.Heading3.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .heading3(value)
        case .bulletedListItem:
            let value = try container.decode(TypeValue.BulletedListItem.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .bulletedListItem(value)
        case .numberedListItem:
            let value = try container.decode(TypeValue.NumberedListItem.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .numberedListItem(value)
        case .toDo:
            let value = try container.decode(TypeValue.ToDo.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .toDo(value)
        case .toggle:
            let value = try container.decode(TypeValue.Toggle.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .toggle(value)
        case .childPage:
            let value = try container.decode(TypeValue.ChildPage.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .childPage(value)
        case .unsupported:
            self.type = .unsupported(.init())
        }
    }
}

extension Block {
    public enum TypeValue {
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
    public struct Paragraph: Decodable {
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct Heading1: Decodable {
        public let text: [RichText]
    }
    public struct Heading2: Decodable {
        public let text: [RichText]
    }
    public struct Heading3: Decodable {
        public let text: [RichText]
    }
    public struct BulletedListItem: Decodable {
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct NumberedListItem: Decodable {
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct ToDo: Decodable {
        public let text: [RichText]
        public let checked: Bool
        public let children: [Block]?
    }
    public struct Toggle: Decodable {
        public let text: [RichText]
        public let children: [Block]?
    }
    public struct ChildPage: Decodable {
        public let title: String
    }
    public struct Unsupported: Decodable {
    }
}
