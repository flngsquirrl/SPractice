//
//  PracticeSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct PracticeSummaryView: InfoContentHolder {

    @Environment(\.dismiss) var dismiss

    var practice: Practice

    @MainActor
    var content: some View {
        NavigationStack {
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
                                    .foregroundColor(.customAccentColor)
                            }

                            ExerciseShortView(for: exercise) {
                                ExerciseIcon(for: exercise.type)
                            }
                            .foregroundColor(exercise.isService ? .secondary : .primary)
                        }
                        .rowLeadingAligned()
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
        PracticeSummaryView(practice: Practice(for: .simpleYoga, with: PracticeSettings(programId: ProgramTemplate.simpleYoga.id)))
    }
}
