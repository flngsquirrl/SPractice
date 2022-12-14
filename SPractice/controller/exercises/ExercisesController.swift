//
//  ExercisesController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ExercisesController: ResetableCollectionDataManager<ExerciseTemplate>, ExercisesMainController, ExercisesMainManager {

    static var shared = ExercisesController()

    var dataManager = ExercisesPersistenceManager()

    @Published var searchText = ""
    var newItem: UUID?
    @Published var selected: ExerciseTemplate?

    var sortingPropertyKey: String = "exercisesSortingProperty"
    var sortingOrderKey: String = "exercisesSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var isDataLoaded = false

    override init() {
        super.init()

        initialSetup()
    }
}
