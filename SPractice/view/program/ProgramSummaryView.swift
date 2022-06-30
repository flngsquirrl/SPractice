//
//  ProgramSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct ProgramSummaryView: View {
    var program: Program
    var accentedExercise: Exercise? = nil
    
    var body: some View {
        Section {
            HStack {
                Text("Duration")
                Spacer()
                Text(ClockTime.getExtendedPresentation(for: program.duration!))
            }
        } header: {
            Text("Summary")
        } footer: {
            Text("Duration is the minimal time needed to complete all timer and tabata exercises of the practice, as flow exercises time can't be predicted")
        }
        
        Section("Sequence") {
            ForEach(program.exercises) { exercise in
                ExerciseShortView(for: exercise, isIconAccented: accentedExercise?.id == exercise.id)
                    .foregroundColor(exercise.isService ? .secondary : .primary)
            }
        }
    }
}

struct ProgramSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramSummaryView(program: Program(from: ProgramTemplate.personal))
        }
    }
}
