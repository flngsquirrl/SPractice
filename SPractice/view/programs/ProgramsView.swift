//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {

    @EnvironmentObject var infoManager: InfoManager

    @ObservedObject var programsManager = ProgramsManager.shared
    @ObservedObject var controller = ProgramsManager.shared.controller

    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ProgramTemplate?

    @State private var showAddNewView = false

    var body: some View {
        NavigationSplitView {
            list
                .navigationTitle("Programs")
                .sheet(isPresented: $showAddNewView) {
                    addItemView
                }
                .toolbar {
                    listToolbar
                }
        } detail: {
            detail.addInfoPanel()
        }
        .navigationSplitViewStyle(.balanced)
        .accentColor(.customAccentColor)
    }

    var list: some View {
        ScrollViewReader { proxy in
            List(controller.filteredItems, selection: $controller.selected) { program in
                NavigationLink(value: program) {
                    ProgramShortDecorativeView(for: program, isAccented: program.id == selectedToDelete?.id, accentColor: .customAccentColor)
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
            .searchable(text: $controller.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .disableAutocorrection(true)
            .onChange(of: controller.newItem) { newItem in
                if let newItem {
                    withAnimation {
                        proxy.scrollTo(newItem, anchor: .center)
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

    @ViewBuilder var detail: some View {
        if let selected = controller.selected {
            NavigationStack {
                ProgramDetailsView(for: selected) {
                    programsManager.updateItem($0)
                } onDelete: {
                    programsManager.deleteItem($0)
                }
            }
            .navigationDestination(for: ExerciseTemplate.self) { exercise in
                ExerciseContentsView(exercise: exercise)
            }
        } else {
            StabView()
        }
    }

    var listToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            SortingControl(sortingProperty: $controller.sortingProperty, sortingOrder: $controller.sortingOrder) {
                controller.setSorting()
            }

            Button {
                showAddNewView = true
            } label: {
                Image(systemName: "plus")
                    .frame(width: 25)
            }
        }
    }

}

struct ProgramsView_Previews: PreviewProvider {

    static var previews: some View {
        ProgramsView()
    }
}
