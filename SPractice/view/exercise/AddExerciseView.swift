//
//  AddExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct AddExerciseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var navigatedFromProgram: Bool = false
    var onAdd: (ExerciseTemplate) -> Void
    
    @StateObject private var viewModel = ViewModel()
    
    init(navigatedFromProgram: Bool = false, onAdd: @escaping (ExerciseTemplate) -> Void) {
        self.navigatedFromProgram = navigatedFromProgram
        self.onAdd = onAdd
    }
    
    var body: some View {
        NavigationView {
            ExerciseEditor(for: $viewModel.template, mode: .add, navigatedFromProgram: navigatedFromProgram)
                .navigationTitle("New exercise")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            if viewModel.template.saveAsTemplate {
                                ExercisesManager.shared.addItem(viewModel.templateToAdd)
                            }
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
        AddExerciseView { _ in }
    }
}
