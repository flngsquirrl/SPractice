//
//  ProgramsPersistenceManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

class ProgramsPersistenceManager: JsonPersistenceManager<ProgramTemplate> {

    override var defaultItems: [ProgramTemplate] {
        [.simpleYoga, .simpleWorkout]
    }

    override func getFileName() -> String {
        "Programs"
    }
}
