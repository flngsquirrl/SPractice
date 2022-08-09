//
//  ExercisesView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

extension ExercisesView {
    @MainActor class ViewModel: MainList {
        
        typealias Element = ExerciseTemplate
        
        var dataManager = Exercises.shared
        var selectionManager = ExerciseSelectionManager.shared
        
        @Published var searchText = ""
        
        var sortingPropertyKey: String = "exercisesSortingProperty"
        var sortingOrderKey: String = "exercisesSortingOrder"
        var sortingProperty: SortingProperty = .date
        var sortingOrder: SortingOrder = .desc
        
        @Published var items = Exercises.shared.items
        
        init() {
            initialSetup()
        }
        
        var exercises: [ExerciseTemplate] {
            filteredElements
        }
    }
}
