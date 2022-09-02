//
//  ExercisesManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

@MainActor class ExercisesManager: MainList {

    static let shared = ExercisesManager()

    var dataManager = Exercises.shared
    var newItem: UUID?

    var sortingPropertyKey: String = "exercisesSortingProperty"
    var sortingOrderKey: String = "exercisesSortingOrder"
    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    @Published var items = Exercises.shared.items
    var defaultExamples = ExerciseTemplate.defaultExamples

    init() {
        initialSetup()
    }

    func prepareExample(from item: ExerciseTemplate) -> ExerciseTemplate {
        ExerciseTemplate(from: item)
    }

}
