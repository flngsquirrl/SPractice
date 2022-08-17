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
        
        Section("Sequence") {
            ForEach(program.exercises) { exercise in
                HStack {
                    ExerciseShortView(for: exercise, icon: ExerciseIconButton(for: exercise.exerciseType, isIconAccented: true, accentColor: ValidationService.isValidToPractice(exercise) ? .accentColor : .red) { selectedExercise = exercise })
                        .foregroundColor(exercise.isService ? .secondary : .primary)
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
            ProgramSummaryView(program: ProgramTemplate.personal)
        }
    }
}
