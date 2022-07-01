//
//  PracticeSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct PracticeSummaryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var practice: Practice
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("Duration")
                        Spacer()
                        ProgramDurationView(for: practice.program, mode: .extended)
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Summary")
                } footer: {
                    Text("Duration is the minimal time needed to complete all timer and tabata exercises of the practice, as flow exercises time can't be predicted")
                }
                
                Section("Sequence") {
                    ForEach(practice.program.exercises) { exercise in
                        ExerciseShortView(for: exercise, isIconAccented: practice.currentExercise.id == exercise.id)
                            .foregroundColor(exercise.isService ? .secondary : .primary)
                    }
                }
            }
            .navigationTitle(practice.program.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
}

struct PracticeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeSummaryView(practice: Practice(from: ProgramTemplate.personal))
    }
}
