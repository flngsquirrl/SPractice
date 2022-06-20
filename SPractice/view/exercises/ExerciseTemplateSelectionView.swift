//
//  ExerciseTemplateSelectionView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExerciseTemplateSelectionView: View {
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    private var onFinished: ([ExerciseTemplate]) -> Void
    
    init(onFinished: @escaping ([ExerciseTemplate]) -> Void) {
        self.onFinished = onFinished
    }

    var body: some View {
        NavigationView {
            List {
                Section("Existing") {
                    ForEach(viewModel.templates) { template in
                        SelectionRow(template: template) {
                            viewModel.onAdd(template: $0)
                        }
                    }
                }
                
                Section("To add (\(viewModel.selections.count))") {
                    ForEach(viewModel.selections) { template in
                        SelectionRow(template: template, isAdded: true) {
                            viewModel.onDelete(template: $0)
                        }
                    }
                    .onDelete { viewModel.removeItems(at: $0) }
                }
            }
            .navigationTitle("Templates")
            .toolbar {
                ToolbarItemGroup {
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
                    withAnimation {
                        action(template)
                    }
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
