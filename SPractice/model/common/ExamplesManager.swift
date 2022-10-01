//
//  ExamplesManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.08.22.
//

import Foundation

@MainActor protocol ExamplesManager {
    associatedtype Item: ExampleItem

    func isExampleExist(exampleId: String) -> Bool
    func getExample(exampleId: String) -> Item?

    func restoreExample(_ item: Item)
    func resetExample(_ item: Item)

    var modifiedExamplesNames: [String] {get}
    var deletedExamplesNames: [String] {get}
}

protocol ExampleItem: Named {

    var isExample: Bool {get}
    var exampleId: String? {get}

    static var defaultExamples: [Self] {get}

    static func prepareExample(from: Self) -> Self

    func isEqualToExample(example: Self) -> Bool
    mutating func resetToExample(example: Self)
}

extension ExamplesManager {

    var defaultExamples: [Self.Item] {
        Self.Item.defaultExamples
    }

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

    var modifiedExamplesNames: [String] {
        var names: [String] = []
        for example in defaultExamples {
            let item = getExample(exampleId: example.exampleId!)
            if let item = item {
                let isModified = !item.isEqualToExample(example: example)
                if isModified {
                    names.append(example.name)
                }
            }
        }
        return names
    }

    var deletedExamplesNames: [String] {
        var names: [String] = []
        for example in defaultExamples {
            let exampleExists = isExampleExist(exampleId: example.exampleId!)
            if !exampleExists {
                names.append(example.name)
            }
        }

        return names
    }
}
