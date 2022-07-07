//
//  ProgramSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct ProgramSummaryView: View{
    var program: ProgramTemplate
    var accentedExerciseId: UUID? = nil
    
    var body: some View {
        ProgramDurationSection(program: program)
        
        Section("Sequence") {
            ForEach(program.preparedExercises) { exercise in
                ExerciseShortView(for: exercise, isIconAccented: accentedExerciseId == exercise.id)
                    .foregroundColor(exercise.isService ? .secondary : .primary)
            }
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
