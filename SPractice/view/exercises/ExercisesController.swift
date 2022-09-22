//
//  ExercisesController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ExercisesController: MainController {

    @Published var searchText = ""

    var sortingPropertyKey: String = "exercisesSortingProperty"
    var sortingOrderKey: String = "exercisesSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var newItem: UUID?
    @Published var selected: ExerciseTemplate?
    @Published var items: [ExerciseTemplate]

    init(items: [ExerciseTemplate]) {
        self.items = items
        initialSetup()
    }

}
