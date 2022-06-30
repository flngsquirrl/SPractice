//
//  AddProgramView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct AddProgramView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var onAdd: (ProgramTemplate) -> Void
    
    @State private var newProgram = ProgramTemplate.template
    @State private var editMode: EditMode = .inactive
    
    init(onAdd: @escaping (ProgramTemplate) -> Void) {
        self.onAdd = onAdd
    }
    
    var body: some View {
        ProgramEditor(for: $newProgram, editMode: $editMode)
            .navigationTitle("New program")
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Add") {
                        onAdd(newProgram)
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

struct AddProgramView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddProgramView(onAdd: { _ in })
        }
    }
}
