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
    ///
    /// Limits
    /// 
    /// Each page property is computed with a limit of 25 page references. Therefore relation property values feature a maximum of 25 relations, rollup property values are calculated based on a maximum of 25 relations, and rich text property values feature a maximum of 25 page mentions.
    ///
    /// ``https://developers.notion.com/reference/get-page``
    public struct Retrieve: Request {
        /// - Parameters:
        ///     - id: Identifier for a Notion page
        public init(id: String) {
            self.id = id
        }
        
        public var path: String { "/v1/pages/\(id)" }
        public let id: String
        public let method: HTTPMethod = .get
        public typealias Response = Object.Page
    }
    
    /// Create a page
    ///
    /// Creates a new page in the specified database or as a child of an existing page.
    /// If the parent is a database, the property values of the new page in the properties parameter must conform to the parent database's property schema.
    /// If the parent is a page, the only valid property is title.
    /// The new page may include page content, described as blocks in the children parameter.
    /// https://developers.notion.com/reference/post-page
    public struct Create: Request {
        public struct Parameter {
            public let parent: Parent
            public let properties: [String : Property.TypeValue]
            public let children: [Block]

            /// - Parameters:
            ///     - parent:
            ///         A database parent or page parent
            ///     - properties:
            ///         Property values of this page. The keys are the names or IDs of the property and the values are property values.
            ///     - children:
            ///         Page content for the new page as an array of block objects
            public init(parent: Parent, properties: [String : Property.TypeValue], children: [Block]) {
                self.parent = parent
                self.properties = properties
                self.children = children
            }
        }
        public init(parameter: Parameter) {
            httpBody = ParameterEncoder().encode(parameter)
        }
        
        public var path: String { "/v1/pages" }
        public let method: HTTPMethod = .post
        public let httpBody: Data?
        public typealias Response = Object.Page
    }
    
    /// Update page
    ///
    /// https://developers.notion.com/reference/patch-page
    public struct Update: Request {
        public struct Parameter: Encodable {
            let properties: [String : Property]
            let archived: Bool
            
            /// - Parameters:
            ///     - properties:
            ///         Property values to update for this page. The keys are the names or IDs of the property and the values are property values.
            ///     - archived:
            ///         Set to true to archive (delete) a page. Set to false to un-archive (restore) a page.
            public init(properties: [String : Property], archived: Bool) {
                self.properties = properties
                self.archived = archived
            }
        }
        
        /// - Parameters:
        ///     - id:
        ///         Identifier for a Notion page
        ///     - parameter:
        ///         Parameter for a request
        public init(id: Object.Page.ID, parameter: Parameter) {
            self.id = id
            httpBody = ParameterEncoder().encode(parameter)
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
            case .custom:
                break
            }
        }
    }
}
