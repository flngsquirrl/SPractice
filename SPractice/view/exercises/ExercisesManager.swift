//
//  ExercisesManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

@MainActor class ExercisesManager: MainList {
    
    static let shared = ExercisesManager()
        
    typealias Element = ExerciseTemplate
    
    var dataManager = Exercises.shared
    var newItem: UUID?
    
    var sortingPropertyKey: String = "exercisesSortingProperty"
    var sortingOrderKey: String = "exercisesSortingOrder"
    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc
    
    @Published var items = Exercises.shared.items
    
    init() {
        initialSetup()
    }
    
    func areAnyExamplesDeleted() -> Bool {
        for example in ExerciseTemplate.defaultExamples {
            let exampleExists = items.contains {$0.exampleId == example.exampleId}
            if !exampleExists {
                return true
            }
        }
        
        return false
    }
    
    func areAnyExamplesModified() -> Bool {
        for example in ExerciseTemplate.defaultExamples {
            let item = items.first {$0.exampleId == example.exampleId}
            if let item = item {
                let isModified = !item.isEqualToExample(example: example)
                if isModified {
                    return true
                }
            }
        }
        
        return false
    }
}
