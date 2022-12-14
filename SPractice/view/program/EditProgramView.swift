//
//  EditProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct EditProgramView: InfoContentHolder {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var infoController = InfoController()

    var onSave: (ProgramTemplate) -> Void

    @ObservedObject private var viewModel: ViewModel

    init(for template: ProgramTemplate, onSave: @escaping (ProgramTemplate) -> Void) {
        self.viewModel = ViewModel(template: template)
        self.onSave = onSave
    }

    var content: some View {
        ProgramEditor(for: $viewModel.template, mode: .edit, editMode: $viewModel.editMode)
            .navigationTitle("Program")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {

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
    }

    func saveChanges(markAsNonExample: Bool = false) {
        let template = viewModel.prepareTemplate(markAsNonExample: markAsNonExample)
        onSave(template)
        dismiss()
    }
}

struct EditProgramView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditProgramView(for: .simpleYoga, onSave: {_ in })
        }
    }
}
