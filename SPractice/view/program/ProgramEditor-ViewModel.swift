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
        
        func addNewExercises(exercises: [ExerciseTemplate]) {
            template.templateExercises.append(contentsOf: exercises)
        }
        
        func addNewExercise(exercise: ExerciseTemplate) {
            template.templateExercises.append(exercise)
        }
        
        func updateExercise(exercise: ExerciseTemplate) {
            if let index = template.templateExercises.firstIndex(where: {$0.id == exercise.id}) {
                template.templateExercises[index] = exercise
            }
        }
        
        func removeItems(at offsets: IndexSet) {
            template.templateExercises.remove(atOffsets: offsets)
        }
        
        func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
            template.templateExercises.move(fromOffsets: fromOffsets, toOffset: toOffsets)
        }
        
        var preparedProgram: PreparedProgram {
            PreparedProgram(from: template)
        }
    }
}
