//
//  EditProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct EditProgramView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var onSave: (ProgramTemplate) -> Void
    
    @ObservedObject private var viewModel: ViewModel
    
    init(for template: ProgramTemplate, onSave: @escaping (ProgramTemplate) -> Void) {
        self.viewModel = ViewModel(template: template)
        self.onSave = onSave
    }
    
    var body: some View {
        ProgramEditor(for: $viewModel.template, mode: .edit, editMode: $viewModel.editMode)
            .navigationTitle("Edit program")
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
        NavigationView {
            EditProgramView(for: ProgramTemplate.personal, onSave: {_ in })
        }
    }
}
