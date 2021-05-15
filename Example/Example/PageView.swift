//
//  PageView.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/05/15.
//

import SwiftUI
import Combine
import Object
import API

struct PageView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.blocks) { block in
                plainText(block: block)
            }
        }
        .navigationTitle(viewModel.page?.retrieveTitle() ?? "Loading")
        .navigationBarItems(trailing: Button(action: {
            viewModel.isPresentedMenuSheet = true
        }, label: {
            Image(systemName: "plus")
        }))
        .onAppear {
            viewModel.fetch()
            viewModel.fetchBlocks()
        }
        .alert(isPresented: .init(get: { viewModel.error != nil }, set: { _ in viewModel.error = nil })) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: Alert.Button.cancel()
            )
        }
        .actionSheet(isPresented: $viewModel.isPresentedMenuSheet, content: {
            ActionSheet(title: Text("menu"), buttons: [
                .default(Text("Add Block"), action: {
                    viewModel.createBlock()
                }),
                .default(Text("Update Property"), action: {
                    viewModel.updateProperty()
                }),
                .cancel()
            ])
        })
    }
    
    @ViewBuilder
    func plainText(block: Block) -> some View {
        switch block.type {
        case let .paragraph(paragraph):
            Text(paragraph.text.first?.plainText ?? "")
        case let .heading1(heading1):
            Text(heading1.text.first?.plainText ?? "")
        case let .heading2(heading2):
            Text(heading2.text.first?.plainText ?? "")
        case let .heading3(heading3):
            Text(heading3.text.first?.plainText ?? "")
        case let .bulletedListItem(bulletedListItem):
            Text(bulletedListItem.text.first?.plainText ?? "")
        case let .numberedListItem(numberedListItem):
            Text(numberedListItem.text.first?.plainText ?? "")
        case let .toDo(toDo):
            Text(toDo.text.first?.plainText ?? "")
        case let .toggle(toggle):
            Text(toggle.text.first?.plainText ?? "")
        case let .childPage(childPage):
            Text(childPage.title)
        case .unsupported:
            Text("-")
        }
    }
}

extension PageView {
    class ViewModel: ObservableObject {
        internal init(id: Page.ID) {
            self.id = id
        }
        
        @Environment(\.notion) private var session
        @Published var page: Object.Page?
        @Published var blocks: [Object.Block] = []
        @Published var error: Error? = nil
        var cancellables: [AnyCancellable] = []
        @Published var isPresentedMenuSheet: Bool = false
        
        let id: Page.ID
        
        func fetch() {
            session.send(V1.Pages.Page(id: id)).sink { result in
                switch result {
                case let .success(response):
                    print(response.properties)
                    self.page = response
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
        
        func createBlock() {
            let block: Block = .init(type: .heading1(.init(text: [.init(type: .text(.init(content: "append line")))])))
            session.send(V1.Blocks.Append(id: id, children: [block])).sink { result in
                switch result {
                case let .success(response):
                    self.blocks = []
                    self.fetchBlocks()
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
        
        func updateProperty() {
            session.send(V1.Pages.Update(id: id, properties: ["title" : .init(type: .title([.init(type: .text(.init(content: "Updated name")))]))])).sink { result in
                switch result {
                case let .success(response):
                    self.page = nil
                    self.fetch()
                    break
                case let .failure(error):
                    self.error = error
                }
            }.store(in: &cancellables)
        }
    }
}

