//
//  PracticeSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.08.22.
//

import SwiftUI

struct PracticeSettingsView: View {

    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: ViewModel

    @State private var showApplyConfirmation = false

    init(for practice: Practice) {
        viewModel = ViewModel(for: practice)
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    Group {
                        Toggle("Add rest intervals", isOn: $viewModel.settings.addRestIntervals.animation())
                        Toggle("Pause after exercise", isOn: $viewModel.settings.pauseAfterExercise.animation())
                    }
                    .tint(.customAccentColor)
                    .disabled(!viewModel.hasMultipleExercises)
                } footer: {
                    SettingsLinkView(text: "Rest intervals configuration is based on", settingsSubGroup: .rest)
                }
            }
            .navigationTitle("Practice settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        if viewModel.shouldGetConfirmationForApply {
                            showApplyConfirmation = true
                        } else {
                            applyNewSettings()
                        }
                    }
                    .disabled(!viewModel.hasChangedSettings)
                }
            }
            .alert("Practice should be reset for applying new settings.", isPresented: $showApplyConfirmation) {
                resetButton
                cancelButton
            }
        }
        .accentColor(.customAccentColor)
    }

    var cancelButton: some View {
        Button("Cancel", role: .cancel) {
        }
    }

    var resetButton: some View {
        Button("Reset") {
            applyNewSettings()
        }
    }

    func applyNewSettings() {
        viewModel.applyNewSettings()
        dismiss()
    }
}

struct PracticeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeSettingsView(for: Practice(for: ProgramTemplate.personal))
    }
}
