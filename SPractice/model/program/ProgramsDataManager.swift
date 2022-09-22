//
//  ProgramsDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ProgramsDataManager: ObservableObject, PersistentDataManager {

    typealias Item = ProgramTemplate

    @Published internal var items: [ProgramTemplate]

    let savePath = FileManager.documentsDirectory.appendingPathComponent("Programs")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([ProgramTemplate].self, from: data)
        } catch {
            items = ProgramTemplate.defaultExamples
        }

//        for lots of items
//
//        let templates = [.simpleYoga, ProgramTemplate.dailyShort, ProgramTemplate.shortForBack]
//        var programs: [ProgramTemplate] = []
//        for template in templates {
//            for i in 1...25 {
//                var program = ProgramTemplate(from: template)
//                program.name += " \(i)"
//                programs.append(program)
//            }
//        }
//
//        items = programs
    }

    internal func save() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
