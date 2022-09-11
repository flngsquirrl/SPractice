//
//  ProgramSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct ProgramSummaryView: View {

    var program: ProgramTemplate
    @State private var selectedExercise: ExerciseTemplate?

    var body: some View {
        ProgramDurationSection(program: program)

        Section("Exercises (\(program.exercises.count))") {
            ForEach(program.exercises) { exercise in
                NavigationLink(value: exercise) {
                    let isExerciseValid = ValidationService.isValidToPractice(exercise)
                    ExerciseShortView(for: exercise) {
                        ExerciseIcon(for: exercise.exerciseType, isIconAccented: !isExerciseValid, accentColor: .red)
                    }
                }
                .navigationDestination(for: ExerciseTemplate.self) { exercise in
                    ExerciseContentsView(exercise: exercise)
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
