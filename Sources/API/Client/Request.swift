//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

public protocol Request {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var httpBody: Data? { get }
    var headerFields: [String: String] { get }
    associatedtype Response: Decodable
}

public extension Request {
    var baseURL: URL { URL(string: "https://api.notion.com")! }
    
    var queryItems: [URLQueryItem] { [] }
    var httpBody: Data? { nil }
    
    var headerFields: [String: String] {
        [
            "Notion-Version" : "2021-05-13"
        ]
    }
}

extension Request {
    func makeURLRequest(authorizationToken: String? = nil) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryItems
        var request = URLRequest(url: urlComponents.url!)
        
        var headerFields = self.headerFields
        if let token = authorizationToken {
            headerFields["Authorization"] = "Bearer \(token)"
        }
        request.allHTTPHeaderFields = headerFields
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        return request
    }
}
