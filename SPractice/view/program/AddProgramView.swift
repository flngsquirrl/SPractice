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
    
    @StateObject private var viewModel = ViewModel()
    
    init(onAdd: @escaping (ProgramTemplate) -> Void) {
        self.onAdd = onAdd
    }
    
    var body: some View {
        ProgramEditor(for: $viewModel.newTemplate, editMode: $viewModel.editMode)
            .navigationTitle("New program")
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Add") {
                        onAdd(viewModel.newTemplate)
                        dismiss()
                    }
                    .disabled(viewModel.isAddDisabled)
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
