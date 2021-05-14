//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

struct Block: Decodable {
    let object: String
    let id: String
    let type: TypeValue
    let createdTime: Date
    let lastEditedTime: Date
    let hasChildren: Bool
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
    
    init(from decoder: Decoder) throws {
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
    enum TypeValue {
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
    struct Paragraph: Decodable {
        let text: [RichText]
        let children: [Block]?
    }
    struct Heading1: Decodable {
        let text: [RichText]
    }
    struct Heading2: Decodable {
        let text: [RichText]
    }
    struct Heading3: Decodable {
        let text: [RichText]
    }
    struct BulletedListItem: Decodable {
        let text: [RichText]
        let children: [Block]?
    }
    struct NumberedListItem: Decodable {
        let text: [RichText]
        let children: [Block]?
    }
    struct ToDo: Decodable {
        let text: [RichText]
        let checked: Bool
        let children: [Block]?
    }
    struct Toggle: Decodable {
        let text: [RichText]
        let children: [Block]?
    }
    struct ChildPage: Decodable {
        let title: String
    }
    struct Unsupported: Decodable {
    }
}
