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

    init(for template: ProgramTemplate) {
        viewModel = ViewModel(for: template)
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
                        applyNewSettings()
                    }
                    .disabled(!viewModel.hasChangedSettings)
                }
            }
        }
        .accentColor(.customAccentColor)
    }

    func applyNewSettings() {
        viewModel.applyNewSettings()
        dismiss()
    }
}

struct PracticeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeSettingsView(for: ProgramTemplate.personal)
    }
}
