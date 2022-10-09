//
//  ProgramsDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ProgramsDataManager: JsonPersistentDataManager<ProgramTemplate> {

    override func getDefaultItems() -> [ProgramTemplate] {
        ProgramTemplate.defaultExamples
    }

    override func getFileName() -> String {
        "Programs"
    }
}
