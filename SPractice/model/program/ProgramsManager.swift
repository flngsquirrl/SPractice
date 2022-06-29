//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ProgramsManager: ObservableObject {
    
    @Published private var programs = [ProgramTemplate.personal, ProgramTemplate.dailyShort, ProgramTemplate.shortForBack]
    
    static let shared = ProgramsManager()
    
    private init() {
        for i in 1...3{
            programs.append(ProgramTemplate(name: "Test \(i)", exercises: [ExerciseTemplate.catCow]))
        }
    }
    
    var existingPrograms: [ProgramTemplate] {
        programs
    }
    
    func addNew(program: ProgramTemplate) {
        programs.append(program)
    }
    
    func removeItems(at offsets: IndexSet) {
        programs.remove(atOffsets: offsets)
    }
    
    func update(program: ProgramTemplate) {
        if let index = programs.firstIndex(where: {$0.id == program.id}) {
            programs[index] = program
        }
    }
    
    func delete(program: ProgramTemplate) {
        if let index = programs.firstIndex(where: {$0.id == program.id}) {
            programs.remove(at: index)
        }
    }
}
