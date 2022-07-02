//
//  ProgramSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct ProgramSummaryView: View {
    var template: ProgramTemplate
    
    var body: some View {
        ProgramDurationSection(template: template)
        
        Section("Sequence") {
            ForEach(template.exercises) { exercise in
                ExerciseShortView(for: exercise, displayDuration: true)
                    .foregroundColor(exercise.isService ? .secondary : .primary)
            }
        }
    }
}

struct ProgramSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramSummaryView(template: ProgramTemplate.personal)
        }
    }
}
