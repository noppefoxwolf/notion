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

struct DBView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.blocks) { block in
                switch block.type {
                case let .heading1(heading):
                    Text(heading.text.first?.plainText ?? "")
                case let .paragraph(paragraph):
                    Text(paragraph.text.first?.plainText ?? "")
                case .unsupported:
                    Text("")
                default:
                    Text("block")
                }
            }
        }
        .navigationTitle(viewModel.database?.id ?? "Loading")
        .onAppear {
            viewModel.fetch()
            viewModel.fetchBlocks()
        }.alert(isPresented: .init(get: { viewModel.error != nil }, set: { _ in viewModel.error = nil })) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: Alert.Button.cancel()
            )
        }
    }
}

extension DBView {
    class ViewModel: ObservableObject {
        internal init(id: Database.ID) {
            self.id = id
        }
        
        @Environment(\.notion) private var session
        @Published var database: Object.Database? = nil
        @Published var blocks: [Object.Block] = []
        @Published var error: Error? = nil
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
        
        func fetchBlocks() {
            session.send(V1.Blocks.Children(id: id)).sink { result in
                switch result {
                case let .success(response):
                    self.blocks = response.results
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
    }
}



