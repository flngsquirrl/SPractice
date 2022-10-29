//
//  AddProgramView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct AddProgramView: InfoContentHolder, AddProcessor {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var infoController = InfoController()

    var onAdd: ((ProgramTemplate) -> Void)?

    @StateObject private var viewModel = ViewModel()

    var content: some View {
        NavigationStack {
            ProgramEditor(for: $viewModel.newTemplate, mode: .add, editMode: $viewModel.editMode)
                .navigationTitle("New program")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .confirmationAction) {
                        Button("Add") {
                            onAdd?(viewModel.templateToSave)
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
