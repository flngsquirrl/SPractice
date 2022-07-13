//
//  ExerciseTasksView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import SwiftUI

struct ExerciseTasksView: View {
    
    var exercise: PracticeExercise
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(exercise.tasks) { task in
                        TaskDetailsShortView(task: task, exerciseType: exercise.exerciseType)
                    }
                } footer: {
                    switch exercise.exerciseType {
                    case .flow, .timer:
                        Text("Intensity and duration of the task are based on the exercise configuration")
                    case .tabata:
                        SettingsLinkView(text: "Sequence and duration of the tasks are based on the general", settingsSubGroup: .tabata)
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
}

struct ExerciseTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTasksView(exercise: PracticeExercise.vasihsthasana)
    }
}
