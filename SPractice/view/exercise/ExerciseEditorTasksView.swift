//
//  ExerciseEditorTasksView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import SwiftUI

struct ExerciseEditorTasksView: View {
    
    var exercise: Exercise
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(exercise.tasks) { task in
                        TaskDetailsShortView(task: task, exerciseType: exercise.type)
                    }
                } footer: {
                    switch exercise.type {
                    case .flow, .timer:
                        Text("Intensity and duration of the task are based on the exercise configuration")
                    case .tabata:
                        Text("Sequence and duration of the tasks are based on the general Settings of the application")

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

struct ExerciseEditorTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseEditorTasksView(exercise: Exercise.catCow)
    }
}
