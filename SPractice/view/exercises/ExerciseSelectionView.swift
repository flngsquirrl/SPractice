//
//  ExerciseSelectionView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExerciseSelectionView: View {
    
    enum ItemsGroup: String, CaseIterable {
        case all
        case prepared
    }
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    private var onAdd: ([ExerciseTemplate]) -> Void
    
    init(onAdd: @escaping ([ExerciseTemplate]) -> Void) {
        self.onAdd = onAdd
    }

    var body: some View {
        NavigationView {
            List {
                if viewModel.itemsGroup == .all {
                    Section {
                        ForEach(viewModel.filteredExercises) { template in
                            SelectionRow(template: template) {
                                viewModel.onAdd(template: $0)
                            }
                        }
                    } header: {
                        HStack {
                            Text("All")
                        }
                    }
                } else {
                    Section {
                        ForEach(viewModel.filteredExercises) { template in
                            SelectionRow(template: template, isAdded: true) {
                                viewModel.onDelete(template: $0)
                            }
                            .transition(.opacity)
                        }
                        .onDelete { viewModel.removeItems(at: $0) }
                    } header: {
                        HStack {
                            Text("To be added (\(viewModel.preparedExercises.count))")
                            Spacer()
                            Button("Delete") { viewModel.deleteFiltered() }
                                .disabled(viewModel.preparedExercises.isEmpty)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
            .disableAutocorrection(true)
            .navigationTitle("Templates")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Group of templates", selection: $viewModel.itemsGroup.animation()) {
                        ForEach(ItemsGroup.allCases, id: \.self) { group in
                            Image(systemName: getImageName(for: group))
                        }
                    }
                    .fixedSize()
                    .pickerStyle(.segmented)
                }
                    
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add (\(viewModel.preparedExercises.count))") {
                        onAdd(viewModel.preparedExercises)
                        dismiss()
                    }
                    .disabled(viewModel.preparedExercises.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
    
    func getImageName(for group: ItemsGroup) -> String {
        switch group {
        case .all:
            return "list.bullet"
        case .prepared:
            return "plus"
        }
    }
    
    struct SelectionRow: View {
        var template: ExerciseTemplate
        var isAdded: Bool = false
        var action: (ExerciseTemplate) -> Void

        var body: some View {
            HStack {
                Button() {
                    action(template)
                } label: {
                    Image(systemName: isAdded ? "minus.circle" : "plus.circle")
                }
                ExerciseShortView(for: template, displayDetails: true)
            }
        }
    }
}

struct ExerciseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSelectionView() { _ in }
    }
}
