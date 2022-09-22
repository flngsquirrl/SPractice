//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View {

    @ObservedObject var exercisesManager = ExercisesManager.shared
    @ObservedObject var controller = ExercisesManager.shared.controller

    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ExerciseTemplate?

    @State private var showAddNewView = false

    var body: some View {
        NavigationSplitView {
            list
                .navigationTitle("Exercises")
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
            List(controller.filteredItems, selection: $controller.selected) { exercise in
                NavigationLink(value: exercise) {
                    let isAccented = exercise.id == selectedToDelete?.id
                    ExerciseShortDecorativeView(for: exercise, isAccented: isAccented)
                }
                .rowLeadingAligned()
                .swipeActions(edge: .trailing) {
                    SwipeDeleteButton {
                        selectedToDelete = exercise
                        showDeleteConfirmation = true

                    }
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
            .onChange(of: showDeleteConfirmation) { isShown in
                if !isShown {
                    withAnimation {
                        selectedToDelete = nil
                    }
                }
            }
            .alert(deleteAlertTitle, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
                DeleteAlertContent(item: item) {
                    exercisesManager.deleteItem($0)
                }
            }
        }
    }

    var deleteAlertTitle: String {
        DeleteAlertConstants.getTitle(isExampleTemplate: selectedToDelete?.isExample ?? false)
    }

    var addItemView: some View {
        AddExerciseView {
            exercisesManager.addItem($0)
        }
    }

    @ViewBuilder var detail: some View {
        if let selected = controller.selected {
            ExerciseDetailsView(for: selected) {
                exercisesManager.updateItem($0)
            } onDelete: {
                exercisesManager.deleteItem($0)
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

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
