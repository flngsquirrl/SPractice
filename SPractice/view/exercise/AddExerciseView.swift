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

    var exercisesManager: any ExercisesMainManager = ExercisesController.shared

    @StateObject private var viewModel = ViewModel()

    init(navigatedFromProgram: Bool = false, onAdd: @escaping (ExerciseTemplate) -> Void) {
        self.navigatedFromProgram = navigatedFromProgram
        self.onAdd = onAdd
    }

    var body: some View {
        NavigationStack {
            ExerciseEditor(for: $viewModel.template, mode: .add, navigatedFromProgram: navigatedFromProgram)
                .navigationTitle("New exercise")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            if viewModel.template.saveAsTemplate {
                                exercisesManager.addItem(viewModel.templateToAdd)
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
