//
//  EditExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct EditExerciseView: InfoContentHolder {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var infoController = InfoController()

    @ObservedObject private var viewModel: ViewModel

    var onSave: (ExerciseTemplate) -> Void

    init(for template: ExerciseTemplate, onSave: @escaping (ExerciseTemplate) -> Void) {
        self.viewModel = ViewModel(template: template)
        self.onSave = onSave
    }

    var content: some View {
        ExerciseEditor(for: $viewModel.editorTemplate, mode: .edit)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    SaveItemToolbarButton {
                        viewModel.showExampleUpdateConfirmation
                    } onSave: {
                        saveChanges(markAsNonExample: $0)
                    }
                    .disabled(viewModel.isSaveDisabled)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Exercise")
            .navigationBarTitleDisplayMode(.inline)
    }

    func saveChanges(markAsNonExample: Bool = false) {
        let template = viewModel.prepareTemplate(markAsNonExample: markAsNonExample)
        onSave(template)
        dismiss()
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditExerciseView(for: ExerciseTemplate.catCow) { _ in }
                .environmentObject(SettingsManager())
        }
    }
}
