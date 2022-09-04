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
                HStack {
                    let isExerciseValid = ValidationService.isValidToPractice(exercise)
                    ExerciseShortView(for: exercise) {
                        ExerciseIcon(for: exercise.exerciseType, isIconAccented: !isExerciseValid, accentColor: .red)
                    }
                    .foregroundColor(exercise.isService ? .secondary : .primary)
                    Button {
                        selectedExercise = exercise
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .sheet(item: $selectedExercise) { item in
            ProgramExerciseInfoView(exercise: item)
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
