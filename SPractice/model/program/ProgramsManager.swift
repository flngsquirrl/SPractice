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
    }
    
    var filteredPrograms: [Program] {
        if searchText.isEmpty {
            return programs
        } else {
            return programs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
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
