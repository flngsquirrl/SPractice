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
        NavigationStack {
            ProgramEditor(for: $viewModel.newTemplate, mode: .add, editMode: $viewModel.editMode)
                .navigationTitle("New program")
                .navigationBarTitleDisplayMode(.inline)
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
        .accentColor(.customAccentColor)
    }
}

struct AddProgramView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddProgramView(onAdd: { _ in })
        }
    }
}
