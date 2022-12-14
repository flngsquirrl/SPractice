//
//  PracticeExerciseInfoView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.08.22.
//

import SwiftUI

struct PracticeExerciseInfoView: InfoContentHolder {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var infoController = InfoController()

    var exercise: PracticeExercise

    var content: some View {
        NavigationStack {
            List {
                ExercisePropertiesView(exercise: exercise)

                if showTasks {
                    TasksButton(tasks: exercise.tasks)
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
        PracticeExerciseInfoView(exercise: PracticeExercise.catCow)
    }
}
