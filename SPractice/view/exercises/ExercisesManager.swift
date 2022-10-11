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

    var dataManager: ExercisesPersistenceManager
    var controller: ExercisesController

    private init() {
        dataManager = ExercisesPersistenceManager()
        controller = ExercisesController(items: dataManager.list())
    }
}
