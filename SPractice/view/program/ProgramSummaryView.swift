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
        Section {
            HStack {
                Text("Duration")
                Spacer()
                ProgramDurationView(for: template, mode: .extended)
                    .foregroundColor(.secondary)
            }
        } header: {
            Text("Summary")
        } footer: {
            Text("Duration is the minimal time needed to complete all timer and tabata exercises of the practice, as flow exercises time can't be predicted")
        }
        
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
