//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Object

extension V1.Pages {
    /// Retrieve a page
    /// - Parameters id: page_id
    public struct Page: Request {
        public init(id: String) {
            self.id = id
        }
        
        public var path: String { "/v1/pages/\(id)" }
        public let id: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.Page
    }
    
    public struct Create: Request {
        public struct Parameter {
            public let parent: Parent
            public let properties: [String : Property.TypeValue]
            public let children: [Block]

            public init(parent: Parent, properties: [String : Property.TypeValue], children: [Block]) {
                self.parent = parent
                self.properties = properties
                self.children = children
            }
        }
        public init(parameter: Parameter) {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(.iso8601Full)
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try! encoder.encode(parameter)
            httpBody = data
        }
        
        public var path: String { "/v1/pages" }
        public let method: HTTPMethod = .post
        public let httpBody: Data?
        public typealias Response = Object.Page
    }
    
    public struct Update: Request {
        public init(id: Object.Page.ID, properties: [String : Property]) {
            self.id = id
            
            struct Parameter: Encodable {
                let properties: [String : Property]
            }
            let parameter = Parameter(properties: properties)
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(.iso8601Full)
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try! encoder.encode(parameter)
            httpBody = data
        }
        
        public var path: String { "/v1/pages/\(id)" }
        public let id: String
        public let httpBody: Data?
        public let method: HTTPMethod = .patch
        public typealias Response = Object.Page
    }
}

extension V1.Pages.Create.Parameter: Encodable {
    enum CodingKeys: String, CodingKey {
        case parent
        case properties
        case children
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(parent, forKey: .parent)
        try container.encode(children, forKey: .children)

        var propertiesContainer = container.nestedContainer(keyedBy: Property.PropertyType.self, forKey: .properties)
        try properties.forEach { key, value in
            switch value {
            case let .title(value):
                try propertiesContainer.encode(value, forKey: .title)
            case let .richText(value):
                try propertiesContainer.encode(value, forKey: .title)
            case let .number(value):
                try propertiesContainer.encode(value, forKey: .number)
            case let .select(value):
                try propertiesContainer.encode(value, forKey: .select)
            case let .multiSelect(value):
                try propertiesContainer.encode(value, forKey: .multiSelect)
            case let .date(value):
                try propertiesContainer.encode(value, forKey: .date)
            case let .people(value):
                try propertiesContainer.encode(value, forKey: .people)
            case let .file(value):
                try propertiesContainer.encode(value, forKey: .file)
            case let .checkbox(value):
                try propertiesContainer.encode(value, forKey: .checkbox)
            case let .url(value):
                try propertiesContainer.encode(value, forKey: .url)
            case let .email(value):
                try propertiesContainer.encode(value, forKey: .email)
            case let .phoneNumber(value):
                try propertiesContainer.encode(value, forKey: .phoneNumber)
            case let .formula(value):
                try propertiesContainer.encode(value, forKey: .formula)
            case let .relation(value):
                try propertiesContainer.encode(value, forKey: .relation)
            case let .rollup(value):
                try propertiesContainer.encode(value, forKey: .rollup)
            case let .createdTime(value):
                try propertiesContainer.encode(value, forKey: .createdTime)
            case let .createdBy(value):
                try propertiesContainer.encode(value, forKey: .createdBy)
            case let .lastEditedTime(value):
                try propertiesContainer.encode(value, forKey: .lastEditedTime)
            case let .lastEditedBy(value):
                try propertiesContainer.encode(value, forKey: .lastEditedBy)
            case let .custom:
                break
            }
        }
    }
}
