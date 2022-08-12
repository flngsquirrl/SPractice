//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

@MainActor class ProgramsManager: MainList {
    
    static let shared = ProgramsManager()
    
    typealias Element = ProgramTemplate
    
    var dataManager = Programs.shared
    var newItem: UUID?
    
    var sortingPropertyKey: String = "programsSortingProperty"
    var sortingOrderKey: String = "programsSortingOrder"
    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc
    
    @Published var items = Programs.shared.items
    
    init() {
        initialSetup()
    }
    
    func areAnyExamplesDeleted() -> Bool {
        !items.contains {$0.exampleId == ProgramExampleId.simple}
    }
    
    func areAnyExamplesModified() -> Bool {
        let example = items.first {$0.exampleId == ProgramExampleId.simple}
        if let example = example {
            return !example.isEqualToExample(example: ProgramTemplate.simple)
        } else {
            return false
        }
    }
    
    func resetModifiedExamples() {
        let example = items.first {$0.exampleId == ProgramExampleId.simple}
        if var example = example {
            example.resetToExample(example: ProgramTemplate.simple)
            updateItem(example)
        }
    }
    
    func restoreDeletedExamples() {
        addItem(ProgramTemplate.simple)
    }
}
