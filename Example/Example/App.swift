//
//  ExampleApp.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import SwiftUI
import notion

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: .init()).environment(\.notion, {
                let session = Session.shared
                session.setAuthorization(token: "secret_LDF1jpWlRgbQv4gQEmH2bH6YhrlE7al84E0R4xkBDtr")
                return session
            }())
        }
    }
}
