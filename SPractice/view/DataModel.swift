//
//  DataModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 25.06.22.
//

import Foundation

@MainActor class DataModel: ObservableObject {
    
    @Published var programTemplates = [ProgramTemplate.personal, ProgramTemplate.dailyShort, ProgramTemplate.shortForBack]
    
    @Published var exerciseTemplates = [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana, ExerciseTemplate.concentration, ExerciseTemplate.catCowDurationNoDuration, ExerciseTemplate.catCowNoType]
    
    func addNewExerciseTemplate(template: ExerciseTemplate) {
        exerciseTemplates.append(template)
    }
    
    func removeExerciseItems(at offsets: IndexSet) {
        exerciseTemplates.remove(atOffsets: offsets)
    }
    
    func moveExerciseItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        exerciseTemplates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
    
    func updateExerciseTemplate(template: ExerciseTemplate) {
        if let index = exerciseTemplates.firstIndex(where: {$0.id == template.id}) {
            exerciseTemplates[index] = template
        }
    }
    
    func deleteExerciseTemplate(template: ExerciseTemplate) {
        if let index = exerciseTemplates.firstIndex(where: {$0.id == template.id}) {
            exerciseTemplates.remove(at: index)
        }
    }
    
    func addNewProgramTemplate(template: ProgramTemplate) {
        programTemplates.append(template)
    }
    
    func removeProgramItems(at offsets: IndexSet) {
        programTemplates.remove(atOffsets: offsets)
    }
    
    func moveProgramItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        programTemplates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
    
    func updateProgramTemplate(template: ProgramTemplate) {
        if let index = programTemplates.firstIndex(where: {$0.id == template.id}) {
            programTemplates[index] = template
        }
    }
    
    func deleteProgramTemplate(template: ProgramTemplate) {
        if let index = programTemplates.firstIndex(where: {$0.id == template.id}) {
            programTemplates.remove(at: index)
        }
    }
}
