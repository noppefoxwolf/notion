//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

public struct List<T: Decodable>: Decodable {
    public let object: String
    public let results: [T]
    public let nextCursor: String?
    public let hasMore: Bool
}
