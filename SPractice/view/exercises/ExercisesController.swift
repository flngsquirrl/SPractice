//
//  ExercisesController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ExercisesController: ResetableCollectionDataManager<ExerciseTemplate>, MainList {

    @Published var searchText = ""

    var sortingPropertyKey: String = "exercisesSortingProperty"
    var sortingOrderKey: String = "exercisesSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var newItem: UUID?
    @Published var selected: ExerciseTemplate?

    init(items: [ExerciseTemplate]) {
        super.init()

        add(items)
        initialSetup()
    }

    func getItems() -> [ExerciseTemplate] {
        list()
    }
}
