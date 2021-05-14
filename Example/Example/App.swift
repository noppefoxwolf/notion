//
//  ExampleApp.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import SwiftUI
import API

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: .init()).environment(\.notion, {
                let session = Session.shared
                session.setAuthorization(token: "")
                return session
            }())
        }
    }
}
