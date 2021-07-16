//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

/// Type representing HTTP methods.
///
/// See https://tools.ietf.org/html/rfc7231#section-4.3
public enum HTTPMethod: String {
    /// `GET` method.
    case get = "GET"
    /// `POST` method.
    case post = "POST"
    /// `PATCH` method.
    case patch = "PATCH"
}
