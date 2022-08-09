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
        
        var sortPropertyKey: String = "exercisesSortProperty"
        var sortOrderKey: String = "exercisesSortOrder"
        var sortProperty: SortProperty = .date
        var sortOrder: SortOrder = .desc
        
        @Published var items = Exercises.shared.items
        
        init() {
            initialSetup()
        }
        
        var exercises: [ExerciseTemplate] {
            filteredElements
        }
    }
}
