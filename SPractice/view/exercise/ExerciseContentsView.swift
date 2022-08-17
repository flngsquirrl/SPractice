//
//  ExerciseContentsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.08.22.
//

import SwiftUI

struct ExerciseContentsView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(exercise: ExerciseTemplate) {
        viewModel = ViewModel(for: exercise)
    }
    
    var body: some View {
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
    }
}

struct ExerciseContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseContentsView(exercise: ExerciseTemplate.catCow)
    }
}
