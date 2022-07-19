//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class Programs: ObservableObject, DataManager {
    typealias Item = ProgramTemplate
    
    @Published internal var items: [ProgramTemplate] = [ProgramTemplate.personal, ProgramTemplate.dailyShort, ProgramTemplate.shortForBack]
    
    @Published var selection: UUID?
    
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
    
    internal func save() {
//        do {
//            let data = try JSONEncoder().encode(templates)
//            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data.")
//        }
    }
}
