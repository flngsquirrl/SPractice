//
//  PracticeExerciseInfoView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.08.22.
//

import SwiftUI

struct PracticeExerciseInfoView: View {

    @Environment(\.dismiss) var dismiss

    var exercise: PracticeExercise

    var body: some View {
        NavigationStack {
            List {
                ExercisePropertiesView(exercise: exercise)

                if showTasks {
                    ExerciseTasksButton(tasks: exercise.tasks)
                }
            }
            .navigationTitle("Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }

    var showTasks: Bool {
        exercise.type == .tabata
    }
}

struct PracticeExerciseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeExerciseInfoView(exercise: PracticeExercise(from: ExerciseTemplate.catCow)!)
    }
}
