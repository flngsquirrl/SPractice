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
        NavigationView {
            list
                .navigationTitle("Exercises")
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
                ForEach(exercisesManager.filter(by: searchText)) { exercise in
                    HStack {
                        NavigationLink {
                            ExerciseDetailsView(for: exercise) {
                                exercisesManager.updateItem($0)
                            } onDelete: {
                                exercisesManager.deleteItem($0)
                            }
                        } label: {
                            let isAccented = exercise.id == selectedToDelete?.id
                            ExerciseShortDecorativeView(for: exercise, isIconAccented: isAccented, isNameAccented: isAccented, isFilled: true)
                        }
                    }
                }
                .onDelete { indexSet in
                    showDeleteConfirmation = true
                    selectedToDelete = exercisesManager.getItem(index: indexSet.first!)
                }
            }
            .listStyle(.insetGrouped)
            .onChange(of: showDeleteConfirmation) { shouldShow in
                if !shouldShow {
                    withAnimation {
                        selectedToDelete = nil
                    }
                }
            }
            .searchable(text: $searchText)
            .disableAutocorrection(true)
            .onChange(of: exercisesManager.newItem) { _ in
                if exercisesManager.newItem != nil {
                    withAnimation {
                        proxy.scrollTo(exercisesManager.newItem!, anchor: .center)
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
        WelcomeView()
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
