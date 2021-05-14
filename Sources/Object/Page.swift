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
}
