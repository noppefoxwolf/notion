//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import Foundation

public struct RichText: Codable, Equatable {
    public init(annotations: RichText.Annotation = .init(), type: RichText.TypeValue) {
        self.plainText = ""
        self.href = nil
        self.annotations = annotations
        self.type = type
    }
    
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
            let value = try container.decode(TypeValue.Text.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .text(value)
        case .mention:
            let value = try container.decode(TypeValue.Mention.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .mention(value)
        case .equation:
            let value = try container.decode(TypeValue.Equation.self, forKey: .init(stringValue: type.rawValue.camelized())!)
            self.type = .equation(value)
        }
    }
}

extension RichText {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
        try container.encode(plainText, forKey: .init(.plainText))
        try container.encode(href, forKey: .init(.href))
        try container.encode(annotations, forKey: .init(.annotations))
        switch type {
        case let .text(text):
            try container.encode(InternalType.text.rawValue, forKey: .init(.type))
            try container.encode(text, forKey: .init(stringValue: InternalType.text.rawValue)!)
        case let .mention(mention):
            try container.encode(InternalType.mention.rawValue, forKey: .init(.type))
            try container.encode(mention, forKey: .init(stringValue: InternalType.mention.rawValue)!)
        case let .equation(equation):
            try container.encode(InternalType.equation.rawValue, forKey: .init(.type))
            try container.encode(equation, forKey: .init(stringValue: InternalType.equation.rawValue)!)
        }
    }
}

public extension RichText {
    enum TypeValue: Equatable {
        case text(Text)
        case mention(Mention)
        case equation(Equation)
    }
}

public extension RichText.TypeValue {
    struct Text: Codable, Equatable {
        public init(content: String, link: RichText.TypeValue.Text.Link? = nil) {
            self.content = content
            self.link = link
        }
        
        public let content: String
        public let link: Link?
        
        public struct Link: Codable, Equatable {
            internal init(url: String) {
                self.url = url
            }
            
            let url: String
        }
    }
    
    struct Mention: Codable, Equatable {
//        let type: T
//
//        // TODO
//        enum T: String, Codable {
//            case user
//            case page
//            case database
//            case date
//        }
    }
    struct Equation: Codable, Equatable {
        let expression: String
    }
}

extension RichText {
    public struct Annotation: Codable, Equatable {
        public init(bold: Bool = false, italic: Bool = false, strikethrough: Bool = false, underline: Bool = false, code: Bool = false, color: RichText.Annotation.Color = .default) {
            self.bold = bold
            self.italic = italic
            self.strikethrough = strikethrough
            self.underline = underline
            self.code = code
            self.color = color
        }
        
        public let bold: Bool
        public let italic: Bool
        public let strikethrough: Bool
        public let underline: Bool
        public let code: Bool
        public let color: Color
        
        public enum Color: String, Codable, Equatable {
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
        
        enum CodingKey: String, Swift.CodingKey {
            case bold
            case italic
            case strikethrough
            case underline
            case code
            case color
        }
        
        public init(from decoder: Decoder) throws {
            // workaround: 2021-05-13ではキーが含まれていると強制的にtrueになるのでencode時に外す
            let container = try decoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
            bold = (try? container.decode(Bool.self, forKey: .init(.bold))) ?? false
            italic = (try? container.decode(Bool.self, forKey: .init(.italic))) ?? false
            strikethrough = (try? container.decode(Bool.self, forKey: .init(.strikethrough))) ?? false
            underline = (try? container.decode(Bool.self, forKey: .init(.underline))) ?? false
            code = (try? container.decode(Bool.self, forKey: .init(.code))) ?? false
            color = try container.decode(Color.self, forKey: .init(.color))
        }
        
        public func encode(to encoder: Encoder) throws {
            // workaround: 2021-05-13ではキーが含まれていると強制的にtrueになるのでencode時に外す
            var container = encoder.container(keyedBy: TypedAnyCodingKey<CodingKey>.self)
            if bold {
                try container.encode(bold, forKey: .init(.bold))
            }
            if italic {
                try container.encode(italic, forKey: .init(.italic))
            }
            if strikethrough {
                try container.encode(strikethrough, forKey: .init(.strikethrough))
            }
            if underline {
                try container.encode(underline, forKey: .init(.underline))
            }
            if code {
                try container.encode(code, forKey: .init(.code))
            }
            try container.encode(color, forKey: .init(.color))
        }
    }
}
