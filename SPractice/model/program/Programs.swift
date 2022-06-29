//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class Programs: ObservableObject {
    
    @Published private(set) var templates: [ProgramTemplate] = [ProgramTemplate.personal, ProgramTemplate.dailyShort, ProgramTemplate.shortForBack]
    
    static let shared = Programs()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Programs")

    private init() {
//        do {
//            let data = try Data(contentsOf: savePath)
//            templates = try JSONDecoder().decode([ProgramTemplate].self, from: data)
//        } catch {
//            templates = []
//        }
    }
    
    private func save() {
//        do {
//            let data = try JSONEncoder().encode(templates)
//            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data.")
//        }
    }
    
    func addNew(_ program: ProgramTemplate) {
        templates.append(program)
        save()
    }
    
    func removeItems(at offsets: IndexSet) {
        templates.remove(atOffsets: offsets)
        save()
    }
    
    func update(_ program: ProgramTemplate) {
        if let index = templates.firstIndex(where: {$0.id == program.id}) {
            templates[index] = program
            save()
        }
    }
    
    func delete(_ program: ProgramTemplate) {
        if let index = templates.firstIndex(where: {$0.id == program.id}) {
            templates.remove(at: index)
            save()
        }
    }
}
