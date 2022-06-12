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
        
        var newExercise: ExerciseTemplate?
        
        private var id: UUID
        var isEditMode: Bool
        
        init() {
            self.isEditMode = false
            self.id = UUID()
        }
        
        init(for template: ProgramTemplate) {
            _name = Published(initialValue: template.name)
            _addRest = Published(initialValue: template.useRest)
            _exercises = Published(initialValue: template.exercises)
            
            self.isEditMode = true
            self.id = template.id
        }
        
        func prepareNewProgramTemplate() -> ProgramTemplate {
            ProgramTemplate(id: id, name: name, useRest: addRest, exercises: exercises)
        }
        
        func addNewExerciseTemplates(templates: [ExerciseTemplate]) {
            exercises.append(contentsOf: templates)
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
        
        func removeItems(at offsets: IndexSet) {
            exercises.remove(atOffsets: offsets)
        }
    }
}
