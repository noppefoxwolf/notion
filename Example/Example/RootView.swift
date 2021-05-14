//
//  ContentView.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/13.
//

import SwiftUI
import notion
import API
import Object
import Combine

struct RootView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            SwiftUI.List {
                Section(header: Text("Users")) {
                    ForEach(viewModel.users) { (user) in
                        NavigationLink(destination: Text(user.name ?? "-")) {
                            Text(user.name ?? "-")
                        }
                    }
                }
                Section(header: Text("Databases")) {
                    ForEach(viewModel.databases) { (database) in
                        NavigationLink(destination: DBView(viewModel: .init(id: database.id))) {
                            Text(database.title.first?.plainText ?? database.id)
                        }
                    }
                }
                Section(header: Text("Pages")) {
                    ForEach(viewModel.pages) { (page) in
                        NavigationLink(destination: Text(page.id)) {
                            Text(page.id)
                        }
                    }
                }
            }.navigationBarItems(trailing: Button(action: {
                viewModel.isPresentedAddSheet = true
            }, label: {
                Image(systemName: "plus")
            }))
        }.alert(isPresented: .init(get: { viewModel.error != nil }, set: { _ in viewModel.error = nil })) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: Alert.Button.cancel()
            )
        }.actionSheet(isPresented: $viewModel.isPresentedAddSheet, content: {
            ActionSheet(title: Text("menu"), buttons: [
                .default(Text("Page"), action: {
                    viewModel.createPage()
                })
            ])
        }).onAppear {
            viewModel.fetchUsers()
            viewModel.fetchDatabases()
        }
    }
}

extension RootView {
    class ViewModel: ObservableObject {
        @Environment(\.notion) private var session
        @Published var users: [Object.User] = []
        @Published var databases: [Object.Database] = []
        @Published var pages: [Object.Page] = []
        @Published var error: Error? = nil
        @Published var isPresentedAddSheet: Bool = false
        var cancellables: [AnyCancellable] = []
        
        func fetchUsers() {
            session.send(V1.Users.List()).sink { result in
                switch result {
                case let .success(response):
                    self.users = response.results
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
        
        func fetchDatabases() {
            session.send(V1.Search.Search(query: "")).sink { result in
                switch result {
                case let .success(response):
                    self.databases = response.results.compactMap {
                        if case let .database(database) = $0.object {
                            return database
                        } else {
                            return nil
                        }
                    }
                    self.pages = response.results.compactMap {
                        if case let .page(page) = $0.object {
                            return page
                        } else {
                            return nil
                        }
                    }
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
        
        func createPage() {
            
        }
    }
}

