//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

public struct Property: Decodable {
    public let id: String
    public let type: TypeValue
}

extension Property {
    enum CodingKey: String, Swift.CodingKey {
        case id
        case type
    }
    
    enum InternalType: String, Decodable {
        case title = "title"
        case richText = "rich_text"
        case number = "number"
        case select = "select"
        case multiSelect = "multi_select"
        case date = "date"
        case people = "people"
        case file = "file"
        case checkbox = "checkbox"
        case url = "url"
        case email = "email"
        case phoneNumber = "phone_number"
        case formula = "formula"
        case relation = "relation"
        case rollup = "rollup"
        case createdTime = "created_time"
        case createdBy = "created_by"
        case lastEditedTime = "last_edited_time"
        case lastEditedBy = "last_edited_by"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        id = try container.decode(forKey: .init(.id))
        let type = try container.decode(InternalType.self, forKey: .init(.type))
        switch type {
        case .title:
            let value = try container.decode(TypeValue.Title.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .title(value)
        case .richText:
            let value = try container.decode(TypeValue.RichText.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .richText(value)
        case .number:
            let value = try container.decode(TypeValue.Number.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .number(value)
        case .select:
            let value = try container.decode(TypeValue.Select.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .select(value)
        case .multiSelect:
            let value = try container.decode(TypeValue.MultiSelect.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .multiSelect(value)
        case .date:
            let value = try container.decode(TypeValue.Date.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .date(value)
        case .people:
            let value = try container.decode(TypeValue.People.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .people(value)
        case .file:
            let value = try container.decode(TypeValue.File.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .file(value)
        case .checkbox:
            let value = try container.decode(TypeValue.Checkbox.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .checkbox(value)
        case .url:
            let value = try container.decode(TypeValue.Url.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .url(value)
        case .email:
            let value = try container.decode(TypeValue.Email.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .email(value)
        case .phoneNumber:
            let value = try container.decode(TypeValue.PhoneNumber.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .phoneNumber(value)
        case .formula:
            let value = try container.decode(TypeValue.Formula.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .formula(value)
        case .relation:
            let value = try container.decode(TypeValue.Relation.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .relation(value)
        case .rollup:
            let value = try container.decode(TypeValue.Rollup.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .rollup(value)
        case .createdTime:
            let value = try container.decode(TypeValue.CreatedTime.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .createdTime(value)
        case .createdBy:
            let value = try container.decode(TypeValue.CreatedBy.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .createdBy(value)
        case .lastEditedTime:
            let value = try container.decode(TypeValue.LastEditedTime.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .lastEditedTime(value)
        case .lastEditedBy:
            let value = try container.decode(TypeValue.LastEditedBy.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .lastEditedBy(value)
        }
    }
}

public extension Property {
    enum TypeValue {
        case title(Title)
        case richText(RichText)
        case number(Number)
        case select(Select)
        case multiSelect(MultiSelect)
        case date(Date)
        case people(People)
        case file(File)
        case checkbox(Checkbox)
        case url(Url)
        case email(Email)
        case phoneNumber(PhoneNumber)
        case formula(Formula)
        case relation(Relation)
        case rollup(Rollup)
        case createdTime(CreatedTime)
        case createdBy(CreatedBy)
        case lastEditedTime(LastEditedTime)
        case lastEditedBy(LastEditedBy)
    }
}

public extension Property.TypeValue {
    struct Title: Decodable {}
    struct RichText: Decodable {}
    struct Number: Decodable {}
    struct Select: Decodable {}
    struct MultiSelect: Decodable {}
    struct Date: Decodable {}
    struct People: Decodable {}
    struct File: Decodable {}
    struct Checkbox: Decodable {}
    struct Url: Decodable {}
    struct Email: Decodable {}
    struct PhoneNumber: Decodable {}
    struct Formula: Decodable {}
    struct Relation: Decodable {}
    struct Rollup: Decodable {}
    struct CreatedTime: Decodable {}
    struct CreatedBy: Decodable {}
    struct LastEditedTime: Decodable {}
    struct LastEditedBy: Decodable {}
}

