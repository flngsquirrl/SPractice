//
//  ExercisesManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

class ExercisesManager: MainManager {

    typealias Item = ExerciseTemplate

    static let shared = ExercisesManager()

    var controller: ExercisesController
    var dataManager = Exercises.shared

    init() {
        controller = ExercisesController(items: Exercises.shared.items)
    }
}
