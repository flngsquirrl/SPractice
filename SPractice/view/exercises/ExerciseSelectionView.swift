//
//  ExerciseSelectionView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExerciseSelectionView: View {
    
    enum TemplatesGroup: String, CaseIterable {
        case all = "all"
        case selected = "selected"
    }
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass
    
    private var onFinished: ([Exercise]) -> Void
    
    init(onFinished: @escaping ([Exercise]) -> Void) {
        self.onFinished = onFinished
    }

    var body: some View {
        NavigationView {
            List {
                if viewModel.templatesGroup == .all {
                    Section {
                        ForEach(viewModel.searchableTemplates) { template in
                            SelectionRow(template: template) {
                                viewModel.onAdd(template: $0)
                            }
                        }
                    } header: {
                        HStack {
                            Text("All")
                            Spacer()
                            Text("(\(viewModel.selections.count)) to be added")
                        }
                    }
                } else {
                    Section {
                        ForEach(viewModel.searchableTemplates) { template in
                            SelectionRow(template: template, isAdded: true) {
                                viewModel.onDelete(template: $0)
                            }
                            .transition(.opacity)
                        }
                        .onDelete { viewModel.removeItems(at: $0) }
                    } header: {
                        HStack {
                            Text("To be added (\(viewModel.selections.count))")
                            Spacer()
                            Button("Clear all") { viewModel.clearSelections() }
                                .disabled(viewModel.selections.isEmpty)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
            .navigationTitle("Templates")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Group of templates", selection: $viewModel.templatesGroup.animation()) {
                        ForEach(TemplatesGroup.allCases, id: \.self) { group in
                            if sizeClass == .compact {
                                Image(systemName: getImageName(for: group))
                            } else {
                                Text(group.rawValue)
                            }
                        }
                    }
                    .fixedSize()
                    .pickerStyle(.segmented)
                }
                    
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        onFinished(viewModel.selections)
                        dismiss()
                    }
                    .disabled(viewModel.selections.isEmpty)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
    
    func getImageName(for type: TemplatesGroup) -> String {
        switch type {
        case .all:
            return "list.bullet"
        case .selected:
            return "checkmark"
        }
    }
    
    struct SelectionRow: View {
        var template: Exercise
        var isAdded: Bool = false
        var action: (Exercise) -> Void

        var body: some View {
            HStack {
                Button() {
                    action(template)
                } label: {
                    Image(systemName: isAdded ? "minus.circle.fill" : "plus.circle.fill")
                }
                ExerciseShortView(for: template, displayDuration: true)
                
            }
        }
    }
}

struct ExerciseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSelectionView() { _ in }
    }
}
