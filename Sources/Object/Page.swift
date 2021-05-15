//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

public struct Page: Decodable, Identifiable {
    public let object: String
    public let id: String
    public let createdTime: Date
    public let lastEditedTime: Date
    public let parent: Parent
    public let archived: Bool
    public let properties: [String : Property]
}

extension Page {
    // convenience
    public func retrieveTitle() -> String? {
        let title: String?? = properties.first(where: { $0.value.id == "title" }).map({ $0.value }).map { (property) in
            switch property.type {
            case let .title(title):
                return title.first?.plainText
            default:
                return nil
            }
        }
        return title.flatMap({ $0 ?? nil })
    }
}
