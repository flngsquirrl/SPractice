//
//  ProgramExamplesManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.10.22.
//

import Foundation

@MainActor class ProgramExamplesManager: ExamplesManager {

    typealias Item = ProgramTemplate

    var mainController: any ProgramsMainManager = ProgramsController.shared

    func isExampleExist(exampleId: String) -> Bool {
        mainController.listItems().contains {$0.exampleId == exampleId}
    }

    func getExample(exampleId: String) -> Item? {
        mainController.listItems().first {$0.exampleId == exampleId}
    }

    func restoreExample(_ item: Item) {
        mainController.addItem(prepareExample(from: item))
    }

    func resetExample(_ item: Item) {
        mainController.updateItem(item)
    }

    func prepareExample(from template: Item) -> Item {
        ProgramTemplate(from: template)
    }

    static var defaultExamples: [Item] {
        [.simpleYoga, .simpleWorkout]
    }
}
