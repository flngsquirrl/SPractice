//
//  ProgramEditor-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import Foundation
import SwiftUI

extension ProgramEditor {
    @MainActor class ViewModel: ObservableObject {
        
        @Binding var template: ProgramTemplate
        
        init(for template: Binding<ProgramTemplate>) {
            self._template = template
        }
        
        var preparedProgram: PreparedProgram {
            PreparedProgram(from: template)
        }
        
        func addNewExercises(exercises: [ExerciseTemplate]) {
            template.exercises.append(contentsOf: exercises)
        }
        
        func addNewExercise(exercise: ExerciseTemplate) {
            template.exercises.append(exercise)
        }
        
        func updateExercise(exercise: ExerciseTemplate) {
            if let index = template.exercises.firstIndex(where: {$0.id == exercise.id}) {
                template.exercises[index] = exercise
            }
        }
        
        func removeItems(at offsets: IndexSet) {
            template.exercises.remove(atOffsets: offsets)
        }
        
        func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
            template.exercises.move(fromOffsets: fromOffsets, toOffset: toOffsets)
        }
    }
}
