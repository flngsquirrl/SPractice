//
//  ExamplesSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct ExamplesSettingsView: View {

    @StateObject var viewModel = ViewModel()

    @ObservedObject var programsManager = ProgramsManager.shared
    @ObservedObject var exercisesManager = ExercisesManager.shared

    enum RestoreGroup: String, CaseIterable {
        case all
        case programs
        case exercises
    }

    var body: some View {
        HStack {
            Text("Templates for")
            Spacer()
            Picker("Type of templates", selection: $viewModel.restoreGroup) {
                ForEach(RestoreGroup.allCases, id: \.self) { group in
                    Text(group.rawValue)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
        }

        Section {
            Button("Restore deleted") {
                withAnimation {
                    viewModel.restoreDeleted()
                }
            }
            .disabled(!viewModel.hasDeletedItems)
        } footer: {
            VStack {
                Text(viewModel.restoreFooterText)
            }
        }

        Section {
            Button("Reset modified", role: .destructive) {
                withAnimation {
                    viewModel.resetModified()
                }
            }
            .disabled(!viewModel.hasModifiedItems)
        } footer: {
            Text(viewModel.resetFooterText)
        }
    }
}

struct ExamplesSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ExamplesSettingsView()
            }
        }
    }
}
