//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

public struct RichText: Decodable {
    public let plainText: String
    public let href: String?
    public let annotations: Annotation
    public let type: TypeValue
}

extension RichText {
    enum CodingKey: String, Swift.CodingKey {
        case plainText
        case href
        case annotations
        case type
    }
    
    enum InternalType: String, Decodable {
        case text
        case mention
        case equation
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        plainText = try container.decode(forKey: .init(.plainText))
        href = try container.decode(forKey: .init(.href))
        annotations = try container.decode(forKey: .init(.annotations))
        let type = try container.decode(InternalType.self, forKey: .init(.type))
        switch type {
        case .text:
            let value = try container.decode(TypeValue.Text.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .text(value)
        case .mention:
            let value = try container.decode(TypeValue.Mention.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .mention(value)
        case .equation:
            let value = try container.decode(TypeValue.Equation.self, forKey: .init(stringValue: "\(type)")!)
            self.type = .equation(value)
        }
    }
}

public extension RichText {
    enum TypeValue {
        case text(Text)
        case mention(Mention)
        case equation(Equation)
        
    }
}

public extension RichText.TypeValue {
    struct Text: Decodable {
        let content: String
        let link: Link?
        
        struct Link: Decodable {
            let url: String
        }
    }
    struct Mention: Decodable {
        let type: T
        
        // TODO
        enum T: String, Decodable {
            case user
            case page
            case database
            case date
        }
    }
    struct Equation: Decodable {
        let expression: String
    }
}

extension RichText {
    public struct Annotation: Decodable {
        public let bold: Bool
        public let italic: Bool
        public let strikethrough: Bool
        public let underline: Bool
        public let code: Bool
        public let color: Color
        
        public enum Color: String, Decodable {
            case `default` = "default"
            case gray = "gray"
            case brown = "brown"
            case orange = "orange"
            case yellow = "yellow"
            case green = "green"
            case blue = "blue"
            case purple = "purple"
            case pink = "pink"
            case red = "red"
            case grayBackground = "gray_background"
            case brownBackground = "brown_background"
            case orangeBackground = "orange_background"
            case yellowBackground = "yellow_background"
            case greenBackground = "green_background"
            case blueBackground = "blue_background"
            case purpleBackground = "purple_background"
            case pinkBackground = "pink_background"
            case redBackground = "red_background"
        }
    }
}
