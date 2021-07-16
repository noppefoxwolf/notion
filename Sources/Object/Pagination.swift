//
//  File.swift
//  File
//
//  Created by Tomoya Hirano on 2021/07/17.
//

import Foundation

/// https://developers.notion.com/reference/pagination
public struct PaginationParameter {
    /// A cursor returned from a previous response, used to request the next page of results. Treat this as an opaque value.
    ///
    /// Default: undefined, which indicates to return results from the beginning of the list.
    public var startCursor: String
    
    /// The number of items from the full list desired in the response.
    ///
    /// Default: 100
    /// Maximum: 100
    ///
    /// The response may contain fewer than this number of results.
    public var pageSize: Int32
    
    /// - Parameters:
    ///     - startCursor:
    ///         If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results.
    ///     - pageSize:
    ///         The number of items from the full list desired in the response. Maximum: 100
    public init(startCursor: String = "undefined", pageSize: Int32 = 100) {
        self.startCursor = startCursor
        self.pageSize = pageSize
    }
    
    public static var `default`: Self { .init() }
    
    @_spi(API)
    public var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "start_cursor", value: startCursor),
            URLQueryItem(name: "page_size", value: "\(pageSize)")
        ]
    }
}

public struct List<T: Decodable>: Decodable {
    /// Always list.
    public let object: String
    
    /// The page, or partial list, or results.
    public let results: [T]
    
    /// Only available when has_more is true.
    ///
    /// Used to retrieve the next page of results by passing the value as the start_cursor parameter to the same endpoint.
    public let nextCursor: String?
    
    /// When the response includes the end of the list, false. Otherwise, true.
    public let hasMore: Bool
}
