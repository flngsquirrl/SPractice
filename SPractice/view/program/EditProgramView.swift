//
//  EditProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct EditProgramView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var program: ProgramTemplate
    var onSave: (ProgramTemplate) -> Void
    
    @State private var editMode: EditMode = .inactive
    
    init(for template: ProgramTemplate, onSave: @escaping (ProgramTemplate) -> Void) {
        self._program = State<ProgramTemplate>(initialValue: template)
        self.onSave = onSave
    }
    
    var body: some View {
        ProgramEditor(for: $program, editMode: $editMode)
            .navigationTitle("Program")
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(program)
                        dismiss()
                    }
                    .disabled(editMode.isEditing)
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
