//
//  ProgramSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct ProgramSummaryView: View {
    var program: PreparedProgram
    
    var body: some View {
        ProgramDurationSection(program: program)
        
        Section("Sequence") {
            ForEach(program.exercises) { exercise in
                ExerciseShortView(for: exercise, isIconAccented: !ValidationService.isValidToPractice(exercise), accentColor: .red)
                    .foregroundColor(exercise.isService ? .secondary : .primary)
            }
        }
    }
}

struct ProgramSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramSummaryView(program: PreparedProgram.personal)
        }
    }
}
