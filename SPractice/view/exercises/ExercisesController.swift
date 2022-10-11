//
//  ExercisesController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ExercisesController: ResetableCollectionDataManager<ExerciseTemplate>, ExercisesMainController, ExercisesMainManager {

    static var shared = ExercisesController()

    var persistenceManager = ExercisesPersistenceManager()

    @Published var searchText = ""

    var sortingPropertyKey: String = "exercisesSortingProperty"
    var sortingOrderKey: String = "exercisesSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var newItem: UUID?
    @Published var selected: ExerciseTemplate?

    var isLoaded = false

    func getItems() -> [ExerciseTemplate] {
        if !isLoaded {
            add(persistenceManager.list())
            initialSetup()

            isLoaded = true
        }

        return list()
    }
}
