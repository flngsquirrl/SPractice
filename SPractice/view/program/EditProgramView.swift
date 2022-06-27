//
//  EditProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct EditProgramView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var program: Program
    var onSave: (Program) -> Void
    
    @State private var editMode: EditMode = .inactive
    
    init(for template: Program, onSave: @escaping (Program) -> Void) {
        self._program = State<Program>(initialValue: template)
        self.onSave = onSave
    }
    
    var body: some View {
        ProgramEditor(for: $program, editMode: $editMode)
            .navigationTitle("Program")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(program)
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

struct EditProgramView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProgramView(for: Program.personal, onSave: {_ in })
        }
    }
}
