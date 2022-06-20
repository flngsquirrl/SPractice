//
//  EditProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct EditProgramTemplateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var template: ProgramTemplate
    var onSave: (ProgramTemplate) -> Void
    
    @State private var editMode: EditMode = .inactive
    
    init(for template: ProgramTemplate, onSave: @escaping (ProgramTemplate) -> Void) {
        self._template = State<ProgramTemplate>(initialValue: template)
        self.onSave = onSave
    }
    
    var body: some View {
        ProgramTemplateEditor(for: $template, editMode: $editMode)
            .navigationTitle("Program template")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(template)
                        dismiss()
                    }
                    .disabled(editMode.isEditing)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
    }
}

struct EditProgramTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProgramTemplateView(for: ProgramTemplate.personal, onSave: {_ in })
        }
    }
}
