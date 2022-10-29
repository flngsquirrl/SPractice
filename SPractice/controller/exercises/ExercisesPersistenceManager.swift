//
//  ExercisesDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

class ExercisesPersistenceManager: JsonPersistenceManager<ExerciseTemplate> {

    override var defaultItems: [ExerciseTemplate] {
        [.catCow, .surjaNamascarA, .balasana, .vasisthasana, .shavasana, .plank, .squats, .jumpRope]
    }

    override func getFileName() -> String {
        "Exercises"
    }
}
