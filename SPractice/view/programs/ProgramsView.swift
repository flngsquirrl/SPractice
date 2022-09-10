//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {

    @ObservedObject var programsManager = ProgramsManager.shared

    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ProgramTemplate?

    @State private var showAddNewView = false
    @State private var searchText = ""

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
            List(programsManager.filter(by: searchText)) { program in
                HStack {
                    NavigationLink {
                        ProgramDetailsView(for: program) {
                            programsManager.updateItem($0)
                        } onDelete: {
                            programsManager.deleteItem($0)
                        }
                    } label: {
                        ProgramShortDecorativeView(for: program, isAccented: program.id == selectedToDelete?.id, accentColor: .customAccentColor)
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        selectedToDelete = program
                        showDeleteConfirmation = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
            .listStyle(.insetGrouped)
            .searchable(text: $searchText)
            .disableAutocorrection(true)
            .onChange(of: programsManager.newItem) { _ in
                if programsManager.newItem != nil {
                    withAnimation {
                        proxy.scrollTo(programsManager.newItem!, anchor: .center)
                    }
                }
            }
            .onChange(of: showDeleteConfirmation) { shouldShow in
                if !shouldShow {
                    withAnimation {
                        selectedToDelete = nil
                    }
                }
            }
            .alert(deleteAlertTitle, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
                DeleteAlertContent(item: item) {
                    programsManager.deleteItem($0)
                }
            }
        }
    }

    var deleteAlertTitle: String {
        DeleteAlertConstants.getTitle(isExampleTemplate: selectedToDelete?.isExample ?? false)
    }

    var addItemView: some View {
        AddProgramView {
            programsManager.addItem($0)
        }
    }

    var listToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            SortingControl(sortingProperty: $programsManager.sortingProperty, sortingOrder: $programsManager.sortingOrder) {
                programsManager.setSorting()
            }

            Button {
                showAddNewView = true
            } label: {
                Image(systemName: "plus")
                    .frame(width: 25)
            }
        }
    }

    var secondaryView: some View {
        StabView()
    }

}

struct ProgramsView_Previews: PreviewProvider {

    static var previews: some View {
        ProgramsView()
    }
}
