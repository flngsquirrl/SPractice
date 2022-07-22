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
            List(exercise.tasks) { task in
                TaskDetailsShortView(task: task, exerciseType: exercise.exerciseType)
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
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
