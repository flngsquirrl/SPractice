//
//  ExercisesDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

class ExercisesPersistenceManager: JsonPersistenceDataManager<ExerciseTemplate> {

    override var defaultItems: [ExerciseTemplate] {
        ExerciseExamplesManager.defaultExamples
    }

    override func getFileName() -> String {
        "Exercises"
    }
}
