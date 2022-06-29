//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ProgramsManager: ObservableObject {
    
    @Published private var programs = [Program.personal, Program.dailyShort, Program.shortForBack]
    
    static let shared = ProgramsManager()
    
    private init() {
        for i in 1...3{
            programs.append(Program(name: "Test \(i)", exercises: [Exercise.catCow]))
        }
    }
    
    var existingPrograms: [Program] {
        programs
    }
    
    func addNew(program: Program) {
        programs.append(program)
    }
    
    func removeItems(at offsets: IndexSet) {
        programs.remove(atOffsets: offsets)
    }
    
    func update(program: Program) {
        if let index = programs.firstIndex(where: {$0.id == program.id}) {
            programs[index] = program
        }
    }
    
    func delete(program: Program) {
        if let index = programs.firstIndex(where: {$0.id == program.id}) {
            programs.remove(at: index)
        }
    }
}
