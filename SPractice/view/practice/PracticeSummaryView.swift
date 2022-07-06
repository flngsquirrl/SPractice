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
                            
                            ExerciseShortView(for: exercise, isIconAccented: false)
                                .foregroundColor(exercise.isService ? .secondary : .primary)
                            }

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
