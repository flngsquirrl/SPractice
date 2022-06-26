//
//  DataModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 25.06.22.
//

import Foundation

@MainActor class DataModel: ObservableObject {
    
    @Published var programTemplates = [Program.personal, Program.dailyShort, Program.shortForBack]
    
    @Published var exerciseTemplates = [Exercise.catCow, Exercise.surjaNamascar, Exercise.vasihsthasana, Exercise.concentration, Exercise.catCowDurationNoDuration, Exercise.catCowNoType]
    
    func addNewExerciseTemplate(template: Exercise) {
        exerciseTemplates.append(template)
    }
    
    func removeExerciseItems(at offsets: IndexSet) {
        exerciseTemplates.remove(atOffsets: offsets)
    }
    
    func moveExerciseItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        exerciseTemplates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
    
    func updateExerciseTemplate(template: Exercise) {
        if let index = exerciseTemplates.firstIndex(where: {$0.id == template.id}) {
            exerciseTemplates[index] = template
        }
    }
    
    func deleteExerciseTemplate(template: Exercise) {
        if let index = exerciseTemplates.firstIndex(where: {$0.id == template.id}) {
            exerciseTemplates.remove(at: index)
        }
    }
    
    func addNewProgramTemplate(template: Program) {
        programTemplates.append(template)
    }
    
    func removeProgramItems(at offsets: IndexSet) {
        programTemplates.remove(atOffsets: offsets)
    }
    
    func moveProgramItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        programTemplates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
    
    func updateProgramTemplate(template: Program) {
        if let index = programTemplates.firstIndex(where: {$0.id == template.id}) {
            programTemplates[index] = template
        }
    }
    
    func deleteProgramTemplate(template: Program) {
        if let index = programTemplates.firstIndex(where: {$0.id == template.id}) {
            programTemplates.remove(at: index)
        }
    }
}
