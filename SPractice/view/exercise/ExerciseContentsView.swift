//
//  ExerciseContentsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.08.22.
//

import SwiftUI

struct ExerciseContentsView: InfoContentHolder {

    @ObservedObject private var viewModel: ViewModel
    @ObservedObject var infoController = InfoController()

    init(exercise: ExerciseTemplate) {
        viewModel = ViewModel(for: exercise)
    }

    var content: some View {
        List {
            ExercisePropertiesView(exercise: viewModel.exercise)

            if viewModel.showTasks {
                Section {
                    ExerciseTasksButton(tasks: viewModel.tasks)
                } footer: {
                    SettingsLinkView(text: "Sequence and duration of the tasks are based on", settingsSubGroup: .tabata)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct ExerciseContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseContentsView(exercise: ExerciseTemplate.catCow)
    }
}
