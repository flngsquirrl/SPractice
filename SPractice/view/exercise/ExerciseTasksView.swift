//
//  ExerciseTasksView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.10.22.
//

import SwiftUI

struct ExerciseTasksView: View {

    @EnvironmentObject var settingsManager: SettingsManager
    @ObservedObject var viewModel: ViewModel

    init(for exercise: ExerciseTemplate) {
        self.viewModel = ViewModel(exercise: exercise)
    }

    var body: some View {
        TasksButton(tasks: viewModel.tasks)
    }
}

struct ExerciseTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTasksView(for: .catCow)
    }
}
