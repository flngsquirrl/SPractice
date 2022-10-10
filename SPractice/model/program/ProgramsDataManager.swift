//
//  ProgramsDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

class ProgramsDataManager: JsonPersistentDataManager<ProgramTemplate> {

    override var defaultItems: [ProgramTemplate] {
        [.simpleYoga, .simpleWorkout]
    }

    override func getFileName() -> String {
        "Programs"
    }
}
