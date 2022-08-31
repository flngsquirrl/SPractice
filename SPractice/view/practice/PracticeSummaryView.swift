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
                ProgramDurationSection(program: practice.program)
                
                Section("Sequence") {
                    let count = practice.program.exercises.count
                    ForEach(0..<count, id: \.self) { index in
                        let exercise = practice.program.exercises[index]
                        HStack {
                            Button {
                                practice.moveToExercise(withIndex: index)
                                dismiss()
                            } label: {
                                Image(systemName: practice.currentExerciseIndex == index ? "checkmark.circle.fill" : "arrow.forward.circle")
                                    .foregroundColor(.lightOrange)
                            }
                            
                            ExerciseShortView(for: exercise) {
                                ExerciseIcon(for: exercise.exerciseType)
                            }
                            .foregroundColor(exercise.isService ? .secondary : .primary)
                       }
                    }
                }
            }
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
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
        PracticeSummaryView(practice: Practice(for: .personal, with: PracticeSettings(programId: ProgramTemplate.personal.id)))
    }
}
