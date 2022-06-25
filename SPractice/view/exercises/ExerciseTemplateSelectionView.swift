//
//  ExerciseTemplateSelectionView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExerciseTemplateSelectionView: View {
    
    enum TemplatesGroup: String, CaseIterable {
        case all = "list.bullet"
        case selected = "checkmark"
    }
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    private var onFinished: ([ExerciseTemplate]) -> Void
    
    init(onFinished: @escaping ([ExerciseTemplate]) -> Void) {
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
                            Image(systemName: group.rawValue)
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
    
    struct SelectionRow: View {
        var template: ExerciseTemplate
        var isAdded: Bool = false
        var action: (ExerciseTemplate) -> Void

        var body: some View {
            HStack {
                Button() {
                    action(template)
                } label: {
                    Image(systemName: isAdded ? "minus.circle.fill" : "plus.circle.fill")
                }
                ExerciseDetailsShortView(for: template, displayDuration: true)
                
            }
        }
    }
}

struct ExerciseTemplateSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTemplateSelectionView() { _ in }
    }
}
