//
//  NewProgramView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension NewProgramView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name = ""
        @Published var addRest = true
        @Published var exercises: [ExerciseTemplate] = []
        
        func prepareNewProgramTemplate() -> ProgramTemplate {
            ProgramTemplate(name: name, useRest: addRest, exercises: exercises)
        }
        
        func addNewExerciseTemplate(template: ExerciseTemplate) {
            exercises.append(template)
        }
    }
}
