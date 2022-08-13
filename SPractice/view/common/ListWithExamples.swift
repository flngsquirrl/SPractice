//
//  ListWithExamples.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.08.22.
//

import Foundation

@MainActor protocol ListWithExamples {
    associatedtype Item: ExampleItem
    
    var defaultExamples: [Item] {get}
    
    func isExampleExist(exampleId: String) -> Bool
    func getExample(exampleId: String) -> Item?
    
    func prepareExample(from: Item) -> Item
    func restoreExample(_ item: Item)
    func resetExample(_ item: Item)
}

protocol ExampleItem {
    var exampleId: String? {get}
    
    func isEqualToExample(example: Self) -> Bool
    mutating func resetToExample(example: Self)
}

extension ListWithExamples {
    func areAnyExamplesDeleted() -> Bool {
        for example in defaultExamples {
            let exampleExists = isExampleExist(exampleId: example.exampleId!)
            if !exampleExists {
                return true
            }
        }
        
        return false
    }
    
    func areAnyExamplesModified() -> Bool {
        for example in defaultExamples {
            let item = getExample(exampleId: example.exampleId!)
            if let item = item {
                let isModified = !item.isEqualToExample(example: example)
                if isModified {
                    return true
                }
            }
        }
        
        return false
    }
    
    func restoreDeletedExamples() {
        for example in defaultExamples {
            let exampleExists = isExampleExist(exampleId: example.exampleId!)
            if !exampleExists {
                restoreExample(example)
            }
        }
    }
    
    func resetModifiedExamples() {
        for example in defaultExamples {
            let item = getExample(exampleId: example.exampleId!)
            if var item = item {
                let isModified = !item.isEqualToExample(example: example)
                if isModified {
                    item.resetToExample(example: example)
                    resetExample(item)
                }
            }
        }
    }
}
