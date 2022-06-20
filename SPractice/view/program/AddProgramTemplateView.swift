//
//  AddProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct AddProgramTemplateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var onAdd: (ProgramTemplate) -> Void
    
    @State private var newTemplate = ProgramTemplate.defaultTemplate
    @State private var editMode: EditMode = .inactive
    
    init(onAdd: @escaping (ProgramTemplate) -> Void) {
        self.onAdd = onAdd
    }
    
    var body: some View {
        ProgramTemplateEditor(for: $newTemplate, editMode: $editMode)
            .navigationTitle("New template")
            .navigationTitle("Program template")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onAdd(newTemplate)
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

struct AddProgramTemplate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddProgramTemplateView(onAdd: { _ in })
        }
    }
}
