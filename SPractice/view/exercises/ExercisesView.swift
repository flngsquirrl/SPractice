//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @ObservedObject var selectionManager = ExerciseSelectionManager.shared
    
    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ExerciseTemplate?
    
    @State private var showAddNewView = false
    
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
                ForEach(viewModel.exercises) { exercise in
                    HStack {
                        NavigationLink {
                            ExerciseDetailsView(for: exercise) {
                                viewModel.updateItem($0)
                            } onDelete: {
                                viewModel.deleteItem($0)
                            }
                        } label: {
                            let isAccented = exercise.id == selectedToDelete?.id
                            ExerciseShortDecorativeView(for: exercise, isIconAccented: isAccented, isNameAccented: isAccented, isFilled: true)
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
        AddExerciseView() {
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
            
            SortingControl(sortingProperty: $viewModel.sortingProperty, sortingOrder: $viewModel.sortingOrder) {
                viewModel.applySorting()
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
