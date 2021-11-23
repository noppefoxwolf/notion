//
//  Env.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/15.
//

import SwiftUI
import API

struct NotionEnvironmentKey: EnvironmentKey {
    static var defaultValue: Session = .shared
}
 
extension EnvironmentValues {
  var notion: Session {
    get {
      return self[NotionEnvironmentKey.self]
    }
    set {
      self[NotionEnvironmentKey.self] = newValue
    }
  }
}
