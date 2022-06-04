//
//  ProgramTemplateView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension ProgramTemplateView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name = ""
        @Published var addRest = true
        @Published var exercises: [ExerciseTemplate] = []
        
        private var id: UUID
        var navigationTitle: String
        @Published private var isEditMode: Bool
        
        init() {
            self.isEditMode = false
            self.id = UUID()
            
            self.navigationTitle = "New program"
        }
        
        init(for template: ProgramTemplate) {
            _name = Published(initialValue: template.name)
            _addRest = Published(initialValue: template.useRest)
            _exercises = Published(initialValue: template.exercises)
            
            self.isEditMode = true
            self.id = template.id
            
            self.navigationTitle = template.name
        }
        
        func prepareNewProgramTemplate() -> ProgramTemplate {
            ProgramTemplate(name: name, useRest: addRest, exercises: exercises)
        }
        
        func addNewExerciseTemplate(template: ExerciseTemplate) {
            exercises.append(template)
        }
        
        func updateExerciseTemplate(template: ExerciseTemplate) {
            if let index = exercises.firstIndex(where: {$0.id == template.id}) {
                exercises[index] = template
            }
        }
        
        func validateProgram() {
            // check name and number of exercised
        }
    }
}
