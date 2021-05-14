//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

public enum NotionError: Error {
    case api(APIError)
    case other(Error)
}
