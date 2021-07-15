//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

struct TypedAnyCodingKey<Key: CodingKey>: CodingKey, Equatable where Key: RawRepresentable, Key.RawValue == String {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
    
    init(_ base: Key) {
        if let intValue = base.intValue {
            self.init(intValue: intValue)!
        } else {
            self.init(stringValue: base.stringValue)!
        }
    }
}

extension TypedAnyCodingKey: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(intValue)
        hasher.combine(stringValue)
    }
}


struct AnyCodingKey: CodingKey, Equatable {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
    
    init<Key>(_ base: Key) where Key : CodingKey {
        if let intValue = base.intValue {
            self.init(intValue: intValue)!
        } else {
            self.init(stringValue: base.stringValue)!
        }
    }
}

extension AnyCodingKey: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(intValue)
        hasher.combine(stringValue)
    }
}
