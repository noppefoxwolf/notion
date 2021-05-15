//
//  DBView.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/15.
//

import SwiftUI
import Combine
import Object
import API

struct DatabaseView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.pages) { page in
                NavigationLink(destination: PageView(viewModel: .init(id: page.id))) {
                    Text(page.retrieveTitle() ?? page.id)
                }
            }
        }.navigationBarItems(trailing: Button(action: {
            viewModel.isPresentedMenuSheet = true
        }, label: {
            Image(systemName: "plus")
        }))
        .navigationTitle(viewModel.database?.title.first?.plainText ?? "Loading")
        .onAppear {
            viewModel.fetch()
            viewModel.fetchPages()
        }.alert(isPresented: .init(get: { viewModel.error != nil }, set: { _ in viewModel.error = nil })) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: Alert.Button.cancel()
            )
        }.actionSheet(isPresented: $viewModel.isPresentedMenuSheet, content: {
            ActionSheet(title: Text("menu"), buttons: [
                .default(Text("Page"), action: {
                    viewModel.createPage()
                }),
                .cancel()
            ])
        })
    }
}

extension DatabaseView {
    class ViewModel: ObservableObject {
        internal init(id: Database.ID) {
            self.id = id
        }
        
        @Environment(\.notion) private var session
        @Published var database: Object.Database? = nil
        @Published var pages: [Object.Page] = []
        @Published var error: Error? = nil
        @Published var isPresentedMenuSheet: Bool = false
        var cancellables: [AnyCancellable] = []
        let id: Database.ID
        
        func fetch() {
            session.send(V1.Databases.Database(id: id)).sink { result in
                switch result {
                case let .success(response):
                    self.database = response
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
        
        func fetchPages() {
            session.send(V1.Databases.Query(id: id)).sink { result in
                switch result {
                case let .success(response):
                    self.pages = response.results
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
        
        func createPage() {
            session.send(V1.Pages.Create(parent: .init(type: .databaseId(id)), properties: [:], children: [.init(type: .heading1(.init(text: [.init(type: .text(.init(content: "new page")))])))])).sink { result in
                switch result {
                case let .success(response):
                    self.pages = []
                    self.fetchPages()
                    break
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
    }
}
