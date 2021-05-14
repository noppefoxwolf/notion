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

struct ContentView: View {
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
                        Text(database.title[0].plainText)
                    }
                }
            }.navigationBarItems(trailing: Button {
                viewModel.fetch()
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle")
            })
        }.alert(isPresented: .init(get: { viewModel.error != nil }, set: { _ in viewModel.error = nil })) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: Alert.Button.cancel()
            )
        }
    }
}

import Combine

class ViewModel: ObservableObject {
    @Published var users: [Object.User] = []
    @Published var databases: [Object.Database] = []
    @Published var error: Error? = nil
    let session = Session.shared
    var cancellables: [AnyCancellable] = []
    
    init() {
        session.setAuthorization(token: "<<AUTHORIZE TOKEN>>")
    }
    
    func fetch() {
        session.send(V1.Users.List()).sink { result in
            switch result {
            case let .success(response):
                self.users = response.results
            case let .failure(error):
                self.error = error
            }
        }.store(in: &cancellables)
        
        session.send(V1.Databases.List()).sink { result in
            switch result {
            case let .success(response):
                self.databases = response.results
            case let .failure(error):
                self.error = error
            }
        }.store(in: &cancellables)
    }
}
