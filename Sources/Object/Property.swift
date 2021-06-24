//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

public struct Property: Codable {
    public init(type: Property.TypeValue) {
        self.id = UUID().uuidString
        self.type = type
    }
    
    public let id: String
    public let type: TypeValue
}

extension Property {
    enum CodingKey: String, Swift.CodingKey {
        case id
        case type
    }
    
    public enum PropertyType: String, Swift.CodingKey, Decodable {
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
        let subContainer = try decoder.container(keyedBy: TypedAnyCodingKey<PropertyType>.self)
        id = try container.decode(forKey: .init(.id))
        let type = try? container.decode(PropertyType.self, forKey: .init(.type))
        switch type {
        case .title:
            // workaround: キーのみが存在して中身がないケースがある
            // ex: title: {} or title: [{a},{b},{c}]
            do {
                let value = try container.decode(TypeValue.Title.self, forKey: .init(stringValue: PropertyType.title.rawValue.camelized())!)
                self.type = .title(value)
            } catch DecodingError.typeMismatch {
                self.type = .title([])
            } catch {
                throw error
            }
        case .richText:
            let value = try subContainer.decode(TypeValue.RichText.self, forKey: .init(stringValue: PropertyType.richText.rawValue.camelized())!)
            self.type = .richText(value)
        case .number:
            let value = try container.decode(TypeValue.Number.self, forKey: .init(stringValue: PropertyType.number.rawValue.camelized())!)
            self.type = .number(value)
        case .select:
            let value = try container.decode(TypeValue.Select.self, forKey: .init(stringValue: PropertyType.select.rawValue.camelized())!)
            self.type = .select(value)
        case .multiSelect:
            let value = try container.decode(TypeValue.MultiSelect.self, forKey: .init(stringValue: PropertyType.multiSelect.rawValue.camelized())!)
            self.type = .multiSelect(value)
        case .date:
            let value = try container.decode(TypeValue.Date.self, forKey: .init(stringValue: PropertyType.date.rawValue.camelized())!)
            self.type = .date(value)
        case .people:
            let value = try container.decode(TypeValue.People.self, forKey: .init(stringValue: PropertyType.people.rawValue.camelized())!)
            self.type = .people(value)
        case .file:
            let value = try container.decode(TypeValue.File.self, forKey: .init(stringValue: PropertyType.file.rawValue.camelized())!)
            self.type = .file(value)
        case .checkbox:
            let value = try container.decode(TypeValue.Checkbox.self, forKey: .init(stringValue: PropertyType.checkbox.rawValue.camelized())!)
            self.type = .checkbox(value)
        case .url:
            let value = try container.decode(TypeValue.Url.self, forKey: .init(stringValue: PropertyType.url.rawValue.camelized())!)
            self.type = .url(value)
        case .email:
            let value = try container.decode(TypeValue.Email.self, forKey: .init(stringValue: PropertyType.email.rawValue.camelized())!)
            self.type = .email(value)
        case .phoneNumber:
            let value = try container.decode(TypeValue.PhoneNumber.self, forKey: .init(stringValue: PropertyType.phoneNumber.rawValue.camelized())!)
            self.type = .phoneNumber(value)
        case .formula:
            let value = try container.decode(TypeValue.Formula.self, forKey: .init(stringValue: PropertyType.formula.rawValue.camelized())!)
            self.type = .formula(value)
        case .relation:
            let value = try container.decode(TypeValue.Relation.self, forKey: .init(stringValue: PropertyType.relation.rawValue.camelized())!)
            self.type = .relation(value)
        case .rollup:
            let value = try container.decode(TypeValue.Rollup.self, forKey: .init(stringValue: PropertyType.rollup.rawValue.camelized())!)
            self.type = .rollup(value)
        case .createdTime:
            let value = try container.decode(TypeValue.CreatedTime.self, forKey: .init(stringValue: PropertyType.createdTime.rawValue.camelized())!)
            self.type = .createdTime(value)
        case .createdBy:
            let value = try container.decode(TypeValue.CreatedBy.self, forKey: .init(stringValue: PropertyType.createdBy.rawValue.camelized())!)
            self.type = .createdBy(value)
        case .lastEditedTime:
            let value = try container.decode(TypeValue.LastEditedTime.self, forKey: .init(stringValue: PropertyType.lastEditedTime.rawValue.camelized())!)
            self.type = .lastEditedTime(value)
        case .lastEditedBy:
            let value = try container.decode(TypeValue.LastEditedBy.self, forKey: .init(stringValue: PropertyType.lastEditedBy.rawValue.camelized())!)
            self.type = .lastEditedBy(value)
        default:
            self.type = .custom
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
        
        case custom
    }
}

extension Property.TypeValue {
    public typealias Title = [Object.RichText]
    public struct RichText: Codable {}
    public struct Number: Codable {}
    public struct Select: Codable {}
    public struct MultiSelect: Codable {}
    public struct Date: Codable {}
    public struct People: Codable {}
    public struct File: Codable {}
    public struct Checkbox: Codable {}
    public struct Url: Codable {}
    public struct Email: Codable {}
    public struct PhoneNumber: Codable {}
    public struct Formula: Codable {}
    public struct Relation: Codable {}
    public struct Rollup: Codable {}
    public struct CreatedTime: Codable {}
    public struct CreatedBy: Codable {}
    public struct LastEditedTime: Codable {}
    public struct LastEditedBy: Codable {}
}

extension Property {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        try container.encode(id, forKey: .init(.id))
        switch type {
        case let .title(title):
            try container.encode(PropertyType.title.rawValue, forKey: .init(.type))
            try container.encode(title, forKey: .init(stringValue: PropertyType.title.rawValue)!)
        case let .richText(richText):
            try container.encode(PropertyType.richText.rawValue, forKey: .init(.type))
            try container.encode(richText, forKey: .init(stringValue: PropertyType.richText.rawValue)!)
        case let .number(number):
            try container.encode(PropertyType.number.rawValue, forKey: .init(.type))
            try container.encode(number, forKey: .init(stringValue: PropertyType.number.rawValue)!)
        case let .select(select):
            try container.encode(PropertyType.select.rawValue, forKey: .init(.type))
            try container.encode(select, forKey: .init(stringValue: PropertyType.select.rawValue)!)
        case let .multiSelect(multiSelect):
            try container.encode(PropertyType.multiSelect.rawValue, forKey: .init(.type))
            try container.encode(multiSelect, forKey: .init(stringValue: PropertyType.multiSelect.rawValue)!)
        case let .date(date):
            try container.encode(PropertyType.date.rawValue, forKey: .init(.type))
            try container.encode(date, forKey: .init(stringValue: PropertyType.date.rawValue)!)
        case let .people(people):
            try container.encode(PropertyType.people.rawValue, forKey: .init(.type))
            try container.encode(people, forKey: .init(stringValue: PropertyType.people.rawValue)!)
        case let .file(file):
            try container.encode(PropertyType.file.rawValue, forKey: .init(.type))
            try container.encode(file, forKey: .init(stringValue: PropertyType.file.rawValue)!)
        case let .checkbox(checkbox):
            try container.encode(PropertyType.checkbox.rawValue, forKey: .init(.type))
            try container.encode(checkbox, forKey: .init(stringValue: PropertyType.checkbox.rawValue)!)
        case let .url(url):
            try container.encode(PropertyType.url.rawValue, forKey: .init(.type))
            try container.encode(url, forKey: .init(stringValue: PropertyType.url.rawValue)!)
        case let .email(email):
            try container.encode(PropertyType.email.rawValue, forKey: .init(.type))
            try container.encode(email, forKey: .init(stringValue: PropertyType.email.rawValue)!)
        case let .phoneNumber(phoneNumber):
            try container.encode(PropertyType.phoneNumber.rawValue, forKey: .init(.type))
            try container.encode(phoneNumber, forKey: .init(stringValue: PropertyType.phoneNumber.rawValue)!)
        case let .formula(formula):
            try container.encode(PropertyType.formula.rawValue, forKey: .init(.type))
            try container.encode(formula, forKey: .init(stringValue: PropertyType.formula.rawValue)!)
        case let .relation(relation):
            try container.encode(PropertyType.relation.rawValue, forKey: .init(.type))
            try container.encode(relation, forKey: .init(stringValue: PropertyType.relation.rawValue)!)
        case let .rollup(rollup):
            try container.encode(PropertyType.rollup.rawValue, forKey: .init(.type))
            try container.encode(rollup, forKey: .init(stringValue: PropertyType.rollup.rawValue)!)
        case let .createdTime(createdTime):
            try container.encode(PropertyType.createdTime.rawValue, forKey: .init(.type))
            try container.encode(createdTime, forKey: .init(stringValue: PropertyType.createdTime.rawValue)!)
        case let .createdBy(createdBy):
            try container.encode(PropertyType.createdBy.rawValue, forKey: .init(.type))
            try container.encode(createdBy, forKey: .init(stringValue: PropertyType.createdBy.rawValue)!)
        case let .lastEditedTime(lastEditedTime):
            try container.encode(PropertyType.lastEditedTime.rawValue, forKey: .init(.type))
            try container.encode(lastEditedTime, forKey: .init(stringValue: PropertyType.lastEditedTime.rawValue)!)
        case let .lastEditedBy(lastEditedBy):
            try container.encode(PropertyType.lastEditedBy.rawValue, forKey: .init(.type))
            try container.encode(lastEditedBy, forKey: .init(stringValue: PropertyType.lastEditedBy.rawValue)!)
        case .custom:
            break
        }
    }
}
