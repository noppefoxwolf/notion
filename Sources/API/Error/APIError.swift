//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

/// https://developers.notion.com/reference/errors
public struct APIError: Error, Decodable {
    let object: String
    let status: Int
    let code: Code
    let message: String
}

extension APIError {
    public enum Code: String, Decodable {
        case invalidJson = "invalid_json"
        case invalidRequestUrl = "invalid_request_url"
        case invalidRequest = "invalid_request"
        case validationError = "validation_error"
        case unauthorized = "unauthorized"
        case restrictedResource = "restricted_resource"
        case objectNotFound = "object_not_found"
        case conflictError = "conflict_error"
        case rateLimited = "rate_limited"
        case internalServerError = "internal_server_error"
        case serviceUnavailable = "service_unavailable"
    }
}


