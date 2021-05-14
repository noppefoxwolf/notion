//
//  ExampleApp.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}
