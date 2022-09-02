//
//  ProgramExerciseInfoView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.08.22.
//

import SwiftUI

struct ProgramExerciseInfoView: View {

    @Environment(\.dismiss) var dismiss

    var exercise: ExerciseTemplate

    var body: some View {
        NavigationView {
            ExerciseContentsView(exercise: exercise)
                .navigationTitle("Exercise")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
        }
        .navigationViewStyle(.stack)
        .accentColor(.customAccentColor)
    }

    var showTasks: Bool {
        exercise.type == .tabata
    }
}

struct ProgramExerciseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramExerciseInfoView(exercise: ExerciseTemplate.catCow)
    }
}
