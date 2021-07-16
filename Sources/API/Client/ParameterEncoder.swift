//
//  File.swift
//  File
//
//  Created by Tomoya Hirano on 2021/07/17.
//

import Foundation

struct ParameterEncoder {
    func encode<T: Encodable>(_ parameter: T) -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try? encoder.encode(parameter)
    }
}
