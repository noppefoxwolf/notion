//
//  File.swift
//  File
//
//  Created by Tomoya Hirano on 2021/07/17.
//

import Foundation

public struct DatabasePropertyFilter: Codable {
    /// The name or ID of the property to filter on.
    public let property: String
    public let condition: DatabasePropertyFilterCondition
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AnyCodingKey.self)
        try container.encode(property, forKey: .init(stringValue: "property")!)
        try container.encode(condition, forKey: .init(intValue: 0)!)
    }
}

public enum CompoundFilter: Codable {
    /// Returns pages when any of the filters inside the provided array match.
    case or([DatabasePropertyFilter])
    /// Returns pages when all of the filters inside the provided array match.
    case and([DatabasePropertyFilter])
}

public enum DatabasePropertyFilterCondition: Codable {
    case text(TextFilterCondition)
    case number(NumberFilterCondition)
    case checkbox(CheckboxFilterCondition)
    case select(SelectFilterCondition)
}

public extension DatabasePropertyFilterCondition {
    /// A text filter condition applies to database properties of types "title", "rich_text", "url", "email", and "phone".
    enum TextFilterCondition: Codable {
        /// Only return pages where the page property value matches the provided value exactly.
        case equals(String)
        /// Only return pages where the page property value does not match the provided value exactly.
        case doesNotEqual(String)
        /// Only return pages where the page property value contains the provided value.
        case contains(String)
        /// Only return pages where the page property value does not contain the provided value.
        case doesNotContain(String)
        /// Only return pages where the page property value starts with the provided value.
        case startsWith(String)
        /// Only return pages where the page property value ends with the provided value.
        case endsWith(String)
        /// Only return pages where the page property value is empty.
        case isEmpty(Bool = true)
        /// Only return pages where the page property value is present.
        case isNotEmpty(Bool = true)
    }
    
    /// A number filter condition applies to database properties of type "number".
    enum NumberFilterCondition: Codable {
        /// Only return pages where the page property value matches the provided value exactly.
        case equals(Int)
        /// Only return pages where the page property value does not match the provided value exactly.
        case does_not_equal(Int)
        /// Only return pages where the page property value is greater than the provided value.
        case greater_than(Int)
        /// Only return pages where the page property value is less than the provided value.
        case less_than(Int)
        /// Only return pages where the page property value is greater than or equal to the provided value.
        case greater_than_or_equal_to(Int)
        /// Only return pages where the page property value is less than or equal to the provided value.
        case less_than_or_equal_to(Int)
        /// Only return pages where the page property value is empty.
        case is_empty(Bool = true)
        /// Only return pages where the page property value is present.
        case is_not_empty(Bool = true)
    }
    
    /// Checkbox filter condition
    enum CheckboxFilterCondition: Codable {
        /// Only return pages where the page property value matches the provided value exactly.
        case equals(Bool)
        /// Only return pages where the page property value does not match the provided value exactly.
        case does_not_equal(Bool)
    }
    
    /// A select filter condition applies to database properties of type "select".
    enum SelectFilterCondition: Codable {
        /// Only return pages where the page property value matches the provided value exactly.    "This Week"
        case equals(String)
        /// Only return pages where the page property value does not match the provided value exactly.    "Backlog"
        case does_not_equal(String)
        /// Only return pages where the page property value is empty.    true
        case is_empty(Bool = true)
        /// Only return pages where the page property value is present.    true
        case is_not_empty(Bool = true)
    }
    
    /// A multi-select filter condition applies to database properties of type "multi_select".
    enum MultiSelectFilterCondition: Codable {
        /// Only return pages where the page property value contains the provided value.    "Marketing"
        case contains(String)
        /// Only return pages where the page property value does not contain the provided value.    "Engineering"
        case does_not_contain(String)
        /// Only return pages where the page property value is empty.    true
        case is_empty(Bool = true)
        /// Only return pages where the page property value is present.    true
        case is_not_empty(Bool = true)
    }
    
    /// A date filter condition applies to database properties of types "date", "created_time", and "last_edited_time".
    enum DateFilterCondition: Codable {
        /// Only return pages where the page property value matches the provided date exactly. Note that the comparison is done against the date. Any time information sent will be ignored.    "2021-05-10T02:43:42Z"
        case equals(String)
        /// Only return pages where the page property value is before the provided date. Note that the comparison is done against the date. Any time information sent will be ignored.    "2021-05-10T02:43:42Z"
        case before(String)
        /// Only return pages where the page property value is after the provided date. Note that the comparison is done against the date. Any time information sent will be ignored.    "2021-05-10T02:43:42Z"
        case after(String)
        /// Only return pages where the page property value is on or before the provided date. Note that the comparison is done against the date. Any time information sent will be ignored.    "2021-05-10T02:43:42Z"
        case on_or_before(String)
        /// Only return pages where the page property value is empty.    true
        case is_empty(Bool = true)
        /// Only return pages where the page property value is present.    true
        case is_not_empty(Bool = true)
        /// Only return pages where the page property value is on or after the provided date. Note that the comparison is done against the date. Any time information sent will be ignored.    "2021-05-10T02:43:42Z"
        case on_or_after(String)
        /// Only return pages where the page property value is within the past week.    {}
        case past_week
        /// Only return pages where the page property value is within the past month.    {}
        case past_month
        /// Only return pages where the page property value is within the past year.    {}
        case past_year
        /// Only return pages where the page property value is within the next week.    {}
        case next_week
        /// Only return pages where the page property value is within the next month.    {}
        case next_month
        /// Only return pages where the page property value is within the next year.    {}
        case next_year
    }
    
    /// A people filter condition applies to database properties of types "people", "created_by", and "last_edited_by".
    enum PeopleFilterCondition: Codable {
        /// Only return pages where the page property value contains the provided value.    "6c574cee-ca68-41c8-86e0-1b9e992689fb"
        case contains(String)
        /// Only return pages where the page property value does not contain the provided value.    "6c574cee-ca68-41c8-86e0-1b9e992689fb"
        case does_not_contain(String)
        /// Only return pages where the page property value is empty.    true
        case is_empty(Bool = true)
        /// Only return pages where the page property value is present.    true
        case is_not_empty(Bool = true)
    }
    
    /// A people filter condition applies to database properties of type "files".
    enum FilesFilterCondition: Codable {
        /// Only return pages where the page property value is empty.    true
        case is_empty(Bool = true)
        /// Only return pages where the page property value is present.    true
        case is_not_empty(Bool = true)
    }
    
    /// A relation filter condition applies to database properties of type "relation".
    enum RelationFilterCondition: Codable {
        /// Only return pages where the page property value contains the provided value.    "6c574cee-ca68-41c8-86e0-1b9e992689fb"
        case contains(String)
        /// Only return pages where the page property value does not contain the provided value.    "6c574cee-ca68-41c8-86e0-1b9e992689fb"
        case does_not_contain(String)
        /// Only return pages where the page property value is empty.    true
        case is_empty(Bool = true)
        /// Only return pages where the page property value is present.    true
        case is_not_empty(Bool = true)
    }
    
    /// A formula filter condition applies to database properties of type "formula".
    enum FormulaFilterCondition: Codable {
        /// Only return pages where the result type of the page property formula is "text" and the provided text filter condition matches the formula's value.
        case text(TextFilterCondition)
        /// Only return pages where the result type of the page property formula is "checkbox" and the provided checkbox filter condition matches the formula's value.
        case checkbox(CheckboxFilterCondition)
        /// Only return pages where the result type of the page property formula is "number" and the provided number filter condition matches the formula's value.
        case number(NumberFilterCondition)
        /// Only return pages where the result type of the page property formula is "date" and the provided date filter condition matches the formula's value.
        case date(DateFilterCondition)
    }
}
