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
        
        @Binding var template: Program
        
        init(for template: Binding<Program>) {
            self._template = template
        }
        
        func addNewExerciseTemplates(exercises: [Exercise]) {
            template.exercises.append(contentsOf: exercises)
        }
        
        func addNewExerciseTemplate(exercise: Exercise) {
            template.exercises.append(exercise)
        }
        
        func updateExerciseTemplate(exercise: Exercise) {
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