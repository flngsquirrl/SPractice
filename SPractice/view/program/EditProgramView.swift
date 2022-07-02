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
        ProgramEditor(for: $viewModel.template, editMode: $viewModel.editMode)
            .navigationTitle("Program")
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(viewModel.template)
                        dismiss()
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
}

struct EditProgramView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProgramView(for: ProgramTemplate.personal, onSave: {_ in })
        }
    }
}
