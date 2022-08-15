//
//  AddExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct AddExerciseView: View {
    
    @Environment(\.dismiss) var dismiss
    var onAdd: (ExerciseTemplate) -> Void
    
    @StateObject private var viewModel = ViewModel()
    
    init(onAdd: @escaping (ExerciseTemplate) -> Void) {
        self.onAdd = onAdd
    }
    
    var body: some View {
        NavigationView {
            ExerciseEditor(for: $viewModel.template, mode: .add)
                .navigationTitle("New exercise")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            onAdd(viewModel.templateToAdd)
                            dismiss()
                        }
                        .disabled(viewModel.isAddDisabled)
                    }
                    
                    ToolbarItemGroup(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
        }
        .accentColor(.customAccentColor)
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView() { _ in }
    }
}
