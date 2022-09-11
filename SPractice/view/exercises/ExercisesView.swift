//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View {

    @ObservedObject private var exercisesManager = ExercisesManager.shared

    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ExerciseTemplate?

    @State private var showAddNewView = false
    @State private var searchText = ""

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
            detail
        }
        .navigationSplitViewStyle(.balanced)
        .accentColor(.customAccentColor)
    }

    var list: some View {
        ScrollViewReader { proxy in
            let exercises = exercisesManager.filter(by: searchText)
            List(exercises, selection: $exercisesManager.selected) { exercise in
                NavigationLink(value: exercise) {
                    let isAccented = exercise.id == selectedToDelete?.id
                    ExerciseShortDecorativeView(for: exercise, isIconAccented: isAccented, isNameAccented: isAccented, isFilled: true)
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
            .searchable(text: $searchText)
            .disableAutocorrection(true)
            .onChange(of: exercisesManager.newItem) { _ in
                if exercisesManager.newItem != nil {
                    withAnimation {
                        proxy.scrollTo(exercisesManager.newItem!, anchor: .center)
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
        if let selected = exercisesManager.selected {
            ExerciseDetailsView(for: selected) {
                exercisesManager.updateItem($0)
            } onDelete: {
                exercisesManager.deleteItem($0)
            }
        } else {
            secondaryView
        }
    }

    var listToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            SortingControl(sortingProperty: $exercisesManager.sortingProperty, sortingOrder: $exercisesManager.sortingOrder) {
                exercisesManager.setSorting()
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

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
