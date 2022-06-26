//
//  AddProgramView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct AddProgramView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var onAdd: (Program) -> Void
    
    @State private var newTemplate = Program.defaultTemplate
    @State private var editMode: EditMode = .inactive
    
    init(onAdd: @escaping (Program) -> Void) {
        self.onAdd = onAdd
    }
    
    var body: some View {
        ProgramEditor(for: $newTemplate, editMode: $editMode)
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

struct AddProgramView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddProgramView(onAdd: { _ in })
        }
    }
}
