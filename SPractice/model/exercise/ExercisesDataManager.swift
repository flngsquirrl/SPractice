//
//  ExercisesDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ExercisesDataManager: JsonPersistentDataManager<ExerciseTemplate> {

    override func getDefaultItems() -> [ExerciseTemplate] {
        ExerciseTemplate.defaultExamples
    }

    override func getFileName() -> String {
        "Exercises"
    }
}
