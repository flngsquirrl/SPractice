//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @ObservedObject var selectionManager = ProgramSelectionManager.shared
    
    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ProgramTemplate?
    
    @State private var showAddNewView = false
    
    var body: some View {
        NavigationView {
            list
                .navigationTitle("Programs")
                .sheet(isPresented: $showAddNewView) {
                    addItemView
                }
                .toolbar {
                    listToolbar
                }
            
            secondaryView
        }
        .accentColor(.customAccentColor)
    }
    
    var list: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(viewModel.programs) { program in
                    HStack {
                        NavigationLink(tag: program.id, selection: $selectionManager.selection) {
                            ProgramDetailsView(for: program) {
                                viewModel.updateItem($0)
                            } onDelete: {
                                viewModel.deleteItem($0)
                            }
                        } label: {
                            ProgramShortDecorativeView(for: program, isAccented: program.id == selectedToDelete?.id, accentColor: .customAccentColor)
                        }
                    }
                }
                .onDelete { indexSet in
                    showDeleteConfirmation = true
                    selectedToDelete = viewModel.getElement(index: indexSet.first!)
                }
            }
            .listStyle(.inset)
            .onChange(of: showDeleteConfirmation) { shouldShow in
                if !shouldShow {
                    withAnimation {
                        selectedToDelete = nil
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .disableAutocorrection(true)
            .onChange(of: selectionManager.newItem) { _ in
                if selectionManager.newItem != nil {
                    withAnimation {
                        proxy.scrollTo(selectionManager.newItem!, anchor: .center)
                    }
                }
            }
            .alert(DeleteAlertConstants.title, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
                DeleteAlertContent(item: item) {
                    viewModel.deleteItem($0)
                }
            } message: { _ in
                DeleteAlertConstants.messageText
            }
        }
    }
    
    var addItemView: some View {
        AddProgramView() {
            viewModel.addItem($0)
        }
    }
    
    var listToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button() {
                showAddNewView = true
            } label: {
                Image(systemName: "plus")
                    .frame(width: 25)
            }
            
            SortingMenu(sortProperty: $viewModel.sortProperty, sortOrder: $viewModel.sortOrder) {
                viewModel.setSorting()
            }
        }
    }
    
    var secondaryView: some View {
        WelcomeView()
    }
    
}

struct ProgramsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProgramsView()
    }
}
