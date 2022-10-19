//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

protocol ListComponentsProvider {

    associatedtype Item: ManagedItem
    associatedtype ShortView: View
    associatedtype DetailsView: View

    var title: String {get}
    func getShortView(item: Item) -> ShortView
    func getDetailsView(item: Item) -> DetailsView
}

struct ListView<T: ListComponentsProvider, C: Controller>: View where T.Item == ExerciseTemplate, C.Item == T.Item {

    @ObservedObject var controller: C

    var componentsProvider: T

    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: C.Item?

    @State private var showAddNewView = false

    var body: some View {
        NavigationSplitView {
            list
                .navigationTitle(componentsProvider.title)
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
            List(controller.filteredItems, selection: $controller.selected) { item in
                NavigationLink(value: item) {
                    componentsProvider.getShortView(item: item)
                }
                .rowLeadingAligned()
                .swipeActions(edge: .trailing) {
                    SwipeDeleteButton {
                        selectedToDelete = item
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
                    controller.deleteItem($0)
                }
            }
        }
    }

    var deleteAlertTitle: String {
        DeleteAlertConstants.getTitle(isExampleTemplate: selectedToDelete?.isExample ?? false)
    }

    var addItemView: some View {
        AddExerciseView {
            controller.addItem($0)
        }
    }

    @ViewBuilder var detail: some View {
        if let selected = controller.selected {
            componentsProvider.getDetailsView(item: selected)
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

struct ExercisesView: View {

    @ObservedObject var controller = ExercisesController.shared

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

    func getShortView(exercise: ExerciseTemplate) -> some View {
        let isAccented = exercise.id == selectedToDelete?.id
        return ExerciseShortDecorativeView(for: exercise, isAccented: isAccented)
    }

    func getDetailsView(exercise: ExerciseTemplate) -> some View {
        ExerciseDetailsView(for: exercise) {
            controller.updateItem($0)
        } onDelete: {
            controller.deleteItem($0)
        }
    }

    var list: some View {
        ScrollViewReader { proxy in
            List(controller.filteredItems, selection: $controller.selected) { exercise in
                NavigationLink(value: exercise) {
                    getShortView(exercise: exercise)
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
                    controller.deleteItem($0)
                }
            }
        }
    }

    var deleteAlertTitle: String {
        DeleteAlertConstants.getTitle(isExampleTemplate: selectedToDelete?.isExample ?? false)
    }

    var addItemView: some View {
        AddExerciseView {
            controller.addItem($0)
        }
    }

    @ViewBuilder var detail: some View {
        if let selected = controller.selected {
            getDetailsView(exercise: selected)
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
