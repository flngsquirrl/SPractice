//
//  ProgramSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct ProgramSummaryView: View {

    var program: ProgramTemplate

    let exerciseValidator = ExerciseValidator()

    var body: some View {
        ProgramDurationSection(program: program)

        Section("Exercises (\(program.exercises.count))") {
            ForEach(program.exercises) { exercise in
                NavigationLink(value: exercise) {
                    let isExerciseValid = exerciseValidator.isValidToPractice(exercise)
                    ExerciseShortView(for: exercise) {
                        ExerciseIcon(for: exercise.exerciseType, isIconAccented: !isExerciseValid, accentColor: .red)
                    }
                }
                .rowLeadingAligned()
            }
        }
    }
}

struct ProgramSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramSummaryView(program: .simpleYoga)
        }
    }
}
