//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

extension KeyedDecodingContainer {
    func decode<T: Decodable>(forKey key: K) throws -> T {
        try decode(T.self, forKey: key)
    }
}
