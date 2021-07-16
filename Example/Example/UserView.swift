//
//  UserView.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/15.
//

import SwiftUI
import Combine
import notion

struct UserView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Text(viewModel.user?.id ?? "-")
            Text(viewModel.user?.name ?? "-")
            Text(viewModel.user?.avatarUrl ?? "-")
            switch viewModel.user?.type {
            case .bot:
                Text("bot")
            case let .person(person):
                Text("person")
                Text(person.email)
            case .none:
                Text("-")
            }
        }.onAppear {
            viewModel.fetch()
        }.alert(isPresented: .init(get: { viewModel.error != nil }, set: { _ in viewModel.error = nil })) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: Alert.Button.cancel()
            )
        }
    }
}

extension UserView {
    class ViewModel: ObservableObject {
        internal init(id: User.ID) {
            self.id = id
        }
        
        @Environment(\.notion) private var session
        @Published var user: Object.User?
        @Published var error: Error? = nil
        var cancellables: [AnyCancellable] = []
        let id: User.ID
        
        func fetch() {
            session.send(V1.Users.Retrieve(id: id)).sink { result in
                switch result {
                case let .success(response):
                    self.user = response
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
    }
}

