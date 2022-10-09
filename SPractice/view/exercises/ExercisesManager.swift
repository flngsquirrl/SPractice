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

    var dataManager: ExercisesDataManager
    var controller: ExercisesController

    init() {
        dataManager = ExercisesDataManager()
        controller = ExercisesController(items: dataManager.list())
    }
}
